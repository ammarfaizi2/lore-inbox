Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVEMUgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVEMUgS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVEMUfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:35:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8348 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262538AbVEMUXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:23:52 -0400
Date: Fri, 13 May 2005 16:23:46 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: ritesh@cs.unc.edu
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: NPTL: stack limit limiting number of threads
Message-ID: <20050513202346.GG17420@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <fc67f8b705051312494a0badf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc67f8b705051312494a0badf7@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 03:49:48PM -0400, Ritesh Kumar wrote:
> However, I was most amazed to see that the limit on stack size on
> FreeBSD (5.3 Release) was 64M by default! I was just wondering, how is
> FreeBSD able to create about a 1000 threads with that kind of a stack
> limit. Also, is there anything specific in its implementation which
> makes it difficult to incorporate in Linux? Wouldn't it be a good idea
> to remove this "trade-off" between stack limit and number of threads
> and fail thread creation only when we have run out of address space
> being *actually used* in the stacks in a process.

On FreeBSD the default thread stack size is not computed from ulimit -s,
but is constant.  They apparently only recently increased it to 1MB
(resp. 2MB on 64-bit arches), from 64K.

On Linux, the default thread stack size (except with fixed stack LinuxThreads)
is determined from ulimit -s (with a constant default if ulimit -s is
unlimited).

If your threaded application has specific needs for stack sizes, it can
always pthread_attr_setstacksize to whatever you find appropriate.

The thread library needs to know the stack size limit before creating
the thread, that can't be changed dynamically.

	Jakub
