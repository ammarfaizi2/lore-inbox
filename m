Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282953AbRK0VBs>; Tue, 27 Nov 2001 16:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282954AbRK0VBl>; Tue, 27 Nov 2001 16:01:41 -0500
Received: from zero.tech9.net ([209.61.188.187]:522 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282951AbRK0VB0>;
	Tue, 27 Nov 2001 16:01:26 -0500
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
From: Robert Love <rml@tech9.net>
To: Andi Kleen <ak@suse.de>
Cc: Joe Korty <l-k@mindspring.com>, linux-kernel@vger.kernel.org
In-Reply-To: <p73lmgssm79.fsf@amdsim2.suse.de>
In-Reply-To: <1006832357.1385.3.camel@icbm.suse.lists.linux.kernel>
	<5.0.2.1.2.20011127020817.009ed3d0@pop.mindspring.com.suse.lists.linux.kerne
	 l>  <p73lmgssm79.fsf@amdsim2.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 27 Nov 2001 16:01:55 -0500
Message-Id: <1006894915.819.6.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-27 at 02:32, Andi Kleen wrote:
> Could you quickly explain an use case where it makes a difference if 
> CPU affinity settings for multiple processes are done atomically or not ? 
> 
> The only way to make CPU affinity settings of processes really atomically 
> without a "consolidation window" is to
> do them before the process starts up. This is easy when they're inherited --
> just set them for the parent before starting the other processes. This 
> works with any interface; proc based or not as long as it inherits.

I assume he meant to prevent the case of setting affinity _after_ a
process forks.  In other words, "atomically" in the sense that it occurs
prior to some action, in order to affect properly all children.

This could be done in program with by writing to the proc entry before
forking, or can be done in a wrapper script (set affinity of self, exec
new task).

cpus_allowed is inherited by all children so this works fine.

	Robert Love

