Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262565AbSJBUWA>; Wed, 2 Oct 2002 16:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262572AbSJBUWA>; Wed, 2 Oct 2002 16:22:00 -0400
Received: from franka.aracnet.com ([216.99.193.44]:50355 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262565AbSJBUV7>; Wed, 2 Oct 2002 16:21:59 -0400
Date: Wed, 02 Oct 2002 13:25:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple NUMA scheduler patch
Message-ID: <953763699.1033565134@[10.10.2.3]>
In-Reply-To: <200210021954.39358.efocht@ess.nec.de>
References: <200210021954.39358.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it's a start. But I'm afraid a full solution will need much more code
> (which is one of the problems with my NUMA scheduler patch).

Right, but a sequence of smaller patches will be easier to get in.
I see this as a first step towards your larger patch ... if we can
do something simpler like Michael has, with enough view to your
later plans to make them merge together cleanly, I think we have
the best of both worlds ... Erich, what would it take to make this
a first stepping stone towards what you have? Or is it there already?

The fact that Michael's patch seems to have better performance (at
least for the very simple tests I've done) seems to reinforce the
"many small steps" approach in my mind - it's easier to debug and
analyse like that.
 
> The ideas behind your patch are:
> 2. Favor own node for stealing if any CPU on the own node is >25%
> more loaded. Otherwise steal from another CPU if that one is >100%
> more loaded.
> ...
> 2. is ok as it makes it harder to change the node. But again, you don't
> aim at equally balanced nodes. And: if the task gets away from the node
> on which it got its memory, it has no reason to ever come back to it.

I don't think we should aim too hard for exactly equal balancing,
it may well result in small peturbations causing task bouncing between
nodes. 

> For a final solution I believe that we will need targets like:
> (a) equally balance nodes
> (b) return tasks to the nodes where their memory is
> (c) make nodes "sticky" for tasks which have their memory on them,
> "repulsive" for other tasks.

I'd add:

(d) take into account the RSS when migrating tasks across nodes
    (ie stickiness is proportional to amount of RAM used on nodes)

> But for a first attempt to get the scheduler more NUMA aware all this
> might be just too much.

Agreed ;-)

M.

