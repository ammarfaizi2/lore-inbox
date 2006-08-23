Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWHWN5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWHWN5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWHWN5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:57:42 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:4951 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932235AbWHWN5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:57:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uaGThzwrv9JgF6kKcjfiK/2tehvsIEj7aBAKzAvEEEsaFdSJeJWxxfoLz8l3lxsJ3qHXvHJeJQfxJqfSzFq7AGKIVBhCXwDYP4iI0KeZKdArLpRQbMTX9tMzRE0R5tfFjKN0Pq289oDxJnyWBDMLsTBlPHpMDlehEPBblk4boXc=
Message-ID: <4ae3c140608230657i3300aa08m129e75e090b59ff@mail.gmail.com>
Date: Wed, 23 Aug 2006 09:57:40 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: Where does NFS client associate the file handle received from server with inode?
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <1156168413.5583.135.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ae3c140608191836we4603c0qa61d5631161a482d@mail.gmail.com>
	 <1156168413.5583.135.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because I have to carry some additional information of the file
identified by the file handle. :) But never mind, the problem has been
fixed.

Thanks anyway,
xin

On 8/21/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Sat, 2006-08-19 at 21:36 -0400, Xin Zhao wrote:
> > I ran into a problem:
> >
> > I extend several fields to file handle, and change compose_fh() to
> > initialize some value into the file handle. I think the client side
> > should be able to associate the file handle with inode and used them
> > properly afterwards.  However, I found a problem:
> >
> > Say I have a program 'postmark" in /tmp, and my current directory is /
> >
> > If I do '/tmp/postmark', getattr() funciton will not use the right
> > file handle with extension. Instead, it seems to use a file handle
> > excluding my extension
> >
> > but if I change to '/tmp', do 'ls -al' first, then I do 'postmark',
> > getattr() will use the right file handle.
> >
> > So I think maybe I need to change NFS client to associate the extened
> > file handle with inode . But I don't know where NFS client does this.
> > Can someone give me a help?
>
> Why are you changing the file handle? We should already be caching the
> correct one (i.e. the one that was sent to us by the server in the
> LOOKUP call) in the 'struct nfs_inode'.
>
> Cheers,
>   Trond
>
>
