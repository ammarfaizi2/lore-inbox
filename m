Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVCTNQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVCTNQr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 08:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVCTNQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 08:16:47 -0500
Received: from mail.dif.dk ([193.138.115.101]:175 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262150AbVCTNQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 08:16:24 -0500
Date: Sun, 20 Mar 2005 14:18:04 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ralph Corderoy <ralph@inputplus.co.uk>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't do pointless NULL checks and casts before kfree()
 in security/ 
In-Reply-To: <200503201250.j2KCoAq11871@blake.inputplus.co.uk>
Message-ID: <Pine.LNX.4.62.0503201407220.2501@dragon.hyggekrogen.localhost>
References: <200503201250.j2KCoAq11871@blake.inputplus.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005, Ralph Corderoy wrote:

> 
> Hi Jesper,
> 
> > kfree() handles NULL pointers, so checking a pointer for NULL before 
> > calling kfree() on it is pointless.
> 
> Not necessarily.  It helps tell the reader that the pointer may be NULL
> at that point.  This has come up before.
> 
>     http://groups-beta.google.com/group/linux.kernel/browse_thread/thread/bd3d6e5a29e43c73/7b43819f874295e8?q=ralph@inputplus.co.uk+persuade+lkml#7b43819f874295e8
> 

I agree that

	if (foo->bar) {
		kfree(foo->bar);
		foo->bar = NULL;
	}

makes it easy to see that foo->bar might be NULL, but I think the 
advantages of simply

	kfree(foo->bar);
	foo->bar = NULL;

outweigh that.

Having to remember that kfree(NULL) is valid shouldn't be hard, people 
should be used to that from userspace code calling free(), and if there 
are places where it's important to remember that the pointer might be 
NULL, then a simple comment would do, wouldn't it?

	kfree(foo->bar);	/* kfree(NULL) is valid */

the short version also have the real bennefits of generating shorter and 
faster code as well as being shorter "on-screen".


-- 
Jesper Juhl

