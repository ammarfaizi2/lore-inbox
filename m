Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVDHIPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVDHIPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVDHILi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 04:11:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33016 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S262756AbVDHIFK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 04:05:10 -0400
Subject: Re: [PATCH] Priority Lists for the RT mutex
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Ingo Molnar <mingo@elte.hu>, joe.korty@ccur.com
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       inaky.perez-gonzalez@intel.com, Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <20050408062811.GA19204@elte.hu>
References: <1112896344.16901.26.camel@dhcp153.mvista.com>
	 <20050408062811.GA19204@elte.hu>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 01:05:03 -0700
Message-Id: <1112947503.7093.28.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 08:28 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > 	This patch adds the priority list data structure from Inaky 
> > Perez-Gonzalez to the Preempt Real-Time mutex.
> 
> this one looks really clean.
> 
> it makes me wonder, what is the current status of fusyn's? Such a light 
> datastructure would be much more mergeable upstream than the former 
> 100-queues approach.

Ingo,

Joe Korty has been doing a lot of work on Fusyn recently.

Fusyn is now a generic implementation, similar to the RT mutex. SMP
scalability is somewhat better for decoupled locks on PI (last I
checked). It has the extra bulk required to support user space.

The major issue that concerns the Fusym and the real-time patch is that
merging the kernel portion of Fusyn creates a collision of redundant PI
implementations with respect to the RT mutex.

The issues are outlined here:

http://developer.osdl.org/dev/mutexes/

There are a few mistakes on the page, (RT mutex does not do priority
ceiling), but for the most part the info is current.

If the RT mutex could be exposed in non PREEMPT_RT configurations,
the fulock portion could be superseded by the RT mutex, and the
remaining pieces merged in. Or vice versa.

We discussed the scenarios recently, any guidance you can offer to help
us out would be greatly appreciated.

http://lists.osdl.org/pipermail/robustmutexes/2005-April/000532.html


Sven


