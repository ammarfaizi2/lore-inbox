Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSHBSzi>; Fri, 2 Aug 2002 14:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSHBSzi>; Fri, 2 Aug 2002 14:55:38 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:40198 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S316672AbSHBSzh>; Fri, 2 Aug 2002 14:55:37 -0400
Message-Id: <200208021858.g72Iwam03030@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC] Race condition?
Date: Fri, 2 Aug 2002 20:45:46 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Kasper Dupont <kasperd@daimi.au.dk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
References: <3D4A8D45.49226E2B@daimi.au.dk> <200208021700.g72H0bm02654@fachschaft.cup.uni-muenchen.de> <3D4AC352.70702@us.ibm.com>
In-Reply-To: <3D4AC352.70702@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 2. August 2002 19:37 schrieb Dave Hansen:
> Oliver Neukum wrote:
> > Am Freitag, 2. August 2002 15:46 schrieb Kasper Dupont:
> >>Is there a race condition in this piece of code from do_fork in
> >
> > It would seem so. Perhaps the BKL was taken previously.
>
> Even if it was, I doubt the code ever knowingly relied upon it.  If I
> know that I'm protected under a lock, I rarely go to the trouble of
> atomic operations.

That depends on where else you need these variables.

> The root of the problem is that the reference count is being relied on
> for the wrong thing.  There is a race on p->user between the
> dup_task_struct() and whenever the atomic_inc(&p->user->__count)
> occcurs.   The user reference count needs to be incremented in
> dup_task_struct(), before the copy occurs.

I don't get you. The user_struct can hardly go away while we are
forking.

IMHO you should add a spinlock to user_struct and take it.
A clear solution that doesn't hurt the common case.

	Regards
		Oliver

