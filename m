Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289446AbSAOJVd>; Tue, 15 Jan 2002 04:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289455AbSAOJVX>; Tue, 15 Jan 2002 04:21:23 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:16272 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289446AbSAOJVK>; Tue, 15 Jan 2002 04:21:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: george anzinger <george@mvista.com>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 15 Jan 2002 09:32:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <16QNVQ-2JqEACC@fwd03.sul.t-online.com> <3C43D5E1.6785695C@mvista.com>
In-Reply-To: <3C43D5E1.6785695C@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16QP1L-0yTNqqC@fwd02.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 January 2002 08:10, george anzinger wrote:

> Yes, this is classic priority inversion.  It is here now, today with
> semaphors which are held by code that blocks.  If the code doesn't
> block, why not use a spin lock?  If it does, well the problem is here

Because eg. other code that holds the semaphore needs to sleep

> now.  I suppose we could set a preempt disable around a semaphore if it
> makes you feel better.  It doesn't fix the problem if the task blocks

It would make me feel better, but it would defeat the purpose.
There's a lot of code holding semaphores.

> AND it is legal to block while holding a preemption lock.

But it's easier to fix. If you can preempt only by explicitely
sleeping, you can beat priority invasion by changing basically
only wake_up. If you can be preempted at random, you need to know
who holds a semaphore.

	Regards
		Oliver
