Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTKJEr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 23:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbTKJEr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 23:47:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:55253 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262902AbTKJEr1 (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 23:47:27 -0500
Date: Sun, 9 Nov 2003 20:51:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: neilb@cse.unsw.edu.au, bwindle@fint.org, Linux-kernel@vger.kernel.org
Subject: Re: slab corruption in test9 (NFS related?)
Message-Id: <20031109205112.358b0692.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311092007451.3002-100000@home.osdl.org>
References: <16303.131.838605.661991@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.44.0311092007451.3002-100000@home.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> On Mon, 10 Nov 2003, Neil Brown wrote:
> >
> > An extra dput was introduced in nfsd_rename 20 months ago....
> > 
> > time to remove it.
> 
> Oh, you stand-up comedian you.
> 
> I'm just wondering how the hell this hasn't bit us seriously until now?  
> What's up?

Me too.

If the dentry was on the dentry_unused list then it would get a whacky
refcount and we would simply leak it.

It is only in the very rare case that the dentry gets freed up between the
two dput()s that the slab debugging will trip.

So probably, we've been leaking dentries as a result of rename activity by
NFS clients, but nobody noticed.

