Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282773AbRK0Dmx>; Mon, 26 Nov 2001 22:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282775AbRK0Dml>; Mon, 26 Nov 2001 22:42:41 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:2314 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282773AbRK0DmL>; Mon, 26 Nov 2001 22:42:11 -0500
Date: Mon, 26 Nov 2001 19:52:20 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc-based cpu affinity user interface
In-Reply-To: <1006831902.842.0.camel@phantasy>
Message-ID: <Pine.LNX.4.40.0111261948460.1674-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Nov 2001, Robert Love wrote:

> Attached is my procfs-based implementation of a user interface for
> getting and setting a task's CPU affinity.  Patch is against 2.4.16.
>
> The kernel already respects affinity, which is stored in
> task_struct->cpus_allowed.
>
> Reading and writing /proc/<pid>/affinity will get and set the affinity.
>
> Security is implemented: the writer must possess CAP_SYS_NICE or be the
> same uid as the task in question.  Anyone can read the data.
>
> The read mask will be ANDed with cpu_online_map, so that only valid bits
> are returned.  The written data must have _some_ valid bits in it.
> I.e., ffffffff is valid on a 2-way system but 01000000 probably is not.
> Note you don't need to pass the full mask, e.g. "64" is legal.  When a
> new mask is set, a reschedule is forced to put the task on a legal CPU.
>
> Note I had to implement a proc_write function for the procfs (pid)
> code.  This is generic and can be used by other, writable, entries.
>
> This patch comes as an alternative to Ingo Molnar's syscall-implemented
> variant.  Ingo's code is good; however I and others expressed discontent
> at yet another group of syscalls.  Other benefits include the ease with
> which to set the affinity of tasks that are unaware of the new interface
> and that with this approach applications don't need to check for the
> existence of a syscall.
>
> Comments?

As I said in reply to Ingo patch, it'd be better to expose "number" cpu
masks not "logical" ( like cpus_allowed ).
In this way the users can use 0..N-1 ( N == number of cpus phisically
available ) w/out having to know the internal mapping between logical and
number ids.




- Davide


