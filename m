Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVACR4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVACR4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVACRxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:53:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:28608 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261529AbVACRww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:52:52 -0500
Date: Mon, 3 Jan 2005 09:52:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "David S. Miller" <davem@davemloft.net>
cc: akpm@osdl.org, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [2/4]: add second parameter to clear_page() for
 all arches
In-Reply-To: <20041224090539.40bba423.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0501030951590.21811@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
 <20041224090539.40bba423.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004, David S. Miller wrote:

> On Thu, 23 Dec 2004 11:33:59 -0800 (PST)
> Christoph Lameter <clameter@sgi.com> wrote:
>
> > Modification made but it would be good to have some feedback from the arch maintainers:
> >
>  ...
> > sparc64
>
> I don't see any sparc64 bits in this patch, else I'd
> review them :-)
>

Sorry here it is:

Index: linux-2.6.9/include/asm-sparc64/page.h
===================================================================
--- linux-2.6.9.orig/include/asm-sparc64/page.h 2004-10-18 14:53:51.000000000 -0700
+++ linux-2.6.9/include/asm-sparc64/page.h      2005-01-03 09:50:16.000000000 -0800
@@ -15,7 +15,17 @@
 #ifndef __ASSEMBLY__

 extern void _clear_page(void *page);
-#define clear_page(X)  _clear_page((void *)(X))
+
+static void inline clear_page(void *page, int order)
+{
+       unsigned int nr = 1 << order;
+
+       while (nr-- > 0) {
+               _clear_page(page);
+               page += PAGE_SIZE;
+       }
+}
+
 struct page;
 extern void clear_user_page(void *addr, unsigned long vaddr, struct page *page);
 #define copy_page(X,Y) memcpy((void *)(X), (void *)(Y), PAGE_SIZE)

