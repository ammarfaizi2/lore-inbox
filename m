Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267190AbUFZQxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbUFZQxC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUFZQxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:53:02 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:23450 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S267190AbUFZQwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:52:38 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Inclusion of UML in 2.6.8
Date: Sat, 26 Jun 2004 19:05:22 +0200
User-Agent: KMail/1.5
Cc: Jeff Dike <jdike@addtoit.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406261905.22710.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, what are the requisite for stable inclusion of the UML update inside 
2.6-mm (or directly 2.6.8)? Currently (splitting out a little piece, which 
should not be included) we have almost all the stuff inside arch/um and 
include/asm-um, the addition of <linux/ghash.h> and of two filesystems for 
UML use only, and this little hunk (plus 2 uses of it inside 
mm/page_alloc.c).

+#ifndef HAVE_ARCH_FREE_PAGE
+static inline void arch_free_page(struct page *page, int order) { }
+#endif

Could it go in as-is? I'm especially worried about having it included soon in 
2.6.8, since last time it entered -mm and stayed there just for one release.

The patch correctly applies to 2.6.7 and works; the current code, instead, 
does not even compile at all, so there is no reason for not applying it 
(unless you want to remove UML support / but since you never said this, we 
need this patch applied). However, if you don't want some parts of the code, 
just tell me; I'm waiting for this before preparing the UML patch to send you

Also, I have some patches managed with your patch-scripts, which I'll send you 
after you include the UML patch.

About the STATE of the code:

Of the two filesystems, one (hostfs) now should work perfectly with 2.6 (I've 
just fixed one porting bug to 2.6, related to the force_delete() -> 
.drop_inode change documented in Documentation/filesystems/vfs.txt); the 
other maybe has some problems, but I can remove it from the patch (it also 
will probably be replaced soon by a more generic one, i.e. externfs).

Bye!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

