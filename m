Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287538AbSAEFvd>; Sat, 5 Jan 2002 00:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287540AbSAEFvY>; Sat, 5 Jan 2002 00:51:24 -0500
Received: from otter.mbay.net ([206.40.79.2]:776 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S287538AbSAEFvS> convert rfc822-to-8bit;
	Sat, 5 Jan 2002 00:51:18 -0500
From: John Alvord <jalvo@mbay.net>
To: Steinar Hauan <hauan@cmu.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: smp cputime issues (patch request ?)
Date: Fri, 04 Jan 2002 21:51:12 -0800
Message-ID: <tt4d3uoubkg4vu5si7suoqkr9g7fq5ogtt@4ax.com>
In-Reply-To: <20020103022705.A3163@werewolf.able.es> <Pine.GSO.4.33L-022.0201050016110.15393-100000@unix13.andrew.cmu.edu>
In-Reply-To: <Pine.GSO.4.33L-022.0201050016110.15393-100000@unix13.andrew.cmu.edu>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002 00:21:44 -0500 (EST), Steinar Hauan <hauan@cmu.edu>
wrote:

>On Thu, 3 Jan 2002, J.A. Magallon wrote:
>> Cache pollution problems ?
>>
>> As I understand, your job does not use too much memory, does no IO,
>> just linear algebra (ie, matrix-times-vector or vector-plus-vector
>> operations). That implies sequential access to matrix rows and vectors.
>
>very correct.
>
>> Problem with linux scheduler is that processes are bounced from one CPU
>> to the other, they are not tied to one, nor try to stay in the one they
>> start, even if there is no need for the cpu to do any other job.
>
>one of the tips received was to set the penalty for cpu switch, i.e. set
>
>  linux/include/asm/smp.h:#define PROC_CHANGE_PENALTY   15
>
>to a much higher value (50). this had no effect on the results.
>
>> On an UP box, the cache is useful to speed up your matrix-vector ops.
>> One process on a 2-way box, just bounces from one cpu to the other,
>> and both caches are filled with the same data. Two processes on two
>> cpus, and everytime they 'swap' between cpus they trash the previous
>> cache for the other job, so when it returs it has no data cached.
>
>this would be an issue, agreed, but cache invalidation by cpu bounces
>should also affect one-cpu jobs? thus is does not explain why this
>effect should be (much) worse with 2 jobs.

One factor to consider is that to see it bounce, you need to be
running an observation process like top, or if it is a GUI display two
processes (application and X). Those observing processes will
continuosly bump aside the calcuation processes, causing a bouncing
effect.

john
