Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129710AbQK1V1h>; Tue, 28 Nov 2000 16:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129667AbQK1V11>; Tue, 28 Nov 2000 16:27:27 -0500
Received: from 213-123-72-140.btconnect.com ([213.123.72.140]:53513 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129410AbQK1V1L>;
        Tue, 28 Nov 2000 16:27:11 -0500
Date: Tue, 28 Nov 2000 20:58:00 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
In-Reply-To: <Pine.LNX.4.21.0011282049470.1940-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0011282054450.1940-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 28 Nov 2000, Jan Rekorajski wrote:
> > --- linux/kernel/fork.c~	Tue Sep  5 23:48:59 2000
> > +++ linux/kernel/fork.c	Sun Nov 26 20:22:20 2000
> > @@ -560,7 +560,8 @@
> >  	*p = *current;
> >  
> >  	retval = -EAGAIN;
> > -	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur)
> > +	if (p->user->uid &&
> > +	   (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur))
> 

On a totally unrelated to the resourcesnote, for your benefit, Jan:

the ->user->uid is maintained for a reason completely different from your
usage above (see kernel/user.c to learn why -- it is to easily find out
given user_struct which real uid it belongs to in uid_hash_find()). If you
wanted this process' uid you should have used p->uid. If you wanted this
process' effective uid (more likely) then you should have used p->euid.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
