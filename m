Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268544AbUJDTaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268544AbUJDTaJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268482AbUJDTRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:17:55 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:14062 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S268458AbUJDTNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:13:32 -0400
From: Jan De Luyck <lkml@kcore.org>
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix suspending with mysqld
Date: Mon, 4 Oct 2004 21:09:58 +0200
User-Agent: KMail/1.7
References: <20041004122422.GA2601@elf.ucw.cz>
In-Reply-To: <20041004122422.GA2601@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410042109.58519.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 October 2004 14:24, Pavel Machek wrote:
> Hi!
>
> mysqld does signal calls in pretty tight loop, and swsusp is not able
> to stop processes in such case. This should fix it. Please apply,
>         Pavel

Pavel,

I applied your patch to 2.6.9-rc3. Unfortunately, now the system doesn't suspend anymore, it comes back almost immediately:

Stopping tasks: ====================================================|
Freeing memory: ...................................|
radeonfb: suspending to state: 3...
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 0x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 0x mode
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
radeonfb: resumed !
Restarting tasks... done


The system never reaches suspend.

Jan

-- 
BOFH excuse #323:

Your processor has processed too many instructions.  Turn it off immediately, do not type any commands!!
