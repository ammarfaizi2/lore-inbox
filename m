Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWCUGjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWCUGjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 01:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWCUGjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 01:39:54 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:48529 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750719AbWCUGjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 01:39:53 -0500
To: bfields@fieldses.org
CC: matthew@wil.cx, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20060320203556.GC31512@fieldses.org> (bfields@fieldses.org)
Subject: Re: DoS with POSIX file locks?
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu> <20060320121107.GE8980@parisc-linux.org> <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu> <20060320123950.GF8980@parisc-linux.org> <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu> <20060320153202.GH8980@parisc-linux.org> <E1FLNRi-0000We-00@dorka.pomaz.szeredi.hu> <20060320203556.GC31512@fieldses.org>
Message-Id: <E1FLaW8-0001hD-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 21 Mar 2006 07:38:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Things look fairly straightforward if the accounting is done in
> > > > files_struct instead of task_struct.  At least for POSIX locks.  I
> > > > haven't looked at flocks or leases yet.
> > > 
> > > I was thinking that would work, yes.  It might not be worth worrying
> > > about accounting for leases/flocks since each process can only have one
> > > of those per open file anyway.
> > 
> > Here's a minimally tested patch.  The only tricky part is when the
> > unlock splits an existing lock in two.
> > 
> > Also the limit checking is sloppy when the lock is split, and in that
> > case allows the counter to go one above the limit.
> 
> Do you need to handle blocks as well as applied locks?

I don't think so, because each task may only have at most one block at
a time.

Miklos
