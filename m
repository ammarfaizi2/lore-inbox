Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbTIBGgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 02:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263560AbTIBGgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 02:36:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:3806 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263557AbTIBGgW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 02:36:22 -0400
From: Stefan Winter <mail@stefan-winter.de>
To: "Brown, Len" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: no keyboard and mouse on 2.6.0-test4 (notebook)
Date: Tue, 2 Sep 2003 08:34:44 +0200
User-Agent: KMail/1.5.3
References: <BF1FE1855350A0479097B3A0D2A80EE009FCE1@hdsmsx402.hd.intel.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FCE1@hdsmsx402.hd.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309020834.44830.mail@stefan-winter.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

acpi=off does not make any difference. Yesterday I compiled a 2.5.25 kernel 
and got some more info: during boot, the warning message
i8042.c: Couldnt get IRQ1 for KBD0
(or similar, the messages passed by quickly and, of course, scroll lock didn´t 
work:-) appeared.

Plus, I have got a correction concerning the BIOS warning after reboot:
> > warns about "No interrupts from keyboard 0" and the BIOS
Actually, the warning is "No interrupts from TIMER 0." As a sidenote, the BIOS 
in question seems somewhat broken. It reports overlapping MTRR regions and 
sets the PCI cache line size incorrectly, according to the kernel. 
Furthermore it reports bad refresh rates for my TFT display to the X server. 
After all, I wouldn´t be surprised if this all relates to the f*cked up BIOS 
(it is some "Insyde BIOS 1.07").

If it helps, I can go down the kernel versions to locate the version where it 
broke.

Greetings,

Stefan Winter

> Stefan,
> Did earlier versions of 2.6 (or 2.5) work?
> Does booting 2.6.0-test4 with acpi=off make any difference?
>
> Curious that vanilla 2.4.x has an issue with kbd interrupts on this box,
> but SuSE 8.2 does not.  Apparently SuSE 8.2 has a fix or workaround for
> this box that isn't in the baseline -- anybody know what it is?
>
> Thanks,
> -Len
>
> > [7.7.] Other information that might be relevant to the problem
> >        (please look in /proc and include all information that you
> >        think to be relevant):
> > sunshine:/proc # cat interrupts
> >            CPU0
> >   0:    4574746          XT-PIC  timer
> >   1:         14          XT-PIC  i8042
> >   2:          0          XT-PIC  cascade
> >   5:          2          XT-PIC  ohci1394, VIA8233
> >   9:          5          XT-PIC  acpi
> >  10:       4029          XT-PIC  eth0
> >  11:          0          XT-PIC  ehci_hcd
> >  12:         89          XT-PIC  i8042
> >  14:       5523          XT-PIC  ide0
> >  15:         45          XT-PIC  ide1
> > NMI:          0
> > LOC:    4570927
> > ERR:      62338
> > MIS:          0
> >
> > [X.] Other notes, patches, fixes, workarounds:
> > the interrupt count on INT1,CPU0 (see /proc/interrupts above) does not
> > increase after key pressures. It looks like the interrupt
> > from the keyboard
> > isn´t caught. There is an issue on 2.4.x kernels that may
> > relate to that
> > problem: after running the kernel and restarting it with
> > "init 6", the BIOS
> > warns about "No interrupts from keyboard 0" and the BIOS
> > password entry
> > field doesn´t catch keypresses any more [this is only an
> > issue with the
> > vanilla kernel - SuSE 8.2´s patched kernel is fine]. An "init 0" and
> > re-poweron solves that issue in 2.4.x kernels. Maybe the 2.6. kernel
> > encounters that phenomenon earlier.

