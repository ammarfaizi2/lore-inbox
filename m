Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266754AbRGFQe4>; Fri, 6 Jul 2001 12:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266753AbRGFQeg>; Fri, 6 Jul 2001 12:34:36 -0400
Received: from zeke.inet.com ([199.171.211.198]:50574 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S266752AbRGFQed>;
	Fri, 6 Jul 2001 12:34:33 -0400
Message-ID: <3B45E799.C219C0D1@inet.com>
Date: Fri, 06 Jul 2001 11:30:17 -0500
From: "Jordan Breeding" <jordan.breeding@inet.com>
Reply-To: Jordan <ledzep37@home.com>,
        Jordan Breeding <jordan.breeding@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems halting/rebooting with 2.4.{5,6}-ac
In-Reply-To: <3B44AD33.26D97B4C@inet.com> <3B44B4BD.DD7F7A5B@inet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Breeding wrote:
> 
> Jordan Breeding wrote:
> >
> > I have a Tyan Tiger 230 SMP system running dual 1 GHz PIII processors.
> > The processors are of the same lot and revision, bought on the same
> > day.  Everything worked fine or some time in regard to
> > halting/rebooting.  I was using ac kernels configured with ACPI.  At the
> > time of the merge with the Linus stuff which included new ACPI I started
> > configuring with ACPI and ACPI bus management and I could no longer halt
> > the system but rebooting worked OK.  As of 2.4.5-ac24 and 2.4.6-ac1 I
> > can no longer halt or reboot my system properly using no power
> > management or ACPI, and APM still displays the message about being
> > broken on SMP.  Has anyone seen this problem, is there a fix for it?
> > Another thing I have noticed is that my /proc/cpuinfo file looks like
> > this:
> >
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 8
> > model name      : Pentium III (Coppermine)
> > stepping        : 6
> > cpu MHz         : 999.694
> > cache size      : 256 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 2
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > mca cmov pat pse36 mmx fxsr sse
> > bogomips        : 1992.29
> >
> > processor       : 1
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 8
> > model name      : Pentium III (Coppermine)
> > stepping        : 6
> > cpu MHz         : 999.694
> > cache size      : 256 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 3
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > mca cmov pat pse36 mmx fxsr sse
> > bogomips        : 1998.84
> >
> > Notice the difference in cpuid level and bogomips values between the
> > two.  These processors should be exactly the same, same lot and revision
> > and everything else according to the shrink wrapped Intel retail boxes
> > they came out of.  What could be casuing them to show up at different
> > cpuid levels?  Thanks for any help with either issue.
> >
> > Jordan Breeding
> 
> Very sorry to have not included more information, when halting or
> rebooting it now stop at INIT: there are no more processes left at this
> run level and never actually reboots or halts.  To get around it I
> either have to hit the power/reset buton or use SysReq to reboot it.
> Thanks again for any help.
> 
> Jordan Breeding


Okay, I did some more testing.  I tried doing a reverse patch using
Intels ACPI patch from 2.4.5-pre3 to the current ACPI version.  So now I
was running 2.4.6-ac1 with the old ACPI.  The same thing happened.  So
then I started thinking about anything else I had possibly changed
around the same time frame as the ACPI version change.  I had changed
from the normal UHCI to the Alternate (JE) UHCI drvier to allow me to
use a USB Sun keyboard and mouse successfully on an SMP kernel.  So the
next time that I tried a halt/reboot and it hung I tried showing the
task list using SysRq and khubd goes into zombie state when shutting
down.  Anyone have any ideas why?  Everything else left still running
(all kernel threads) was just in sleep state.  I assume this is a big
part of my problem.  Thanks in advance.

Jordan Breeding
