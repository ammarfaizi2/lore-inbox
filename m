Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316756AbSFUTRP>; Fri, 21 Jun 2002 15:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316759AbSFUTRO>; Fri, 21 Jun 2002 15:17:14 -0400
Received: from mons.uio.no ([129.240.130.14]:8338 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S316756AbSFUTRM>;
	Fri, 21 Jun 2002 15:17:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [patch] (resend) credentials for 2.5.23
Date: Fri, 21 Jun 2002 21:17:04 +0200
User-Agent: KMail/1.4.1
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020619212909.A3468@redhat.com> <shs4rfwx4uc.fsf@charged.uio.no> <20020621145230.B1499@redhat.com>
In-Reply-To: <20020621145230.B1499@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206212117.04570.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 June 2002 20:52, Benjamin LaHaise wrote:
> On Fri, Jun 21, 2002 at 01:12:59PM +0200, Trond Myklebust wrote:
> >   Making the credentials a monolithic block like you appear to be
> > doing just doesn't make sense. If you look at the way things like
> > fsuid/fsgid/groups[] are used, you will see that almost all those that
> > filesystems that care are making their own private copies.
>
> I'm not looking at things from the filesystem's point of view, so
> much as for threads and aio, where rlimits and identificantion needs
> to be shared between contexts.

Fair enough, however by hard coding a lot of new pointers and links everywhere 
you are making the task unnecessarily more difficult for the person who 
*does* want to look at the filesystem point of view. Please could you at 
least hide the details of the location of all these elements in 
macros/inlined functions.

IOW: if you could write something like

   x = current_fsuid();
   set_current_euid(y);

instead of

   x = current->cred->fsuid;
  current->cred->euid = y;

then this would make a later transition to current->cred->ucred a lot easier. 
In addition, it might also make it possible to share future code with 2.4.x 
via a set of compatibility routines.

Cheers,
    Trond
