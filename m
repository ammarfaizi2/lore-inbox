Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTJAN0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTJAN0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:26:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5772 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262104AbTJAN0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:26:20 -0400
Date: Wed, 1 Oct 2003 14:26:19 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_* In Comments Considered Harmful
Message-ID: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I reviewed the dependency list for a file this morning to see why it was
being unnecessarily recompiled (a little fetish of mine, mostly harmless).
I was a little discombobulated to find this line:

    $(wildcard include/config/higmem.h) \

Naturally, I assumed a typo somewhere.  It turns out there is indeed
a CONFIG_HIGMEM in include/linux/mm.h, but it's in a comment.  The
fixdep script doesn't parse C itself, so it doesn't know that this should
be ignored.  Rather than fix the typo, I deleted the comment; the ifdef'ed
code is a mere two lines so the comment seems unnecessary.

This serves as a useful warning to people -- don't put CONFIG_FOO in a
comment unnecessarily.  Because even when it's true now, maybe the #if
gets changed and the comment doesn't.

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
+#endif
 };
 
 /*

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
