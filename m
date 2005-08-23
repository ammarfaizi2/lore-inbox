Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVHWJ4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVHWJ4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 05:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVHWJ4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 05:56:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22160 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932114AbVHWJ4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 05:56:22 -0400
Date: Tue, 23 Aug 2005 05:56:09 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Linux AIO status & todo
Message-ID: <20050823095609.GZ7403@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20050823074438.GA4586@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050823074438.GA4586@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 01:14:38PM +0530, Suparna Bhattacharya wrote:

> 	2. No support for propagating IO completion events to user space
> 	   threads using RT signals. User threads need to poll the completion
> 	   queue using io_getevents. POSIX specifies that when an AIO
> 	   request completes, a signal can be delivered to the application
> 	   to indicate the completion of the IO.

POSIX AIO needs to handle SIGEV_NONE, SIGEV_SIGNAL and SIGEV_THREAD
notification.  Obviously kernel shouldn't create threads for SIGEV_THREAD
itself, as kernel shouldn't hardcode all the implementation details how a
thread can be created.  But it would be good if AIO signalling e.g. handled
both SIGEV_SIGNAL and SIGEV_SIGNAL | SIGEV_THREAD_ID, with the same usage as
e.g. timer_* syscalls.  If kernel makes sure SI_ASYNCIO si_code is set in
the notification signal siginfos, glibc could even use just one helper
thread for timer_*/[al]io_* and maybe in the future other SIGEV_THREAD notification.

	Jakub
