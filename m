Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161380AbWALWmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161380AbWALWmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161379AbWALWmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:42:43 -0500
Received: from havoc.gtf.org ([69.61.125.42]:44264 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161380AbWALWme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:42:34 -0500
Date: Thu, 12 Jan 2006 17:42:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x net driver updates
Message-ID: <20060112224227.GA26888@havoc.gtf.org>
References: <20060112221322.GA25470@havoc.gtf.org> <Pine.LNX.4.64.0601121423120.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601121423120.3535@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 02:30:19PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 12 Jan 2006, Jeff Garzik wrote:
> > 
> > dann frazier:
> >       CONFIG_AIRO needs CONFIG_CRYPTO
> 
> I think this is done wrong.
> 
> It should "select CRYPTO" rather than "depends on CRYPTO".

OK


> Otherwise people won't see it just because they don't have crypto enabled, 
> which is not very user-friendly.
> 
> Btw, why are these casts there? Either the functions are of the right 
> type, or they aren't. In neither case is the cast correct.
> 
> I do realize that there are comments in <net/iw_handler.h> that says that 
> you should do the cast, but that's no excuse for crap or stupid code.
> 
> If it's an issue of trying to make greppable code, why not have
> just the comment?
> 
> > @@ -2378,6 +2566,15 @@ static const iw_handler atmel_handler[] 
> >  	(iw_handler) atmel_get_encode,		/* SIOCGIWENCODE */
> >  	(iw_handler) atmel_set_power,		/* SIOCSIWPOWER */
> >  	(iw_handler) atmel_get_power,		/* SIOCGIWPOWER */
> > +	(iw_handler) NULL,			/* -- hole -- */
> > +	(iw_handler) NULL,			/* -- hole -- */
> ...
> 
> Hmm?

Welcome to the awful wireless driver API.  This type crapola is a key
thing that needs changing, but its not the only thing.  There are also
some nasty wireless APIs which do casts based on variable (passed-in)
struct offsets...

This needs to change to a type-safe thingy like struct ethtool_ops, but
the above is what we were lumped with.

	Jeff



