Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUCRARM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUCRARM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:17:12 -0500
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:14283 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S262226AbUCRARH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:17:07 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
Date: Thu, 18 Mar 2004 10:19:02 +1000
User-Agent: KMail/1.5.1
Cc: thomas.schlichter_at_web.de@albatron,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       len.brown_at_intel.com@albatron
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403181019.02636.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote: 
> > On Wed, 3 Mar 2004, Thomas Schlichter wrote: 
> > 
> > > a few days ago I noticed that my Athlon 3000+ was relatively hot (49C) 
> > > although it was completely idle. At that time I was running 2.6.3-mm3 with 
> > > ACPI and IOAPIC-support enabled. 
> > > 
> > > As I tried 2.6.3, the idle temperature was at normal 39C. So I did do some 
> > > binary search with the -bk patches and found the patch that causes the high 
> > > idle temperature. It is ChangeSet@1.1626 aka 8259-timer-ack-fix.patch. 
> > 
> > Interesting -- the patch removes a pair of unnecessary for your 
> > configuration PIC accesses when using an I/O APIC NMI watchdog. You have 
> > the NMI watchdog enabled, don't you? 
 
> No, I don't use the NMI watchdog... 
>  So the optimization of removing these I/O accesses is bogus for my configuration. Btw. I don't know if I already mentioned it, but I use the VIA KT400 chipset. Maybe this is of interest... 
 
> The only way to cool down my CPU was to enable timer_ack. 
>  I don't know how to help you, but of course I am willing to test patches... ;-) 
>   Thomas 
 
I agree with Len Brown's comments to try to examine which power saving state but
if you want to try to brute force C1 state ( only works if chipset supported )
you could try this patch for process.c, 
(ignore the io-apic patch as it is nforce2 specific).

http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-02/6520.html
The KERNEL ARG to invoke it is "idle=C1halt". 
 
It has an extra function pointer to prevent the power management idle routine
hikjacking things after the command line arg has requested an idle routine.

These idle mods appear to assist more than just nforce2 Athlon boards.
Thomas Herrmann has had success with an SIS740

> Hi Ross,
> I just want to let you know that your nforce2_idle patch does work with the
> SiS740 chipset too. While the current ACPI patch already routes the timer of
> the SiS740 to IO-APIC-edge with out the C1halt option of your nforce2_idle
> patch the system locked up when STPGNT was enabled. But after I applied your
> nforce2_idle patch to kernel 2.4.24 together with the C1halt kernel boot
> option, the system runs stable for hours.
> Great work, thanks!
> Best regards,   Thomas

Craig Bradney has put it into the gentoo dev sources also.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/1746.html

Hope this helps,
Ross.


