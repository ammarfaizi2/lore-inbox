Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268928AbUJEJbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268928AbUJEJbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 05:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUJEJ3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 05:29:49 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:7321 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S268928AbUJEJ3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 05:29:36 -0400
Date: Tue, 5 Oct 2004 11:26:43 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Paul Jackson <pj@sgi.com>, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
In-Reply-To: <843670000.1096902220@[10.10.2.4]>
Message-ID: <Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]><200408061730.06175.efocht@hpce.nec.com><20040806231013.2b6c44df.pj@sgi.com><411685D6.5040405@watson.ibm.com><20041001164118.45b75e17.akpm@osdl.org><20041001230644.39b551af.pj@sgi.com><20041002145521.GA8868@in.ibm.com><415ED3E3.6050008@watson.ibm.com><415F37F9.6060002@bigpond.net.au><821020000.1096814205@[10.10.2.4]><20041003083936.7c844ec3.pj@sgi.com><834330000.1096847619@[10.10.2.4]><835810000.1096848156@[10.10.2.4]><20041003175309.6b02b5c6.pj@sgi.com><838090000.1096862199@[10.10.2.4]>
 <20041003212452.1a15a49a.pj@sgi.com> <843670000.1096902220@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2004, Martin J. Bligh wrote:

> OK, then your "exclusive" cpusets aren't really exclusive at all, since
> they have other stuff running in them. The fact that you may institute
> the stuff early enough to avoid most things falling into this doesn't
> really solve the problems, AFAICS. 

I'd like to present you at this point what was the original decision for 
having exclusive (called strict, at this point in history) and 
non-exclusive cpusets.

The idea was to have a system, and run all jobs on it through a batch 
scheduler. Some jobs cared about performance, some didn't.

The ones who cared about performance got an 'exclusive' cpuset, the ones 
who didn't got a 'non exclusive' cpuset.

Now there is a possibility, that at a given time, only 'exclusive' jobs 
are running, and hence that 'exclusive' cpusets have been created for jobs 
on all the CPUs.

Our system (at Bull) is both a big and a small machine:
-big:   we have NUMA constraints.
-small: we don't have enough CPUs to spare one, we need to use ALL CPUs 
for our jobs.

There are still processes running outside the job cpusets (i.e in the root 
cpuset), sshd, the batch scheduler. These tasks use a low amount of CPU, 
so it is okay if they happen to run inside even 'exclusive' cpusets. For 
us, 'exclusive' only means that no other CPU-hungry job is going to share 
our CPU.

Of course, in our case, a valid argument is that 'exclusiveness' should 
not be enforced by the kernel but rather by the job scheduler. Probably.

But now I see that the discussion is going towards:
-fully exclusive cpusets, maybe even with no interrupts handling
-maybe only allow exclusive cpusets, since non-exclusive cpusets are 
tricky wrt CKRM.

That would be a no-go for us.


	Simon.

