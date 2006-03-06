Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752283AbWCFIhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbWCFIhQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbWCFIhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:37:16 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:60916 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1752283AbWCFIhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:37:14 -0500
Date: Mon, 6 Mar 2006 10:40:03 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Al Viro <viro@ftp.linux.org.uk>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, Dave Jones <davej@redhat.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, rminnich@lanl.gov
Subject: Re: 9pfs double kfree
In-Reply-To: <20060306081651.GG27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.63.0603061031550.8581@kai.makisara.local>
References: <20060306070456.GA16478@redhat.com> <20060305.230711.06026976.davem@davemloft.net>
 <20060306072346.GF27946@ftp.linux.org.uk> <20060306072823.GF21445@redhat.com>
 <84144f020603052356r321bc78dp66263fbfc73517c6@mail.gmail.com>
 <20060306081651.GG27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2006, Al Viro wrote:

> On Mon, Mar 06, 2006 at 09:56:22AM +0200, Pekka Enberg wrote:
> > On 3/6/06, Dave Jones <davej@redhat.com> wrote:
> > > I wonder if we could get away with something as simple as..
> > >
> > > #define kfree(foo) \
> > >         __kfree(foo); \
> > >         foo = KFREE_POISON;
> > >
> > > ?
> > 
> > It's legal to call kfree() twice for NULL pointer. The above poisons
> > foo unconditionally which makes that case break I think.
> 
> Legal, but rather bad taste.  Init to NULL, possibly assign the value
> if kmalloc(), then kfree() unconditionally - sure, but that... almost
> certainly one hell of a lousy cleanup logics somewhere.
> 
I agree with you.

However, a few months ago it was advocated to let kfree take care of 
testing the pointer against NULL and a load of patches like this:

[PATCH] kfree cleanup: drivers/scsi
author	Jesper Juhl <jesper.juhl@gmail.com>
	Mon, 7 Nov 2005 09:01:26 +0000 (01:01 -0800)
committer	Linus Torvalds <torvalds@g5.osdl.org>
	Mon, 7 Nov 2005 15:54:01 +0000 (07:54 -0800)
commit	c9475cb0c358ff0dd473544280d92482df491913
tree	091617d0bdab9273d44139c86af21b7540e6d9b1	tree
parent	089b1dbbde28f0f641c20beabba28fa89ab4fab9	commit | 
commitdiff
[PATCH] kfree cleanup: drivers/scsi

This is the drivers/scsi/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in 
drivers/scsi/.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>
Acked-by: Kai Makisara <kai.makisara@kolumbus.fi>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>


went in. I wonder what will come next when wind changes.

-- 
Kai
