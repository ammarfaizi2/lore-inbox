Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbWHUNxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWHUNxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbWHUNxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:53:44 -0400
Received: from pat.uio.no ([129.240.10.4]:42748 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030471AbWHUNxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:53:43 -0400
Subject: Re: Where does NFS client associate the file handle received from
	server with inode?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140608191836we4603c0qa61d5631161a482d@mail.gmail.com>
References: <4ae3c140608191836we4603c0qa61d5631161a482d@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 09:53:33 -0400
Message-Id: <1156168413.5583.135.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.9, required 12,
	autolearn=disabled, AWL 0.59, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-19 at 21:36 -0400, Xin Zhao wrote:
> I ran into a problem:
> 
> I extend several fields to file handle, and change compose_fh() to
> initialize some value into the file handle. I think the client side
> should be able to associate the file handle with inode and used them
> properly afterwards.  However, I found a problem:
> 
> Say I have a program 'postmark" in /tmp, and my current directory is /
> 
> If I do '/tmp/postmark', getattr() funciton will not use the right
> file handle with extension. Instead, it seems to use a file handle
> excluding my extension
> 
> but if I change to '/tmp', do 'ls -al' first, then I do 'postmark',
> getattr() will use the right file handle.
> 
> So I think maybe I need to change NFS client to associate the extened
> file handle with inode . But I don't know where NFS client does this.
> Can someone give me a help?

Why are you changing the file handle? We should already be caching the
correct one (i.e. the one that was sent to us by the server in the
LOOKUP call) in the 'struct nfs_inode'.

Cheers,
  Trond

