Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131177AbQK1VjX>; Tue, 28 Nov 2000 16:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131027AbQK1VjO>; Tue, 28 Nov 2000 16:39:14 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:22523 "EHLO
        webber.adilger.net") by vger.kernel.org with ESMTP
        id <S131004AbQK1VjA>; Tue, 28 Nov 2000 16:39:00 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011282108.eASL8nd10539@webber.adilger.net>
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
In-Reply-To: <20001128214309.F2680@sith.mimuw.edu.pl> "from Jan Rekorajski at
 Nov 28, 2000 09:43:09 pm"
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
Date: Tue, 28 Nov 2000 14:08:49 -0700 (MST)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan R_korajski writes:
> Why is RLIMIT_NPROC apllied to root(uid 0) processes? It's not kernel job to
> prevent admin from shooting him/her self in the foot.

> -	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur)

By default, root has no real process limits anyways, so this test should
always succeed.  However, it would be nice to be _able_ to set process
limits on root for one reason or another.  Also, as we move towards more
secure systems, it is bad (IMHO) to special case root (uid=0) cases.
It just makes more to fix to get a system where root != god.

> root should be able to do fork() regardless of any limits,
> and IMHO the following patch is the right thing.

Then set the rlim_cur to unlimited, and blow your system up as you like.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
