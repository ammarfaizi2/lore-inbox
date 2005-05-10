Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVEJKxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVEJKxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 06:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVEJKxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 06:53:45 -0400
Received: from mail.aei.ca ([206.123.6.14]:46039 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261604AbVEJKxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 06:53:42 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Bernd Paysan <bernd.paysan@gmx.de>
Subject: Re: [suse-amd64] False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Date: Tue, 10 May 2005 06:53:49 -0400
User-Agent: KMail/1.7.2
Cc: suse-amd64@suse.com, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200505081445.26663.bernd.paysan@gmx.de> <200505091253.21252.bernd.paysan@gmx.de> <200505091517.30555.bernd.paysan@gmx.de>
In-Reply-To: <200505091517.30555.bernd.paysan@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505100653.50775.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 May 2005 09:17, Bernd Paysan wrote:
> On Monday 09 May 2005 12:53, Bernd Paysan wrote:
> > On Sunday 08 May 2005 15:40, Andi Kleen wrote:
> > > Your system should be using the HPET timer to work exactly around
> > > this. AMD 8000 has HPET. Can you post a boot.log?
> >
> > Ok, boot.log attached. The only entry with hpet seems to indicate some
> > problems.
> 
> I went through the BIOS setup, and found a disabled feature "ACPI 2.0", 
> which I enabled. Now Linux finds the HPET timer.
> 
> # grep -i hpet boot.log 
> ACPI: HPET (v001 A M I  OEMHPET  0x04000518 MSFT 0x00000097) @ 
> 0x00000000e8ff3c30
> ACPI: HPET id: 0x102282a0 base: 0xfec01000
> time.c: Using 14.318180 MHz HPET timer.> 

> time.c: Using HPET based timekeeping.
> hpet0: at MMIO 0xfec01000, IRQs 2, 8, 0
> hpet0: 69ns tick, 3 32-bit timers
> hpet_acpi_add: no address or irqs in _CRS
> 
> and everything appears to work (though there's still no designated CPU to 
> handle the timer interrupts). xntpd syncs quickly, I'm happy (so far ;-).
> 
> So that explains why nobody sees this problem. But the TSC-based fallback 
> timekeeping is still broken on SMP systems with PowerNow and distributed 
> IRQ handling, which both together seem to be rare enough ;-).

Maybe on UP too:

May  8 18:50:25 grover kernel: [143640.507170] Attached scsi removable disk sda at scsi5, channel 0, id 0, lun 0
May  8 18:50:25 grover kernel: [143640.520422] rtc: lost some interrupts at 1024Hz.
May  8 18:50:25 grover kernel: [143640.554134] Attached scsi generic sg0 at scsi5, channel 0, id 0, lun 0,  type 0
May  8 18:50:25 grover kernel: [143640.567693] rtc: lost some interrupts at 1024Hz.
May  8 18:50:25 grover kernel: [143640.596402] usb-storage: device scan complete

This from 12-rc3-mm3, UP x86_64 with powernow active.  

It might be that the message is OK here since I do not see a fast clock.  I mention this
since powernow is active here.

Should HPET be available in UP?

Ed Tomlinson

