Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSHBRpJ>; Fri, 2 Aug 2002 13:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSHBRpJ>; Fri, 2 Aug 2002 13:45:09 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:15110 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S316089AbSHBRpI>; Fri, 2 Aug 2002 13:45:08 -0400
Message-Id: <200208021748.g72Hm8m02852@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Dave Hansen <haveblue@us.ibm.com>, Kasper Dupont <kasperd@daimi.au.dk>
Subject: Re: [RFC] Race condition?
Date: Fri, 2 Aug 2002 19:41:38 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
References: <3D4A8D45.49226E2B@daimi.au.dk> <3D4ABA9D.8060307@us.ibm.com>
In-Reply-To: <3D4ABA9D.8060307@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 2. August 2002 19:00 schrieb Dave Hansen:
> Kasper Dupont wrote:
> > Is there a race condition in this piece of code from do_fork in
> > linux/kernel/fork.c? I cannot see what prevents two processes
> > from calling this at the same time and both successfully fork
> > even though the user had only one process left.
> >
> >         if (atomic_read(&p->user->processes) >=
> > p->rlim[RLIMIT_NPROC].rlim_cur && !capable(CAP_SYS_ADMIN) &&
> > !capable(CAP_SYS_RESOURCE)) goto bad_fork_free;
> >
> >         atomic_inc(&p->user->__count);
> >         atomic_inc(&p->user->processes);
>
> I don't see any locking in the call chain leading to this function, so
> I think you're right.  The attached patch fixes this.  It costs an
> extra 2 atomic ops in the failure case, but otherwise just makes the
> processes++ operation earlier.
>
> Patch is against 2.5.27, but applies against 30.

It has the opposite failure mode. Forks only some of which should
succeed may all fail.

	Regards
		Oliver

