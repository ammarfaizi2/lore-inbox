Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWEVObg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWEVObg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWEVObg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:31:36 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:17613 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1750857AbWEVObf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:31:35 -0400
Date: Mon, 22 May 2006 16:30:48 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: usb-serial ipaq kernel problem
Message-ID: <20060522143043.GA6408@fks.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.812,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.09,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

We are having problems with the usb-serial ipaq driver in 2.6.16 (debian
backports 2.6.16-1-686, but also reproducible with self-compiled
kernel.org kernel)

Sometimes, we get the following on disconnect:

Unable to handle kernel paging request at virtual address 723d4ec3
 printing eip:
b01ea93d
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: ppp_async crc_ccitt ppp_generic slhc ipaq usbserial uhci_hcd ohci_hcd usbhid ehci_hcd usbcore 8139too mii sr_mod sbp2 scsi_mod ieee1394 psmouse ide_generic ide_cd cdrom genrtc ext3 jbd mbcache ide_disk generic via82cxxx ide_core evdev mousedev
CPU:    0
EIP:    0060:[<b01ea93d>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16-1-686 #2)
EIP is at check_tty_count+0x33/0x7a
eax: 723d4e4f   ebx: 00000000   ecx: c97cb000   edx: c97cb170
esi: cbfe55a0   edi: 00000283   ebp: c97cb000   esp: cbe87f18
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 4, threadinfo=cbe86000 task=cbfdfab0)
Stack: <0>c97cb000 b01eb558 c97cb000 b029719d 00000000 00000000 00000000 c97cb13c
       cbfe55a0 00000283 c97cb000 b012277d c97cb000 b01eb507 cbe86000 cbe87f84
       cbe87fa4 cbfe55a0 b01228a9 cbfe55a0 ffffffff ffffffff 00000001 00000000
Call Trace:
 [<b01eb558>] do_tty_hangup+0x51/0x294
 [<b012277d>] run_workqueue+0x6e/0xa2
 [<b01eb507>] do_tty_hangup+0x0/0x294
 [<b01228a9>] worker_thread+0xf8/0x12a
 [<b01138c3>] default_wake_function+0x0/0x12
 [<b026dabd>] schedule+0x45f/0x4cd
 [<b01138c3>] default_wake_function+0x0/0x12
 [<b01227b1>] worker_thread+0x0/0x12a
 [<b0124ece>] kthread+0x79/0xa3
 [<b0124e55>] kthread+0x0/0xa3
 [<b01012cd>] kernel_thread_helper+0x5/0xb
Code: 91 70 01 00 00 8b 02 0f 18 00 90 8d 81 70 01 00 00 39 c2 74 13 8b 12 43 8b 02 0f 18 00 90 8d 81 70 01 00 00 39 c2 75 ed 8b 41 04 <81> 78 74 04 00 02 00 75 17 8b 91 cc 00 00 00 85 d2 74 0d 83 ba

I don't know enough about the tty system to find the problem, but it
seems to me that the tty structure might be released too soon.
We have a hotplug script that starts ppp on connect, and we can
reproduce this by repeatedly plugging and unplugging the ipaq.

Frank

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19
