Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbUKXVrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbUKXVrp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbUKXVps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:45:48 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43399 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262692AbUKXVop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:44:45 -0500
Date: Wed, 24 Nov 2004 21:41:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Michael Kerrisk <mtk-lkml@gmx.net>
cc: Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <michael.kerrisk@gmx.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Further shmctl() SHM_LOCK strangeness
In-Reply-To: <7379.1101327249@www30.gmx.net>
Message-ID: <Pine.LNX.4.44.0411242124400.2769-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, Michael Kerrisk wrote:
> 
> While studying the RLIMIT_MEMLOCK stuff further, I came 
> up with another observation: a process can perform a
> shmctl(SHM_LOCK) on *any* System V shared memory segment, 
> regardles of the segment's ownership or permissions,
> providing the size of the segment falls within the 
> process's RLIMIT_MEMLOCK limit.

That's a very good observation.

I think it's unintended, but I'm not sure.
I've forgotten what can_do_mlock on shm was about.

Offhand I find it hard to grasp whether it's harmless or bad,
but inclined to think bad - if there happen to be lots of small
enough shared memory segments on the system, a series of processes
run by one unprivileged user can lock down lots of memory?

Isn't it further the case that any process can now SHM_UNLOCK
any segment?  That would surely be wrong.

I've added Rik and Chris to the CC list, they seem to be the
main can_do_mlock guys, hope they can answer.

Hugh

> Is this intended behaviour?  For most other System V IPC 
> "ctl" operations the process must either:
> 
> 1. be the owner of the object or have an appropriate 
>    capability, or
> 
> 2. have suitable permissions on the object.
> 
> Which of these two conditions applies depends on the
> "ctl" operation.

