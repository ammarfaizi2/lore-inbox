Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWCUBxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWCUBxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 20:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWCUBxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 20:53:18 -0500
Received: from bhhdoa.org.au ([65.98.99.88]:54799 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S1030186AbWCUBxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 20:53:17 -0500
Message-ID: <1142901862.441f4c66c748e@vds.kolivas.org>
Date: Tue, 21 Mar 2006 11:44:22 +1100
From: kernel@kolivas.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-mm@kvack.org
Subject: Re: [PATCH][3/3] mm: swsusp post resume aggressive swap prefetch
References: <200603200234.01472.kernel@kolivas.org> <200603202247.38576.rjw@sisk.pl> <1142889937.441f1dd19e90f@vds.kolivas.org> <200603210022.32985.rjw@sisk.pl>
In-Reply-To: <200603210022.32985.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Rafael J. Wysocki" <rjw@sisk.pl>:
> Sorry, I was wrong.  After resume the image pages in the swap are visible as
> free, because we allocate them after we have created the image (ie. the
> image
> contains the system state in which these pages are free).
> 
> Well, this means I really don't know what happens and what causes the
> slowdown.  It certainly is related to the aggressive prefetch hook in
> swsusp_suspend().  [It seems to search the whole swap, but it doesn't
> actually prefetch anything.  Strange.]

Are you looking at swap still in use? Swap prefetch keeps a copy of prefetched
pages on backing store as well as in ram so the swap space will not be freed on
prefetching. 

> > If so, is there a way to differentiate the two so we only aggressively
> > prefetch on kernel resume - is that what you meant by doing it in the
> > other file? 
> 
> Basically, yes.  swsusp.c and snapshot.c contain common functions,
> disk.c and swap.c contain the code used by the built-in swsusp only,
> and user.c contains the userland interface.  If you want something to
> be run by the built-in swsusp only, place it in disk.c.
> 
> Still in this particular case it won't matter, I'm afraid.

I don't understand what you mean by it won't matter?

Cheers,
Con

