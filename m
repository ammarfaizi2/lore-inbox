Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVDXB3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVDXB3p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 21:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVDXB3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 21:29:45 -0400
Received: from mail.dif.dk ([193.138.115.101]:12183 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262219AbVDXB3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 21:29:43 -0400
Date: Sun, 24 Apr 2005 03:32:55 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       mingo@redhat.com, arjan@infradead.org, ecashin@noserose.net,
       greg@kroah.com, axboe@suse.de
Subject: Re: [PATCH] make mempool_destroy resilient against NULL pointers.
In-Reply-To: <20050408184121.0a498a3d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0504240327470.2474@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504090334490.2455@dragon.hyggekrogen.localhost>
 <20050408184121.0a498a3d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > 
> > General rule (as I understand it) is that functions that free resources 
> > should handle being passed NULL pointers - mempool_destroy() will 
> > currently explode if passed a NULL pointer, the patch below makes it safe 
> > to pass it NULL.
> 
> The best response to mempool_destroy(0) is an oops.  There's no legitimate
> reason for doing it.
> 
Sorry to bring this up again but, take a look at the patch by 
ecashin@coraid.com titled "[PATCH] aoe 5/12: don't try to free null 
bufpool" http://grmso.net:8090/commit/03347936afcba990525736ae39daa13f643eac5f/diff/fa83c2ddd4293bd8bcaeeaf14bfdbf2fbe810420/
That's exactely the reason why the patch I submitted should be applied, to 
avoid having to do such checks all over the place in other code and 
instead just do it in one location. With this patch in place, the patch to 
aoedev.c would not have been needed.

Or am I still misunderstanding something.

-- 
Jesper


