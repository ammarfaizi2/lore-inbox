Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287521AbSAEFWS>; Sat, 5 Jan 2002 00:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287522AbSAEFWB>; Sat, 5 Jan 2002 00:22:01 -0500
Received: from SMTP7.ANDREW.CMU.EDU ([128.2.10.87]:60686 "EHLO
	smtp7.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S287521AbSAEFVs>; Sat, 5 Jan 2002 00:21:48 -0500
Date: Sat, 5 Jan 2002 00:21:44 -0500 (EST)
From: Steinar Hauan <hauan@cmu.edu>
X-X-Sender: <hauan@unix13.andrew.cmu.edu>
To: "J.A. Magallon" <jamagallon@able.es>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: smp cputime issues (patch request ?)
In-Reply-To: <20020103022705.A3163@werewolf.able.es>
Message-ID: <Pine.GSO.4.33L-022.0201050016110.15393-100000@unix13.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, J.A. Magallon wrote:
> Cache pollution problems ?
>
> As I understand, your job does not use too much memory, does no IO,
> just linear algebra (ie, matrix-times-vector or vector-plus-vector
> operations). That implies sequential access to matrix rows and vectors.

very correct.

> Problem with linux scheduler is that processes are bounced from one CPU
> to the other, they are not tied to one, nor try to stay in the one they
> start, even if there is no need for the cpu to do any other job.

one of the tips received was to set the penalty for cpu switch, i.e. set

  linux/include/asm/smp.h:#define PROC_CHANGE_PENALTY   15

to a much higher value (50). this had no effect on the results.

> On an UP box, the cache is useful to speed up your matrix-vector ops.
> One process on a 2-way box, just bounces from one cpu to the other,
> and both caches are filled with the same data. Two processes on two
> cpus, and everytime they 'swap' between cpus they trash the previous
> cache for the other job, so when it returs it has no data cached.

this would be an issue, agreed, but cache invalidation by cpu bounces
should also affect one-cpu jobs? thus is does not explain why this
effect should be (much) worse with 2 jobs.

regards,
--
  Steinar Hauan, dept of ChemE  --  hauan@cmu.edu
  Carnegie Mellon University, Pittsburgh PA, USA

