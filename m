Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266177AbUG1D0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266177AbUG1D0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 23:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUG1D0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 23:26:38 -0400
Received: from mail.timesys.com ([65.117.135.102]:60640 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S266177AbUG1D0e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 23:26:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
Date: Tue, 27 Jul 2004 23:26:10 -0400
Message-ID: <3D848382FB72E249812901444C6BDB1D036EDFD3@exchange.timesys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
Thread-Index: AcR0Ladovl5ZyzmTQpCQPyR06IwAZwAIprgg
From: "Saksena, Manas" <Manas.Saksena@timesys.com>
To: "Lee Revell" <rlrevell@joe-job.com>, "Ingo Molnar" <mingo@elte.hu>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Lenar L?hmus" <lenar@vision.ee>, "Andrew Morton" <akpm@osdl.org>,
       "Arjan van de Ven" <arjanv@redhat.com>,
       "Wood, Scott" <Scott.Wood@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2004-07-27 at 12:27, Ingo Molnar wrote:
>> i've uploaded -L2:
>> 
>> 
>> 
> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2
>> -L2
>> 
>> the hardirq-redirection feature is activated via
>> voluntary-preemption=3 (default). All irqs except the timer irq are
>> redirected. (the timer irq needs to run from irq context - but it has
>> constant latency and constant frequency so it's not an issue. Soft
>> timers are executed from the timer softirq which is redirected and
>> hence preemptable.) 
>> 
>> this means that with this patch applied the 2.6 UP kernel is quite
>> close to being hard-RT capable (using controlled drivers and
>> workloads). All unbound-latency asynchronous workloads have been
>> unloaded into synchronous, schedulable process contexts - so nothing
>> can delay a high-prio RT task. (assuming we caught all the latencies.
>> Any remaining latency can be fixed with the existing methods.)
>> 
> The obvious next feature to add would be to make certain IRQs
> non-schedulable, like you would for an RT system.  For an
> audio system this would be just the soundcard interrupt (and timer as
> stated above). Then, while it still might not be hard-RT, it would
> blow away anything achievable on the other OS'es people do audio work
> with. 

Its really useful to have a thread per IRQ and to have an option to
run a particular IRQ handler in hardirq context. Then a system designer
or adminstrator can tune the priorities of different IRQ handler threads
depending on the latency requirements of a particular system. Scott's 
patch posted earlier (see link below) implements this -- this has proven

handy in many scenarios including, but not restricted to, audio
real-time 
performance. 

http://marc.theaimsgroup.com/?l=linux-kernel&m=109096903816850&w=2

Manas
