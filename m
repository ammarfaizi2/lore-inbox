Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbTLCCCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 21:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbTLCCCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 21:02:42 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:49537 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264392AbTLCCCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 21:02:41 -0500
Date: Wed, 3 Dec 2003 02:02:40 +0000
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/locks.c fcntl_setlease did not check if a file was opened for writing before granting a read lease
Message-ID: <20031203020240.GC27306@mail.shareable.org>
References: <000301c3b504$689afbf0$0201a8c0@joe> <20031127165043.GA19669@mail.shareable.org> <6uwu9flcdq.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6uwu9flcdq.fsf@zork.zork.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums wrote:
> > 	if ((arg == F_RDLCK)
> > 	    && ((atomic_read(&inode->i_writer_count) != 0)))
> >
> > You'll also need to modify all the places where that needs to be
> > maintained.
> 
> Looking at 2.6.0-test11, it seems that its struct inode has such a
> field, albeit named i_writecount.  Commentary from fs/namei.c:

Cool.  At a glance, it looks like deny_write_access() can be used to
handle the F_RDLCK case.

(It would also be nice to have some way of blocking until the lease can
be taken, but even the F_WRLCK case doesn't offer that at the moment).

-- Jamie
