Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWESUtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWESUtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWESUtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:49:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:63435 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964836AbWESUtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:49:53 -0400
Message-ID: <62331.192.18.1.5.1148071784.squirrel@housecafe.dyndns.org>
Date: Fri, 19 May 2006 21:49:44 +0100 (BST)
Subject: SCSI ABORT with 2.6.17-rc4-mm1
From: "Christian Kujau" <evil@g-house.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
User-Agent: SquirrelMail/1.5.2 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:f96d4aaab3db5f10cc75fadfe8b23b1e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for repost, local MTA problems here...]

Hi list, Hi Andrew,

I cannot boot 2.6.17-rc4-mm1 because my rootdisk is a scsi disk and upon
scsi-init (SYM53C8XX_2) I'm getting:

May 19 15:39:55 prinz sym0: <895> rev 0x1 at pci 0000:02:09.0 irq 161
May 19 15:39:55 prinz sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
May 19 15:39:55 prinz sym0: SCSI BUS has been reset.
May 19 15:39:55 prinz scsi0 : sym-2.2.3
May 19 15:40:08 prinz 0:0:0:0: ABORT operation started.
May 19 15:40:13 prinz 0:0:0:0: ABORT operation timed-out.
May 19 15:40:13 prinz 0:0:0:0: DEVICE RESET operation started.
May 19 15:40:18 prinz 0:0:0:0: DEVICE RESET operation timed-out.
May 19 15:40:18 prinz 0:0:0:0: BUS RESET operation started.
May 19 15:40:23 prinz 0:0:0:0: BUS RESET operation timed-out.
May 19 15:40:23 prinz 0:0:0:0: HOST RESET operation started.
May 19 15:40:23 prinz sym0: SCSI BUS has been reset.
May 19 15:40:28 prinz 0:0:0:0: HOST RESET operation timed-out.
May 19 15:40:28 prinz 0:0:0:0: scsi: Device offlined - not ready after
error recovery
May 19 15:40:33 prinz 0:0:1:0: ABORT operation started.
May 19 15:40:38 prinz 0:0:1:0: ABORT operation timed-out.
May 19 15:40:38 prinz 0:0:1:0: DEVICE RESET operation started.
May 19 15:40:43 prinz 0:0:1:0: DEVICE RESET operation timed-out.
May 19 15:40:43 prinz 0:0:1:0: BUS RESET operation started.

I have backed out drivers-scsi-use-array_size-macro.patch, but to no
avail. There are other scsi-related patches in the broken-out
mm-directory, any hint which one to try first? Sometimes they're dependent
on each other, so I find it not easy to just "patch -R" all "*scsi*.patch"
files.

Please see http://www.nerdbynature.de/bits/2.6.17-rc4-mm1/  for a
netsconsole-dmesg for 2.6.17-rc4 (working fine) and a the -mm1.

I've tried different .configs for -mm1, created with:

- yes ''  | make oldconfig (config-2.6-mm.2.6.17-rc4-mm1.oldconfig_default)
- yes 'N' | make oldconfig (config-2.6-mm.2.6.17-rc4-mm1.oldconfig_no)
- make oldlconfig (interactive, config-2.6-mm.2.6.17-rc4-mm1.oldconfig_my)

Thanks,
Christian.
-- 
BOFH excuse #442:

Trojan horse ran out of hay


-- 
BOFH excuse #442:

Trojan horse ran out of hay

