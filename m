Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268162AbUJDPEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268162AbUJDPEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUJDPEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:04:53 -0400
Received: from jade.aracnet.com ([216.99.193.136]:19074 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268162AbUJDPEt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:04:49 -0400
Date: Mon, 04 Oct 2004 08:03:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <843670000.1096902220@[10.10.2.4]>
In-Reply-To: <20041003212452.1a15a49a.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]><200408061730.06175.efocht@hpce.nec.com><20040806231013.2b6c44df.pj@sgi.com><411685D6.5040405@watson.ibm.com><20041001164118.45b75e17.akpm@osdl.org><20041001230644.39b551af.pj@sgi.com><20041002145521.GA8868@in.ibm.com><415ED3E3.6050008@watson.ibm.com><415F37F9.6060002@bigpond.net.au><821020000.1096814205@[10.10.2.4]><20041003083936.7c844ec3.pj@sgi.com><834330000.1096847619@[10.10.2.4]><835810000.1096848156@[10.10.2.4]><20041003175309.6b02b5c6.pj@sgi.com><838090000.1096862199@[10.10.2.4]> <20041003212452.1a15a49a.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Paul Jackson <pj@sgi.com> wrote (on Sunday, October 03, 2004 21:24:52 -0700):

> Martin wrote:
>> Then when I fork off exclusive subset for CPUs 1&2, I have to push A & B
>> into it.
> 
> Tasks A & B must _not_ be considered members of that exclusive cpuset,
> even though it seems that A & B must be attended to by the sched_domain
> and memory_domain associated with that cpuset.
> 
> The workload managers expect to be able to list the tasks in a cpuset,
> so it can hibernate, migrate, kill-off, or wait for the finish of these
> tasks.  I've been through this bug before - it was one that cost Hawkes
> a long week to debug - I was moving the per-cpu migration threads off
> their home CPU because I didn't have a clear way to distinguish tasks
> genuinely in a cpuset, from tasks that just happened to be indigenous to
> some of the same CPUs.  My essential motivation for adapting a cpuset
> implementation that has a task struct pointer to a shared cpuset struct
> was to track exactly this relation - which tasks are in which cpuset.
> 
> No ... tasks A & B are not allowed in that new exclusive cpuset.

OK, then your "exclusive" cpusets aren't really exclusive at all, since
they have other stuff running in them. The fact that you may institute
the stuff early enough to avoid most things falling into this doesn't
really solve the problems, AFAICS. 

Or perhaps we end up cpuset alpha and beta that you created, and we create
parallel cpusets that operate on the same sched_domain tree to contain the
other random stuff.

Kind of "cpu groups" and "task groups", where you can have multiple task
groups running on the same cpu group (or subset thereof), but not overlapping 
different cpu groups. Then we can have one sched domain setup per cpu group,
or at least the top level entry in the main sched domain tree. This way the
scheduler might have a hope of working within this system efficiently ;-)

M.

