Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSJHPUg>; Tue, 8 Oct 2002 11:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261186AbSJHPUg>; Tue, 8 Oct 2002 11:20:36 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:37047 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261173AbSJHPUf>; Tue, 8 Oct 2002 11:20:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <baldrick@wanadoo.fr>
To: zlatko.calusic@iskon.hr
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in 2.5.x
Date: Tue, 8 Oct 2002 17:25:56 +0200
User-Agent: KMail/1.4.3
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210011401360.991-100000@localhost.localdomain> <200210081338.50495.baldrick@wanadoo.fr> <dnhefx9db8.fsf@magla.zg.iskon.hr>
In-Reply-To: <dnhefx9db8.fsf@magla.zg.iskon.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210081725.57017.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hmmm, are you using ext3?  Changes to the meaning of yield sometimes
> > make fsync go very slowly.  This problem has been around since 2.5.28,
> > and hasn't yet been fixed (As for a fix, Andrew Morton said "I'll sit
> > tight for the while, see where shed_yield() behaviour ends up").
>
> Yes, it's an ext3 partition, ordered mode. I don't have ext2 compiled
> into kernel anymore. :)
>
> Hm, if it's a problem with fsync() then that could explain slight
> Oracle slowdown, too, as I think that Oracle is a heavy user of
> fsync. But I don't know that for sure. I'll investigate further..

Andrew Morton made this suggestion to me:

>Please try replacing the yield() in fs/jbd/transaction.c
>with
>
>        set_current_state(TASK_RUNNING);
>        schedule();

and indeed it cured my problems.

All the best,

Duncan.
