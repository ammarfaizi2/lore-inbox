Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUHaGnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUHaGnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUHaGnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:43:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:8847 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266808AbUHaGm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:42:56 -0400
Date: Mon, 30 Aug 2004 23:40:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: roland@redhat.com, mtk-lkml@gmx.net, torvalds@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       tonnerre@thundrix.ch
Subject: Re: [PATCH] waitid system call
Message-Id: <20040830234057.2bdec761.akpm@osdl.org>
In-Reply-To: <20040831062656.GU11465@devserv.devel.redhat.com>
References: <12606.1093348262@www48.gmx.net>
	<200408310604.i7V64k7o010652@magilla.sf.frob.com>
	<20040831062656.GU11465@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> wrote:
>
> On Mon, Aug 30, 2004 at 11:04:46PM -0700, Roland McGrath wrote:
>  > +			/*
>  > +			 * For a WNOHANG return, clear out all the fields
>  > +			 * we would set so the user can easily tell the
>  > +			 * difference.
>  > +			 */
>  > +			if (!retval)
>  > +				retval = put_user(0, &infop->si_signo);
>  > +			if (!retval)
>  > +				retval = put_user(0, &infop->si_errno);
>  > +			if (!retval)
>  > +				retval = put_user(0, &infop->si_code);
>  > +			if (!retval)
>  > +				retval = put_user(0, &infop->si_pid);
>  > +			if (!retval)
>  > +				retval = put_user(0, &infop->si_uid);
>  > +			if (!retval)
>  > +				retval = put_user(0, &infop->si_status);
> 
>  Is it really necessary to check the exit code after each put_user?
>  	if (!retval && access_ok(VERIFY_WRITE, infop, sizeof(*infop)))) {
>  		retval = __put_user(0, &infop->si_signo);
>  		retval |= __put_user(0, &infop->si_errno);
>  		retval |= __put_user(0, &infop->si_code);
>  		retval |= __put_user(0, &infop->si_pid);
>  		retval |= __put_user(0, &infop->si_uid);
>  		retval |= __put_user(0, &infop->si_status);
>  	}
>  is what kernel usually does when filling multiple structure members.

I don't think it matters much.  Taking seven trips into the fault handler
where one would do seems a bit dumb though.
