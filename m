Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbUJ1GDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbUJ1GDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbUJ1GDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:03:31 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:31620 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S262797AbUJ1F5m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 01:57:42 -0400
Date: Wed, 27 Oct 2004 22:57:33 -0700 (PDT)
From: Sorav Bansal <sbansal@stanford.edu>
To: Tace <tacetan@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: User/Kernel Pointer bug in sys_poll
In-Reply-To: <20041028052218.52478.qmail@web50207.mail.yahoo.com>
Message-ID: <Pine.GSO.4.44.0410272246240.7124-100000@elaine9.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Older x86 architectures (386 and before) allow the kernel to write to any
user location regardless of the write-protect bits.

Hence, with this bug, a user program could write to the write-protected
region of its address space by calling the sys_poll system call and
setting the address and data values appropriately.

An example where this could be exploited is an application running
third-party software. The application may want to write-protect its code
region but with this bug, the third party software will be able to
overwrite write-protected regions by calling sys_poll.

Sorav

On Wed, 27 Oct 2004, Tace wrote:

> sorry but I don't understand, why would it be a
> problem?
>
> --- Sorav Bansal <sbansal@stanford.edu> wrote:
>
> >
> > Package: linux-kernel-src
> > Version: 2.4.27
> >
> > Description: User/Kernel pointer bug/security holl
> > in sys_poll
> >
> > I think, there is a potential bug/security hole in
> > the sys_poll system
> > call.
> >
> > In sys_poll, the user pointer ufds (first arg to
> > sys_poll) goes through
> > copy_from_user. Then __put_user is called on
> > &ufds->revents.
> >
> > Since copy_from_user is a read access and __put_user
> > is a write access,
> > the first call does not verify write-access to ufds.
> > This can be exploited
> > by a malicious user on a 386 machine (where
> > write-protection in
> > kernel mode is not enabled .i.e.
> > CONFIG_X86_WP_WORKS_OK is undef).
> >
> > It seems that this bug can be corrected by replacing
> > the two __put_user
> > calls in sys_poll by put_user. I am using the latest
> > kernel from
> > kernel.org .i.e. linux-2.4.27
> >
> > thanks,
> > Sorav
> >
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
>
>
> __________________________________
> Do you Yahoo!?
> Yahoo! Mail Address AutoComplete - You start. We finish.
> http://promotions.yahoo.com/new_mail
>



