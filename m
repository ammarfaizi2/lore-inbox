Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318649AbSHWIFx>; Fri, 23 Aug 2002 04:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318706AbSHWIFx>; Fri, 23 Aug 2002 04:05:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:42062 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S318649AbSHWIFw>; Fri, 23 Aug 2002 04:05:52 -0400
Date: Fri, 23 Aug 2002 09:10:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Gilad Ben-Yossef <gilad@benyossef.com>
cc: James Bourne <jbourne@mtroyal.ab.ca>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Hyperthreading
In-Reply-To: <1030087689.25063.7.camel@gby.benyossef.com>
Message-ID: <Pine.LNX.4.44.0208230852320.9367-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Aug 2002, Gilad Ben-Yossef wrote:
> 
> hmm... isn't there an option to tell the kernel you are using a
> HyperThreaded system, or is it detected on runtime?  I mean, think about
> a P4 Xeon 2 way SMP - unless told otherwise the kernel will 'see' it as
> a 4 way SMP box *but* the proccessors are not equel!

There is the "noht" boot arg to tell the kernel not to use HT,
and there is the X86_FEATURE_HT cpu capability flag, but I think
the runtime indication you're looking for is smp_num_siblings:
1 without HT, 2 (ever more?) with HT.

> If for example, you have a task running and another task just woke up
> and the scheduler needs to assign a CPU for it, choosing the other
> 'instance' of the same CPU as the already running task to run it on as
> opposed to choosing one of the 'instanaces' of the other seperate CPU
> seems a mistake IMHO, but the scheduler won't be able to make the
> judgment because it doesn't know it is running on a SMT box at all.

SMT I don't know.  Your point is valid, and you'll find the 2.4 -aa
and -ac trees (both using newer O1 scheduler) each have code in (or
called out from) kernel/sched.c to deal with that.

The mainline 2.4 does not take that into consideration, and so far
as I can see (please correct me), nor does 2.5 as yet - will probably
get added from 2.4 -aa or -ac in due course.  It's not an issue of
correctness, just optimality.

Hugh

