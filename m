Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTJAOkS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbTJAOkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:40:18 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:51097 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262315AbTJAOkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:40:11 -0400
Date: Wed, 1 Oct 2003 16:39:59 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_* In Comments Considered Harmful
Message-ID: <20031001143959.GI31698@wohnheim.fh-wedel.de>
References: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 October 2003 14:26:19 +0100, Matthew Wilcox wrote:
> 
> I reviewed the dependency list for a file this morning to see why it was
> being unnecessarily recompiled (a little fetish of mine, mostly harmless).
> I was a little discombobulated to find this line:
> 
>     $(wildcard include/config/higmem.h) \
> 
> Naturally, I assumed a typo somewhere.  It turns out there is indeed
> a CONFIG_HIGMEM in include/linux/mm.h, but it's in a comment.  The
> fixdep script doesn't parse C itself, so it doesn't know that this should
> be ignored.  Rather than fix the typo, I deleted the comment; the ifdef'ed
> code is a mere two lines so the comment seems unnecessary.
> 
> This serves as a useful warning to people -- don't put CONFIG_FOO in a
> comment unnecessarily.  Because even when it's true now, maybe the #if
> gets changed and the comment doesn't.
> 
> Index: include/linux/mm.h
> ===================================================================
> RCS file: /var/cvs/linux-2.6/include/linux/mm.h,v
> retrieving revision 1.5
> diff -u -p -r1.5 mm.h
> --- a/include/linux/mm.h	28 Sep 2003 04:06:20 -0000	1.5
> +++ b/include/linux/mm.h	1 Oct 2003 13:15:53 -0000
> @@ -196,7 +196,7 @@ struct page {
>  #if defined(WANT_PAGE_VIRTUAL)
>  	void *virtual;			/* Kernel virtual address (NULL if
>  					   not kmapped, ie. highmem) */
> -#endif /* CONFIG_HIGMEM || WANT_PAGE_VIRTUAL */
> +#endif
>  };

To me, this sounds more like our tools are too stupid.  Ok, I don't
like to copy&paste conditions either, but in many header files, those
comments are the lesser evil.  If we cannot put every #endif on the
same screen (24 lines) as the corresponding #if, they do help.

What we do need is a version of cpp, that only removes comments.  Then
we can pipe all input for our tools through that cppp or whatever it
would be called, and noone would worry about comments confusing the
tools anymore.

All right, here is a patch that simply corrects the typo.  Linus, you
decide which one is better.

Index: include/linux/mm.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/mm.h,v
retrieving revision 1.5
diff -u -p -r1.5 mm.h
--- a/include/linux/mm.h	28 Sep 2003 04:06:20 -0000	1.5
+++ b/include/linux/mm.h	1 Oct 2003 13:15:53 -0000
@@ -196,7 +196,7 @@ struct page {
 #if defined(WANT_PAGE_VIRTUAL)
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
-#endif /* CONFIG_HIGMEM || WANT_PAGE_VIRTUAL */
+#endif /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
 };


Jörn

-- 
The only real mistake is the one from which we learn nothing.
-- John Powell
