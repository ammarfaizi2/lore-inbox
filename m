Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVHWQyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVHWQyD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 12:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVHWQyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 12:54:03 -0400
Received: from fmr21.intel.com ([143.183.121.13]:2998 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750854AbVHWQyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 12:54:02 -0400
Date: Tue, 23 Aug 2005 12:57:32 -0400
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Linux AIO status & todo
Message-ID: <20050823165732.GD4630@linux.intel.com>
References: <20050823074438.GA4586@in.ibm.com> <20050823095609.GZ7403@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050823095609.GZ7403@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 05:56:09AM -0400, Jakub Jelinek wrote:
> POSIX AIO needs to handle SIGEV_NONE, SIGEV_SIGNAL and SIGEV_THREAD
> notification.  Obviously kernel shouldn't create threads for SIGEV_THREAD
> itself, as kernel shouldn't hardcode all the implementation details how a
> thread can be created.  But it would be good if AIO signalling e.g. handled
> both SIGEV_SIGNAL and SIGEV_SIGNAL | SIGEV_THREAD_ID, with the same usage as
> e.g. timer_* syscalls.  If kernel makes sure SI_ASYNCIO si_code is set in
> the notification signal siginfos, glibc could even use just one helper
> thread for timer_*/[al]io_* and maybe in the future other SIGEV_THREAD notification.

The signal patch from Sebastien should handle the SIGEV_foo.  The patch 
at http://www.kvack.org/~bcrl/patches/aio-2.6.13-rc6-B1/817_sigevent.diff 
has the latest changes from me and should do what is needed.

		-ben
