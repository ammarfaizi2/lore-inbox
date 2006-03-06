Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752355AbWCFJeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbWCFJeH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357AbWCFJeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:34:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56499 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1752355AbWCFJeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:34:05 -0500
Date: Mon, 6 Mar 2006 09:34:01 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Dave Jones <davej@redhat.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, rminnich@lanl.gov
Subject: Re: 9pfs double kfree
Message-ID: <20060306093401.GH27946@ftp.linux.org.uk>
References: <20060306070456.GA16478@redhat.com> <20060305.230711.06026976.davem@davemloft.net> <20060306072346.GF27946@ftp.linux.org.uk> <20060306072823.GF21445@redhat.com> <84144f020603052356r321bc78dp66263fbfc73517c6@mail.gmail.com> <20060306081651.GG27946@ftp.linux.org.uk> <Pine.LNX.4.63.0603061031550.8581@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0603061031550.8581@kai.makisara.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 10:40:03AM +0200, Kai Makisara wrote:
> > Legal, but rather bad taste.  Init to NULL, possibly assign the value
> > if kmalloc(), then kfree() unconditionally - sure, but that... almost
> > certainly one hell of a lousy cleanup logics somewhere.
> > 
> I agree with you.
> 
> However, a few months ago it was advocated to let kfree take care of 
> testing the pointer against NULL and a load of patches like this:

That's different - that's _exactly_ the case I've mentioned above.

Moreover, that's exact match to standard behaviour of free(3):

C99 7.20.3.2(2):
The free function causes the space pointed to by ptr to be deallocated, that
is, made available for further allocation.  If ptr is a null pointer, no action
occurs.  Otherwise, if the argument does not match a pointer returned by the
calloc, malloc, or realloc function, or if the space has been deallocated by
a call to free or realloc, the behaviour is undefined.

IOW, free(NULL) is guaranteed to be no-op while double-free is nasal daemon
country.
