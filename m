Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278330AbRJMQWH>; Sat, 13 Oct 2001 12:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278324AbRJMQV5>; Sat, 13 Oct 2001 12:21:57 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:38921 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S278325AbRJMQVr>; Sat, 13 Oct 2001 12:21:47 -0400
Subject: Re: cpus_allowed
From: Robert Love <rml@tech9.net>
To: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01101316594000.02369@home01>
In-Reply-To: <01101316594000.02369@home01>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.12.08.08 (Preview Release)
Date: 13 Oct 2001 12:22:15 -0400
Message-Id: <1002990137.868.59.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-13 at 19:59, Rolf Fokkens wrote:
> I was curious about "CPU affinity" in linux. I found some patches which add 
> affinity in task_struct but later I found out that "cpus_allowed" in 
> task_struct almost does the same thing.
> 
> It resulted in some new curiosity: where's cpus_allowed initialized? I can 
> only find an assignment to cpus_allowed for softirq's but no initialization 
> for other processes. I assume the correct init value would be "0xffffffff" or 
> -1. Can't find it though.
> 
> I'm sure I'm overlooking something, but that doesn't help me finding the 
> answer. So would someone be so kind to enlighten me?

It is initialized to -1 (0xffffffff) by struct definition at
linux/kernel/sched.h.  Since it is a mask, this means all CPUs
(obviously).

It isn't used much.  The softirq code uses it to try to keep some tasks
on one CPU, for performance reasons.  The Tux in-kernel httpd uses it
for performance reasons.  Some patches use it, too.

Most of the CPU affinity patches you see were written before
cpus_allowed.  They go through all sorts of trouble to do what the OS
now does on its own.  If you want to change CPU affinity then you just
need a patch that adds a syscall or proc interface for setting the
cpus_allowed mask.

I wrote a proc interface but for the life of me I can't find it.  If you
can I would be happy to update it to your kernel.  It isn't very old,
anyhow.

Andrew Morton wrote has a similar patch that is quite good.  Get it at
http://www.uow.edu.au/~andrewm/linux/#cpus_allowed

	Robert Love

