Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVCTNcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVCTNcJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 08:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVCTNcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 08:32:08 -0500
Received: from cmailm1.svr.pol.co.uk ([195.92.193.18]:9479 "EHLO
	cmailm1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S262172AbVCTNbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 08:31:49 -0500
Message-Id: <200503201331.j2KDVhm12383@blake.inputplus.co.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't do pointless NULL checks and casts before kfree() in security/ 
In-Reply-To: <Pine.LNX.4.62.0503201407220.2501@dragon.hyggekrogen.localhost> 
Date: Sun, 20 Mar 2005 13:31:43 +0000
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jesper,

> > Not necessarily.  It helps tell the reader that the pointer may be
> > NULL at that point.  This has come up before.
> > 
> >     http://groups-beta.google.com/group/linux.kernel/browse_thread/thread/bd3d6e5a29e43c73/7b43819f874295e8?q=ralph@inputplus.co.uk+persuade+lkml#7b43819f874295e8
> > 
> 
> I agree that
> 
> 	if (foo->bar) {
> 		kfree(foo->bar);
> 		foo->bar = NULL;
> 	}
> 
> makes it easy to see that foo->bar might be NULL, but I think the 
> advantages of simply
> 
> 	kfree(foo->bar);
> 	foo->bar = NULL;
> 
> outweigh that.
> 
> Having to remember that kfree(NULL) is valid shouldn't be hard, people 
> should be used to that from userspace code calling free(),

Agreed.

> and if there are places where it's important to remember that the
> pointer might be NULL, then a simple comment would do, wouldn't it?
> 
> 	kfree(foo->bar);	/* kfree(NULL) is valid */

I'd rather be without the same comment littering the code.

> the short version also have the real bennefits of generating shorter
> and faster code as well as being shorter "on-screen".

Faster code?  I'd have thought avoiding the function call outweighed the
overhead of checking before calling.

Cheers,


Ralph.

