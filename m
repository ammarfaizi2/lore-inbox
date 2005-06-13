Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVFMTih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVFMTih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVFMTih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:38:37 -0400
Received: from gorgon.vtab.com ([62.20.90.195]:11985 "EHLO gorgon.vtab.com")
	by vger.kernel.org with ESMTP id S261227AbVFMTi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:38:27 -0400
Date: Mon, 13 Jun 2005 21:38:20 +0200
Message-Id: <200506131938.j5DJcKc10799@virtutech.se>
From: "=?ISO-8859-1?Q?Mattias Engdeg=E5rd?=" <mattias@virtutech.se>
To: Jakub Jelinek <jakub@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       David Woodhouse <dwmw2@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: Add pselect, ppoll system calls.
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think passing const struct timeval * or const struct timespec *
> (depending if you want micro or nanoseconds) is better and what
> other functions use for timeouts, then passing int64_t.

If we can design ppoll() any way we like, which seems likely, I would
prefer having the timeout given as an absolute timestamp. It would
save some gettimeofday() (or clock_gettime()) syscalls and simplify
user code in common cases.

If I'm not mistaken, sem_timedwait() and pthread_cond_timedwait() were
designed to take an absolute timeout for this reason.
