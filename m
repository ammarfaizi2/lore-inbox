Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262585AbRFEKgE>; Tue, 5 Jun 2001 06:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262586AbRFEKfy>; Tue, 5 Jun 2001 06:35:54 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:39437 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262585AbRFEKfn>; Tue, 5 Jun 2001 06:35:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Anil Kumar" <anilk@subexgroup.com>,
        "Mihai Moise" <mmoise@giref.ulaval.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: semaphores and noatomic flag
Date: Tue, 5 Jun 2001 12:37:53 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <NEBBIIKAMMOCGCPMPBJOCEGICEAA.anilk@subexgroup.com>
In-Reply-To: <NEBBIIKAMMOCGCPMPBJOCEGICEAA.anilk@subexgroup.com>
MIME-Version: 1.0
Message-Id: <01060512375300.00553@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Mihai Moise
> 
> up(semaphore 1)		/* wake up client */
> down(semaphore 0)	/* put iself to sleep */
>
> The problem is that the two system calls make the whole process twice
> as slow as it needs to be, and they are both needed because the semop
> system call is implemented in an atomic manner. If the semop system
> call had an IPC_NOATOMIC flag, then the each process would only have
> to do one call,
>
> semop(up semaphore 0 & down semaphore 1, IPC_NOATOMIC)
>
> which would be interpreted in the kernel as the sequence of two
> system calls I have written previously.

On Tuesday 05 June 2001 08:28, Anil Kumar wrote:
> Will it not be a very specialized case rather than being general call
> type?

The concept is general and useful, though I don't think its expression 
here is correct.  A similar feature used in dynix was described earlier 
in some detail by  Paul Cassella:

    http://marc.theaimsgroup.com/?l=linux-kernel&m=97742705300697&w=2
    (Re: [RFC] Semaphores used for daemon wakeup)

The idea is to atomically release one serializer and grab another.  We 
have quite a few flavors of lock so square that and you have the number 
of primitives you'd need for a complete set.

To sell the idea you'd have to come up with a few places where the new 
primitives would make the kernel run better, then you'd have to 
implement it or find someone with the necessary scheduler hacking 
skills to do it for you.  The last part is the tricky one. ;-)

--
We had 
