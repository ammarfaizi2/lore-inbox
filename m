Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUCKNLc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUCKNLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:11:32 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:25254 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261246AbUCKNL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:11:28 -0500
Subject: Re: [PATCH] backing dev unplugging
From: Christophe Saout <christophe@saout.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       thornber@redhat.com
In-Reply-To: <20040311122203.GX6955@suse.de>
References: <20040310124507.GU4949@suse.de>
	 <1079007445.26633.4.camel@leto.cs.pocnet.net>
	 <20040311122203.GX6955@suse.de>
Content-Type: text/plain
Message-Id: <1079010679.28993.6.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 14:11:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 11.03.2004 schrieb Jens Axboe um 13:22:

> > If we were out of memory the buffers were allocated from a mempool and I
> > want to get it out as soon as possible. If we are OOM the write will
> > most likely be the VM trying to free some memory and it would be
> > counterproductive to wait. It is not unlikely that we are the only
> > writer to that disk so there's a chance that the queue is not congested.
> 
> Because it wasn't right, like most of those blk_run_queues(). The vm
> should get things going, you basically just want to take a little nap
> and retry. The idea with a small wait is to allow io to make some
> progress, you gain nothing retrying right away (except wasting CPU
> spinning). It might want to be 1 instead of HZ/100, though. I doubt it
> would make much difference, since it's an OOM condition.

Well, okay. You're right then. I think the wait is unnecessary because
the next thing that the code tries to do is to allocate a new page,
waiting allowed and the VM will run the queue and wait itself. So if you
think it's safe you can even remove it.

Thanks.


