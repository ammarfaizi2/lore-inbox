Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWFBPWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWFBPWO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 11:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWFBPWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 11:22:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41121 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932356AbWFBPWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 11:22:13 -0400
To: Preben Traerup <Preben.Trarup@ericsson.com>
Cc: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com>
	<20060530145658.GC6536@in.ibm.com>
	<20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>
	<20060531154322.GA8475@in.ibm.com>
	<20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com>
	<20060601151605.GA7380@in.ibm.com>
	<20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com>
	<44800E1A.1080306@ericsson.com>
	<m1fyin6agv.fsf@ebiederm.dsl.xmission.com>
	<44803B1F.8070302@ericsson.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 02 Jun 2006 09:20:52 -0600
In-Reply-To: <44803B1F.8070302@ericsson.com> (Preben Traerup's message of
 "Fri, 02 Jun 2006 15:20:31 +0200")
Message-ID: <m13ben60tn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Preben Traerup <Preben.Trarup@ericsson.com> writes:

> Something like out of memory and oops-es are enough to deeme the system must
> panic
> because it is simply not supposed to happen in a Telco server at any time.

That is clearly enough to deem that the system must take some sever action and
stop running.  You don't necessarily have to handle it through a kernel panic.

> kdump helps debugging these cases, but more importantly another server
> must take over the work, and this has and always will have highest priority.
>
> I'm happy about what crash_kexec does today, but the timing issue makes it
> unusable for
> notifications to external systems, if I need to wait until properly running in
> next kernel.

Nothing says you have to wait until properly running in the next kernel.
You can also write a dedicated piece of code that just pushes one packet
out the NIC.  Then you can start up a kernel for analysis purposes.

Although I have a hard time believing you can't tune a kernel to start
up quickly enough if you leave out just about everything.

And for purposes analysis assume that the oops happened somewhere in 
the network stack.

> That leaves me the choice of doing notification before executing crash_kexec ?

Only because you have assumed that you have to start another kernel and 
starting that other kernel must be an expensive operation.

> Since I'm apperantly not the only one left with this choice I rather prefer a
> solution
> made in public, that is known to be "bad" in some (well known) situations than
> each and everybody implements their own solution to the same problem.

It is certainly worth discussing.

Eric
