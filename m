Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264539AbSIVVPu>; Sun, 22 Sep 2002 17:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264543AbSIVVPu>; Sun, 22 Sep 2002 17:15:50 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:16341 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S264539AbSIVVPt>; Sun, 22 Sep 2002 17:15:49 -0400
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Sep 2002 17:20:39 -0400 (EDT)
To: Ingo Molnar <mingo@elte.hu>
Cc: Karim Yaghmour <karim@opersys.com>, okrieg@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <Pine.LNX.4.44.0209221222060.21475-100000@localhost.localdomain>
References: <3D8D587E.8B66F9E9@opersys.com>
	<Pine.LNX.4.44.0209221222060.21475-100000@localhost.localdomain>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15758.12948.103681.852724@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no drag on the kernel.  The concept that we are working on is
consistent with your below recommendations.  Only place in the kernel an
efficient tracing infrastructure, keep trace points as patches.  This adds
no overhead to kernel, allows your suggested patches to use a standard
efficient infrastructure, reduces replicated work from specific problem to
specific problem.

 > my problem with this stuff is conceptual: it introduces a constant drag on
 > the kernel sourcecode, while 99% of development will not want to trace,

If you care about performance you will want to trace.  On two previous
kernels I have worked on I've heard this comment.  Once the infrastructure
was in it was used and appreciated.


Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com

----

Ingo Molnar writes:
 > 
 > On Sun, 22 Sep 2002, Karim Yaghmour wrote:
 > 
 > > D: The core tracing infrastructure serves as the main rallying point for
 > > D: all the tracing activity in the kernel. (Tracing here isn't meant in
 > > D: the ptrace sense, but in the sense of recording key kernel events along
 > > D: with a time-stamp in order to reconstruct the system's behavior post-
 > > D: mortem.) Whether the trace driver (which buffers the data collected
 > > D: and provides it to the user-space trace daemon via a char dev) is loaded
 > > D: or not, the kernel sees a unique tracing function: trace_event().
 > > D: Basically, this provides a trace driver register/unregister service.
 > > D: When a trace driver registers, it is forwarded all the events generated
 > > D: by the kernel. If no trace driver is registered, then the events go
 > > D: nowhere.
 > 
 > my problem with this stuff is conceptual: it introduces a constant drag on
 > the kernel sourcecode, while 99% of development will not want to trace,
 > ever. When i do need tracing occasionally, then i take those 30 minutes to
 > write up a tracer from pre-existing tracing patches, tailored to specific
 > problems. Eg. for the scheduler i wrote a simple tracer, but the rate of
 > trace points that started to make sense for me from a development and
 > debugging POV also made kernel/sched.c butt-ugly and unmaintainable, so i
 > always kept the tracer separate and did the hacking in the untained code.
 > 
 > also, the direction things are taking these days seems to be towards
 > hardware-assisted tracing. Ie. on the P4 we can recover a trace of EIPs
 > traversed by the CPU recently. Stuff like this is powerful and can can
 > debug bugs that cannot be debugged via software. I've seen and debugged
 > dozens of subtle bugs that went away if a software-tracer was enabled, in
 > fact i debugged at least 3 scheduler bugs which triggered on the removal
 > of a specific trace point. Sw-tracing, and especially the kind of
 > intrusive stuff you are doing has its limitations and side-effects. It's
 > also something that comes from the closed-source world, there kernels must
 > have tracing APIs because otherwise debugging drivers and subsystems would
 > be much easier. It does have its uses, no doubt, but usually we apply
 > things to the kernel that have either a positive, or at worst, a neutral
 > impact on the kernel proper - kernel tracing clearly is not such a
 > feature.
 > 
 > so use the power of the GPL-ed kernel and keep your patches separate,
 > releasing them for specific stable kernel branches (or even development
 > kernels). If anything then i'm biased towards tracer code, eg. i wrote the
 > first versions of ktrace (source-unintrusive tracer) and iotrace
 > (source-intrusive tracer), and i for one do not want to have *any* trace
 > points in any of the code i hack on a daily basis. This stuff must stay
 > separate.
 > 
 > 	Ingo
 > 
 > 
 > _______________________________________________
 > ltt-dev mailing list
 > ltt-dev@listserv.shafik.org
 > http://www.listserv.shafik.org/listserv/listinfo/ltt-dev
