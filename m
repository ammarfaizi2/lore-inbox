Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUE0OrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUE0OrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbUE0Oqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:46:47 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:28570 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S264592AbUE0Oqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:46:30 -0400
Message-ID: <40B5FF96.44F9EE15@nospam.org>
Date: Thu, 27 May 2004 16:47:51 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Matthias Fouquet-Lapar <mfl@kernel.paris.sgi.com>
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Hot plug vs. reliability
References: <200405271217.i4RCHpTg001943@mtv-vpn-hw-mfl-1.corp.sgi.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Fouquet-Lapar wrote:
> 
> My (limited) understanding of hotplug is that the major motivations
> are more adminstrative/reconfiguration then actually replacing failing
> components "on-the-fly".

I agree, in this case there is no loss of MTBF.
Yet let's call this activity as run time re-partitioning of the machine.
(Most people - me too - consider hot plugging as physically plugging
things in / out.)

> Tyically you'll have similar burn-in tests for the components. The same
> probably is true for component repair

But the new comers are tested in a different environment, with
different tolerance range. I just simply do not trust :-)

> > There are cases when not the "worst case" design is used. You select
> > components "carefully". E.g. you use a quicker component after a
> > slower one to compensate the excessive delay, or you select parallel
> > components with similar irregularities (no problem if they are too
> > slow assuming they are similarly slow). How can we match a hot
> > plug device with the existing ones ?
> 
> A fair amount of devices copes with this that for example electrical
> driver impedance is adjusted by the device after a specific number of
> operations. Totally invisible to SW.

I do not think the timing / the delays are auto adjusting. You select
a component X to work next to the component Y because you know that
X in "here" and Y in "there" in the tolerance range...

> > A test can do any "irregular" operation whatever it wants. E.g.
> > the memory controller can be switched into a test mode, that allows
> > reading / writing the memory without the intervention of the ECC
> > logic. One can fill in the memory with some predefined pattern and
> > check if the ECC logic does what it has to do. Can we do this for
> > memory hot plug without breaking a running OS ?
> > Another example: we add a CPU board and we need to make sure that
> > the coherency dialog goes fine. Can we carry out these tests
> > without perturbing the already on line CPUs ?
> > How can we make sure that a freshly inserted I/O card can reach
> > all the memory it has to, it can interrupt any CPU it has to ?
> > (Again, without breaking the OS.)
> 
> I think a lot (all ?) can be done with on-line diagnostics. Clearly adding
> a defective CPU or node board which causes coherency traffic to fail
> should not happen.

Probably it is platform dependent.
I saw our FW guys doing a couple of black magic, e.g. pumping data in / out
to / from the LSIs through JTAGs, "abusing" the "back doors".
Another example: we bought some Intel IA64 boards (CPUs + memory) and
I saw things, by use of an In Target Probe, like switching back to i386 mode (!!!)
or freely playing with cache attributes or doing tricky synchronization
among the CPUs.
I've simply got concerns...

> > We cannot remove safely failing memory / CPUs. In most of the cases
> > it is too late. We (in the OS) can see some corrected CPU, memory, I/O
> > and platform errors. Yet the OS has not got and should not have the
> > knowledge when a component is "enough bad". I think it is the firmware
> > that has all the information about the details of the HW events.
> > Do you know of some firmware services which can say something like:
> > "hey, remove the component X otherwise your MTBF will drop by 95 %..." ?
> 
> That's a point where I totally disagree. I think the OS should have at least
> the option to know about every failure in the system. The OS should log
> these events, I think in a fair amount of cases recovery is possible.
> It might impact the application, but the OS can recover. This would not
> be possible from the firmware alone.

Well, the OS can log events, why not ?
Yet what do you do if you cannot boot, cannot read the log ?
We've got an embedded computer (service processor) that logs everything
and it's got a private Ethernet plug => you can read its log even if
the main machine is off.

I think the OS has to be platform independent. How can a platform independent
OS know if <n> errors of this / that type requires what intervention ?
We'll have the same binary of the OS (+ drivers) for a small desk top or
for a 32 CPU "main frame". Only the firmware is different...

Most of our clients run a single (HPC) application on a machine.
For them, there is no use to save the OS. I can understand that in other
environments with many applications it is important to save the OS.

> I'm currently looking at scenarios where the OS would provide hooks
> for an application to implement "self-healing", i.e. the application
> is notified about an uncorrectable memory error for example and can attempt
> to work around it.

Most of our clients just do not want to touch their 10 year old rubbish
Fortran programs. If I get a hint of danger (today it does not come from the FW)
I could take a check point and call for service intervention...

> > Today HW components are sold without much testing. They say O.K. got
> > a problem?, just send it back, we'll refund. Thanks. I just have broken
> > my system.
> 
> I think this really is vendor/platform specific. Many vendors will do extensive
> testing of components shipped to customers in addition to root-cause failure
> analysis of returned components.

Probably, we should change platform - just kidding ;-)

Thanks,

Zoltán
