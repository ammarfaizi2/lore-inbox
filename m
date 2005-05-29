Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVE2UTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVE2UTV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 16:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVE2UTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 16:19:20 -0400
Received: from osten.wh.uni-dortmund.de ([129.217.129.130]:11240 "EHLO
	osten.wh.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261427AbVE2USi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 16:18:38 -0400
Message-ID: <429A2397.6090609@web.de>
Date: Sun, 29 May 2005 22:18:31 +0200
From: Alexander Fieroch <Fieroch@web.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:  
 nobody cared!"
References: <d6gf8j$jnb$1@sea.gmane.org> <20050527171613.5f949683.akpm@osdl.org>
In-Reply-To: <20050527171613.5f949683.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> Does the thing work correctly under any versions of Linux?  If so, which?

Ok, I have gathered much informations as possible that could help you.

I've tested different versions of linux as follows. None works fine but
all have different error messages:


With kernel 2.6.8.1 and kernel 2.6.9 I get continually apic error
messages that makes the kernel unusable for me:

May 28 13:12:53 orclex kernel: APIC error on CPU0: 60(60)
May 28 13:13:05 orclex last message repeated 44 times
This is repeating every few seconds.



Kernel 2.6.10
-------------

I did not recognize the error message above with apic error but I get
every 2 seconds the following message on my terminal which makes the
kernel unusable for me too.

Call Trace:<IRQ> <ffffffff801505fc>{__report_bad_irq+48}
<ffffffff801506c0>{note_interr
upt+91}
       <ffffffff80150080>{__do_IRQ+257} <ffffffff8010ffb8>{do_IRQ+58}
       <ffffffff8010d7c9>{ret_from_intr+0}  <EOI>
<ffffffff8010b573>{mwait_idle+94}
       <ffffffff8010b4ca>{cpu_idle+45} <ffffffff80645882>{start_kernel+415}
       <ffffffff80645259>{x86_64_start_kernel+365}
handlers:
[<ffffffff802f33b2>] (ide_intr+0x0/0x17e)
[<ffffffff8033f5e9>] (usb_hcd_irq+0x0/0x68)
Disabling IRQ #185
irq 185: nobody cared!





Kernel 2.6.11.11
----------------

Kernel 2.6.11.xx is the first kernel where the message "drive appears
confused" is thrown.
I also recognize the following lines in syslog where the kernel hangs
for some seconds (nearly a minute) while booting:

May 28 13:47:10 orclex kernel: ACPI: PCI interrupt 0000:01:0a.0[A] ->
GSI 21 (level, lo
w) -> IRQ 21
May 28 13:47:10 orclex kernel: hda: dma_timer_expiry: dma status == 0x64
May 28 13:47:10 orclex kernel: hda: DMA interrupt recovery
May 28 13:47:10 orclex kernel: hda: lost interrupt


I have enabled "ACPI APIC" in my bios. Disabling this causes the kernel
to hang on the last message above and repeating "hda: lost interrupt"
continually.

The "nobody cared" message is still here.

...
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
irq 18: nobody cared!

Call Trace:<IRQ> <ffffffff80150064>{__report_bad_irq+48}
<ffffffff80150128>{note_interrupt+91}
       <ffffffff8014fae3>{__do_IRQ+257} <ffffffff80110105>{do_IRQ+71}
       <ffffffff8010d83d>{ret_from_intr+0}  <EOI>
<ffffffff8015e0a1>{clear_page_range+845}
       <ffffffff8015e10a>{clear_page_range+950}
<ffffffff801641bb>{exit_mmap+222}
       <ffffffff8012faa8>{mmput+50} <ffffffff80134adc>{do_exit+306}
       <ffffffff80134e78>{sys_exit_group+0}
<ffffffff8010d296>{system_call+126}

handlers:
[<ffffffff803021af>] (ide_intr+0x0/0x17a)
[<ffffffff8034e53a>] (usb_hcd_irq+0x0/0x68)
Disabling IRQ #18
hdb: lost interrupt
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
...



After booting this is repeating continually and I get every minute a
message on the console:

Message from syslogd@orclex at Sat May 28 13:33:02 2005 ...
orclex kernel: Disabling IRQ #18


syslog contains following message every minute:

May 28 13:33:01 orclex kernel: hdb: lost interrupt
May 28 13:33:01 orclex kernel: hdb: cdrom_pc_intr: The drive appears
confused (ireason
= 0x01)
May 28 13:33:01 orclex last message repeated 18 times
May 28 13:33:02 orclex kernel: irq 18: nobody cared!
May 28 13:33:02 orclex kernel:
May 28 13:33:02 orclex kernel: Call Trace:<IRQ>
<ffffffff80150064>{__report_bad_irq+48}
 <ffffffff80150128>{note_interrupt+91}
May 28 13:33:02 orclex kernel:        <ffffffff8014fae3>{__do_IRQ+257}
<ffffffff8011010
5>{do_IRQ+71}
May 28 13:33:02 orclex kernel:
<ffffffff8010d83d>{ret_from_intr+0}  <EOI> <fffff
fff8010b588>{mwait_idle+94}
May 28 13:33:02 orclex kernel:        <ffffffff8010b50c>{cpu_idle+57}
<ffffffff8065686d
>{start_kernel+425}
May 28 13:33:02 orclex kernel:
<ffffffff80656258>{x86_64_start_kernel+364}
May 28 13:33:02 orclex kernel: handlers:
May 28 13:33:02 orclex kernel: [<ffffffff803021af>] (ide_intr+0x0/0x17a)
May 28 13:33:02 orclex kernel: [<ffffffff8034e53a>] (usb_hcd_irq+0x0/0x68)
May 28 13:33:02 orclex kernel: Disabling IRQ #18
May 28 13:34:03 orclex kernel: hdb: lost interrupt
May 28 13:34:03 orclex kernel: hdb: cdrom_pc_intr: The drive appears
confused (ireason
= 0x01)
May 28 13:34:03 orclex last message repeated 21 times
May 28 13:34:04 orclex kernel: irq 18: nobody cared!
May 28 13:34:04 orclex kernel:
May 28 13:34:04 orclex kernel: Call Trace:<IRQ>
<ffffffff80150064>{__report_bad_irq+48}
 <ffffffff80150128>{note_interrupt+91}
May 28 13:34:04 orclex kernel:        <ffffffff8014fae3>{__do_IRQ+257}
<ffffffff8011010
5>{do_IRQ+71}
May 28 13:34:04 orclex kernel:
<ffffffff8010d83d>{ret_from_intr+0}  <EOI> <fffff
fff8010b588>{mwait_idle+94}
May 28 13:34:04 orclex kernel:        <ffffffff8010b50c>{cpu_idle+57}
<ffffffff8065686d
>{start_kernel+425}
May 28 13:34:04 orclex kernel:
<ffffffff80656258>{x86_64_start_kernel+364}
May 28 13:34:04 orclex kernel: handlers:
May 28 13:34:04 orclex kernel: [<ffffffff803021af>] (ide_intr+0x0/0x17a)
May 28 13:34:04 orclex kernel: [<ffffffff8034e53a>] (usb_hcd_irq+0x0/0x68)
May 28 13:34:04 orclex kernel: Disabling IRQ #18



Kernel 2.6.12rc5
----------------

Some more informations like "packet command error: status=0xd0" but
still the same errors like kernel 2.6.11.xx.



May 28 14:04:04 orclex kernel: hda: lost interrupt
May 28 14:04:04 orclex kernel: hdb: cdrom_pc_intr: The drive appears
confused (ireason
= 0x01)
May 28 14:04:04 orclex last message repeated 38 times
May 28 14:04:04 orclex kernel: hdb: packet command error: status=0xd0 {
Busy }
May 28 14:04:04 orclex kernel: ide: failed opcode was: unknown
May 28 14:04:04 orclex kernel: hdb: cdrom_pc_intr: The drive appears
confused (ireason
= 0x01)
May 28 14:04:04 orclex last message repeated 17 times
May 28 14:04:04 orclex kernel: scsi: unknown opcode 0x85
May 28 14:04:05 orclex lpd[4400]: restarted
May 28 14:04:05 orclex hddtemp[4391]: /dev/hda: IC35L060AVV207-0: 38 C
May 28 14:04:05 orclex kernel: irq 217: nobody cared!
May 28 14:04:05 orclex kernel:
May 28 14:04:05 orclex kernel: Call Trace: <IRQ>
<ffffffff80154078>{__report_bad_irq+48
} <ffffffff8015413c>{note_interrupt+91}
May 28 14:04:05 orclex kernel:        <ffffffff80153af7>{__do_IRQ+257}
<ffffffff8011049
d>{do_IRQ+67}
May 28 14:04:05 orclex kernel:
<ffffffff8010dded>{ret_from_intr+0}  <EOI>
May 28 14:04:05 orclex kernel: handlers:
May 28 14:04:05 orclex kernel: [<ffffffff8030a879>] (ide_intr+0x0/0x17a)
May 28 14:04:05 orclex kernel: [<ffffffff80357a5d>] (usb_hcd_irq+0x0/0x68)
May 28 14:04:05 orclex kernel: Disabling IRQ #217



> If the answer to my first queston is "no" then perhaps the hardware is
> busted.  Try swapping out cables, check power supplies, try a different
> drive, etc.

To test the hardware if it is busted I've have installed an ugly redmont
os and I could not recognize any problems. I also have burned a cdrom
with my burner that is hdb on linux and makes the problems. So I think
the hardware can't be busted and there has to be a problem with the
module for the Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE
Controller?

> If none of that helps then perhaps there's something we can do in
> cdrom_pc_intr() to work around this?

That would be very great. I would like to give you any more information
that is needed.


Thanks and regards,
Alexander





