Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132865AbRDDRrt>; Wed, 4 Apr 2001 13:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132867AbRDDRra>; Wed, 4 Apr 2001 13:47:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:38543 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S132865AbRDDRr0>; Wed, 4 Apr 2001 13:47:26 -0400
Subject: Re: [Lse-tech] Re: a quest for a better scheduler
To: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Cc: andrea@suse.de (Andrea Arcangeli), fabio@chromium.com (Fabio Riccardi),
        "Hubertus Franke" <frankeh@us.ibm.com>,
        linux-kernel@vger.kernel.org (Linux Kernel List),
        lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net,
        mingo@elte.hu (Ingo Molnar), mkravetz@sequent.com (Mike Kravetz)
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF663D4309.4893E3D3-ON88256A24.006118C3@LocalDomain>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Wed, 4 Apr 2001 10:40:49 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 04/04/2001 11:45:19 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just a quick comment. Andrea, unless your machine has some hardware
> that imply pernode runqueues will help (nodelevel caches etc), I fail
> to understand how this is helping you ... here's a simple theory though.
> If your system is lightly loaded, your pernode queues are actually
> implementing some sort of affinity, making sure processes stick to
> cpus on nodes where they have allocated most of their memory on. I am
> not sure what the situation will be under huge loads though.

Exactly.  If a given task has run on a particular nodes for a while,
its memory will tend to be allocated on that node.  So preferentially
running it on another CPU on that same node should get you better
memory latency than would running it on some other node's CPUs.

In addition, continuing to run the task on a particular node means
that more of that task's memory is from that node, which again means
good memory latency.  In contrast, if you move a task back and forth
between nodes, it can end up with its memory spread over many nodes,
which means that it does not get good memory latency no matter where
you run it.

                              Thanx, Paul

> As I have mentioned to some people before,
percpu/pernode/percpuset/global
> runqueues probably all have their advantages and disadvantages, and their
> own sweet spots. Wouldn't it be really neat if a system administrator
> or performance expert could pick and choose what scheduler behavior he
> wants, based on how the system is going to be used?
>
> Kanoj

