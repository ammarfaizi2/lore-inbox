Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUADTD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 14:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUADTD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 14:03:57 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:23736 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S263370AbUADTDz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 14:03:55 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Jamie Lokier <jamie@shareable.org>, Bill Davidsen <davidsen@tmr.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
Date: Sun, 4 Jan 2004 20:01:57 +0100
User-Agent: KMail/1.5.4
References: <3FE492EF.2090202@colorfullife.com> <20040103010909.GI1882@matchmail.com> <20040103212837.GA10139@mail.shareable.org>
In-Reply-To: <20040103212837.GA10139@mail.shareable.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401042002.03684.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 03 January 2004 22:28, Jamie Lokier wrote:
> Mike Fedyk wrote:
> > On Fri, Jan 02, 2004 at 10:41:50PM +0000, Jamie Lokier wrote:
> > > The best way is to maintain poll state in each "struct file".  The
> > > order of complexity for the bitmap scan is still significant, but
> > > ->poll calls are limited to the number of transitions which actually
> > > happen.
> >
> > What's the drawback to this approach?
> >
> > Where is the poll state kept now?
>
> The poll state is not maintained at all _between_ calls to poll/select
> at the moment, so at least one fresh call to ->poll is required per
> file descriptor.  That is something that can be changed.

Yes, file->f_mode can be hijacked for this. Only 2 bits of it are used at the
moment. More headache is clearing this state again, but this might not be
necessary, since we can always return EAGAIN, if the cache is stale,
right?

> The impression I had was that the code is quite complicated and
> invasive, and select/poll aren't considered worth optimising because
> epoll is an overall better solution (which is true; optimising
> select/poll would change the complexity of the slow part but not
> reduce the complexity of the API part, while epoll does both).

This is true. But old software continues to exist and for INN there is
pretty much nothing else in this category available, I've been told by
several admins. Nobody really likes it, but it is used and improved
where necessary (epoll might be on the list already).

Regards 

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/+GMqU56oYWuOrkARAlC5AJ4sX3OvARw0lE7n35tvr0NfeUkJGgCgmUt6
PuPC9O9DMZt+bCNIiUa/viU=
=d23f
-----END PGP SIGNATURE-----

