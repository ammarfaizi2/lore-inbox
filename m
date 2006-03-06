Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWCFWIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWCFWIb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWCFWIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:08:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16820 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932379AbWCFWIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:08:30 -0500
Date: Mon, 6 Mar 2006 23:07:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Pekka Enberg <penberg@cs.helsinki.fi>, Dave Jones <davej@redhat.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, rminnich@lanl.gov
Subject: Re: 9pfs double kfree
Message-ID: <20060306220755.GD4836@elf.ucw.cz>
References: <20060306070456.GA16478@redhat.com> <20060305.230711.06026976.davem@davemloft.net> <20060306072346.GF27946@ftp.linux.org.uk> <20060306072823.GF21445@redhat.com> <84144f020603052356r321bc78dp66263fbfc73517c6@mail.gmail.com> <20060306081651.GG27946@ftp.linux.org.uk> <Pine.LNX.4.63.0603061031550.8581@kai.makisara.local> <20060306093401.GH27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306093401.GH27946@ftp.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 06-03-06 09:34:01, Al Viro wrote:
> On Mon, Mar 06, 2006 at 10:40:03AM +0200, Kai Makisara wrote:
> > > Legal, but rather bad taste.  Init to NULL, possibly assign the value
> > > if kmalloc(), then kfree() unconditionally - sure, but that... almost
> > > certainly one hell of a lousy cleanup logics somewhere.
> > > 
> > I agree with you.
> > 
> > However, a few months ago it was advocated to let kfree take care of 
> > testing the pointer against NULL and a load of patches like this:
> 
> That's different - that's _exactly_ the case I've mentioned above.
> 
> Moreover, that's exact match to standard behaviour of free(3):
> 
> C99 7.20.3.2(2):
> The free function causes the space pointed to by ptr to be deallocated, that
> is, made available for further allocation.  If ptr is a null pointer, no action
> occurs.  Otherwise, if the argument does not match a pointer returned by the
> calloc, malloc, or realloc function, or if the space has been deallocated by
> a call to free or realloc, the behaviour is undefined.
> 
> IOW, free(NULL) is guaranteed to be no-op while double-free is nasal daemon
> country.

Well, double-free of NULL is permitted by text above. 'If ptr is a
null pointer, no action occurs.'

OTOH #define kfree(a) { __kfree(a); a = NULL; } actually does the
right thing... even with double free.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
