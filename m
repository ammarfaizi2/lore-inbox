Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbUKYD3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUKYD3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 22:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUKYD3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 22:29:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40355 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262953AbUKYD3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 22:29:19 -0500
Date: Wed, 24 Nov 2004 22:17:05 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: Michael Kerrisk <mtk-lkml@gmx.net>, Chris Wright <chrisw@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       michael.kerrisk@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: Further shmctl() SHM_LOCK strangeness
In-Reply-To: <Pine.LNX.4.44.0411242124400.2769-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0411242216210.10497@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0411242124400.2769-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, Hugh Dickins wrote:

>> regardles of the segment's ownership or permissions,
>> providing the size of the segment falls within the
>> process's RLIMIT_MEMLOCK limit.

> Offhand I find it hard to grasp whether it's harmless or bad,
> but inclined to think bad - if there happen to be lots of small
> enough shared memory segments on the system, a series of processes
> run by one unprivileged user can lock down lots of memory?

Mlocking and munlocking of shm segments is accounted
against the user_struct, not against the process.

This should stop any malicious exploits.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
