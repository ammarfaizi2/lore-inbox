Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUE0M3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUE0M3O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 08:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUE0M3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 08:29:14 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:18391 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262065AbUE0M3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 08:29:03 -0400
From: Matthias Fouquet-Lapar <mfl@kernel.paris.sgi.com>
Message-Id: <200405271217.i4RCHpTg001943@mtv-vpn-hw-mfl-1.corp.sgi.com>
Subject: Re: Hot plug vs. reliability
To: Zoltan.Menyhart@bull.net
Date: Thu, 27 May 2004 14:17:50 +0200 (CEST)
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <40B5D68C.466FE969@nospam.org> from "Zoltan Menyhart" at May 27, 2004 01:52:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My (limited) understanding of hotplug is that the major motivations
are more adminstrative/reconfiguration then actually replacing failing
components "on-the-fly".

> When we produce machines, we execute tests like burn in, stress,
> validation, etc. tests. In addition, every time a machine is switched
> on, a power on self test is executed.
> When we hot plug (add, remove, swap) a component that has never been
> seen, how can we make sure that the modified machine achieves the
> same MTBF as the original machine had, without passing any of the
> tests I mentioned above ?

Tyically you'll have similar burn-in tests for the components. The same
probably is true for component repair

> There are cases when not the "worst case" design is used. You select 
> components "carefully". E.g. you use a quicker component after a
> slower one to compensate the excessive delay, or you select parallel
> components with similar irregularities (no problem if they are too
> slow assuming they are similarly slow). How can we match a hot
> plug device with the existing ones ?

A fair amount of devices copes with this that for example electrical
driver impedance is adjusted by the device after a specific number of
operations. Totally invisible to SW. 

> A test can do any "irregular" operation whatever it wants. E.g.
> the memory controller can be switched into a test mode, that allows
> reading / writing the memory without the intervention of the ECC
> logic. One can fill in the memory with some predefined pattern and
> check if the ECC logic does what it has to do. Can we do this for
> memory hot plug without breaking a running OS ?
> Another example: we add a CPU board and we need to make sure that
> the coherency dialog goes fine. Can we carry out these tests
> without perturbing the already on line CPUs ?
> How can we make sure that a freshly inserted I/O card can reach
> all the memory it has to, it can interrupt any CPU it has to ?
> (Again, without breaking the OS.)

I think a lot (all ?) can be done with on-line diagnostics. Clearly adding
a defective CPU or node board which causes coherency traffic to fail
should not happen. 

> And now the most difficult tests: how can we make sure that no error
> will be undetected. E.g. at the power on test, we can voluntarily
> provoke "machine checks" to make sure that these kinds of errors are
> safely detected. Can we really do this on a living operating system ?
> No problem resetting several times the machine (by the service
> processor). Obviously, it is not a good idea for a running system.
> What can we do in case of hungs, time-outs ?
> 
> Do you know of some firmware services like "in place testing" ? I mean
> the operating system invokes a specific firmware call and hands over
> the control of the machine temporarily (say for 1 millisecond) to the
> firmware. The firmware can execute a small part of the validation
> test (without corrupting any data, without losing an interrupt, etc.)
> then it returns to the OS. This latter resumes the operations and
> calls again the firmware the tests somewhat later.
> 
> We cannot remove safely failing memory / CPUs. In most of the cases
> it is too late. We (in the OS) can see some corrected CPU, memory, I/O
> and platform errors. Yet the OS has not got and should not have the
> knowledge when a component is "enough bad". I think it is the firmware
> that has all the information about the details of the HW events.
> Do you know of some firmware services which can say something like:
> "hey, remove the component X otherwise your MTBF will drop by 95 %..." ?

That's a point where I totally disagree. I think the OS should have at least
the option to know about every failure in the system. The OS should log
these events, I think in a fair amount of cases recovery is possible.
It might impact the application, but the OS can recover. This would not
be possible from the firmware alone.

I'm currently looking at scenarios where the OS would provide hooks
for an application to implement "self-healing", i.e. the application
is notified about an uncorrectable memory error for example and can attempt
to work around it. 

> Today HW components are sold without much testing. They say O.K. got
> a problem?, just send it back, we'll refund. Thanks. I just have broken
> my system.

I think this really is vendor/platform specific. Many vendors will do extensive
testing of components shipped to customers in addition to root-cause failure
analysis of returned components.


Thanks

Matthias Fouquet-Lapar  Core Platform Software    mfl@sgi.com  VNET 521-8213
Principal Engineer      Silicon Graphics          Home Office (+33) 1 3047 4127

