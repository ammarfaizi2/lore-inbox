Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267673AbTAHDLA>; Tue, 7 Jan 2003 22:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267675AbTAHDLA>; Tue, 7 Jan 2003 22:11:00 -0500
Received: from fmr01.intel.com ([192.55.52.18]:55292 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267673AbTAHDK7> convert rfc822-to-8bit;
	Tue, 7 Jan 2003 22:10:59 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][2.4] generic cluster APIC support for systems with more than 8 CPUs
Date: Tue, 7 Jan 2003 19:19:37 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DA5CE54@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4] generic cluster APIC support for systems with more than 8 CPUs
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK2nkywWW6S2yKREdetAABQi+Bv6wAJHDgw
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: "Andrew Theurer" <habanero@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>,
       <jamesclv@us.ibm.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Schlobohm, Bruce" <bruce.schlobohm@intel.com>
X-OriginalArrivalTime: 08 Jan 2003 03:19:37.0980 (UTC) FILETIME=[C67E33C0:01C2B6C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> I am seeing if I can get together a test for Netbench with/without
your
> patch.
> Looking at the patch, I would expect a slight increase in performance.
> I'll
> let you know the results as soon as I have them.
> 
[NK] Thanks for trying it out. The numbers from my post may be useful to

you.

> I do have one question for you:  Have you tested netperf using only
one
> gigabit adapter?  If so, have you been able to max out the adapter
when
> using
> hyperthreading?  If not, could you test this?  So far I have not been
able
> to, while I can quite easily with no hyperthreading (in Netbench).
This is
> the case with both irq_balance and irq affinity.  having ints
processed by
> one and only one logical CPU at one time really seems to bottleneck
> network
> throughput.  I'm sure some of this has to do with sharing those
resources
> among 2 logical CPUs, but I also wonder if int processing is just a
lot
> slower than P3 overall.

[NK] While testing we had 4 100mbps NICs with 4 Way Intel P4 Xeon
1.6GHz. What is your system configuration? Some numbers from your
experiments would be useful in understanding the situation better. Also
what do you mean by no hyper-threading, Is HT disabled in the BIOS, or
the HT awareness is disabled in the code. I need more details of your
setup to test it out.

> 
> I am bringing this up, because I recall James Cleverdon having some
code
> which
> allows interrupts to be dynamically routed to two CPU destinations, a
pair
> of
> CPUs with consecutive CPU ID's.  Interrupts are dynamically routed to
the
> least loaded CPU, and if both are idle, to the CPU with the lower
CPUID.
> I
> like this idea, because when in HT, if consecutive logical CPU ID's
map to
> one physical core, we get to use "whole" processor, and both
destinations
> share the cache.  Anyway, just a thought.

[NK] This case will work well if the CPUs are lightly loaded. For
Heavily loaded CPUs to let then perform their on task, it is required to
move the interrupts out of the package.

Thanks,
Nitin

> 
> -Andrew Theurer
