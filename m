Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266563AbVBDX7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266563AbVBDX7e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263443AbVBDXzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:55:13 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:42902 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266000AbVBDXuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:50:05 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc3-mm1: device_resume() hangs on Athlon64
Date: Sat, 5 Feb 2005 00:50:37 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
References: <20050204103350.241a907a.akpm@osdl.org>
In-Reply-To: <20050204103350.241a907a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502050050.38043.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 4 of February 2005 19:33, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/
> 

On my box (Athlon64-based) swsusp hangs forever in device_resume() called
from swsusp_write(), although interrupts are apparently handled
normally then (eg magic SysRq works).  The last thing it says is:

ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11

When I press Alt+SysRq+p it says:

SysRq : Show Regs

Modules linked in: snd_seq snd_seq_device usbserial parport_pc lp parport thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd
Pid: 0, comm: swapper Not tainted 2.6.11-rc3-mm1
RIP: 0010:[<ffffffff8027915c>] <ffffffff8027915c>{__delay+12}
RSP: 0018:ffffffff804dae20  EFLAGS: 00000216
RAX: 00000000000adaaa RBX: ffffffff804dad78 RCX: 00000000d3afd2ab
RDX: 0000000000000076 RSI: 00000000000088b8 RDI: 00000000000c0a08
RBP: ffffffff8010f199 R08: 0000000000140040 R09: ffff81001db48ce0
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000046
R13: ffffffff801117e2 R14: ffffffff8054d900 R15: ffff81001fde4ab8
FS:  00002aaaab28b800(0000) GS:ffffffff80565800(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaabab000 CR3: 000000000d557000 CR4: 00000000000006e0

Call Trace:<IRQ> <ffffffff80319d3f>{ide_wait_not_busy+31} <ffffffff803177d1>{ide_do_request+1153}
       <ffffffff80316ad2>{ide_end_drive_cmd+1074} <ffffffff80115c60>{end_8259A_irq+96}
       <ffffffff803184a4>{ide_intr+1316} <ffffffff8016ba4c>{handle_IRQ_event+44}
       <ffffffff8016bc56>{__do_IRQ+470} <ffffffff80140d33>{__do_softirq+83}
       <ffffffff801117e2>{do_IRQ+66} <ffffffff8010f199>{ret_from_intr+0}
        <EOI> <ffffffff802df1d0>{console_callback+0} <ffffffff803b4c2d>{thread_return+41}
       <ffffffff8010d230>{default_idle+0} <ffffffff8010d250>{default_idle+32}
       <ffffffff8010d656>{cpu_idle+54} <ffffffff8057071f>{start_kernel+463}
       <ffffffff80570240>{_sinittext+576}

This happens 100% of the time.  It also happened on 2.6.11-rc2-mm2, but not on
2.6.11-rc2-mm1, AFAIR.  It does not occur on the -rc[1-3] kernels.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
