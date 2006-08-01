Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWHAOwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWHAOwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWHAOwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:52:04 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:43218 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1161008AbWHAOwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:52:01 -0400
Date: Wed, 2 Aug 2006 00:51:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: 76306.1226@compuserve.com, andros@citi.umich.edu, orion@cora.nwra.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: fctnl(F_SETSIG) no longer works in 2.6.17, does in 2.6.16.
Message-Id: <20060802005157.137dfdde.sfr@canb.auug.org.au>
In-Reply-To: <1154370233.8417.11.camel@localhost>
References: <200607310224_MC3-1-C689-D6DD@compuserve.com>
	<1154370233.8417.11.camel@localhost>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 11:23:52 -0700 Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Mon, 2006-07-31 at 02:21 -0400, Chuck Ebbert wrote:
> 
> > static void lease_release_private_callback(struct file_lock *fl)
> > {
> >         if (!fl->fl_file)
> >                 return;
> > 
> >         f_delown(fl->fl_file);
> > =>      fl->fl_file->f_owner.signum = 0;
> > }
> 
> Why should the lease cleanup code be resetting f_owner.signum? That
> looks wrong.
> 
> Stephen, I think this line of code predates the CITI changes. Do you
> know who added it and why?

Because when the original code was written, it was only called when we got
a fcntl(F_SETLEASE, F_UNLCK) call.  The code got moved incorrectly and
noone noticed.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
