Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281826AbRKQWxp>; Sat, 17 Nov 2001 17:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281827AbRKQWxf>; Sat, 17 Nov 2001 17:53:35 -0500
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:20621 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S281826AbRKQWx3>; Sat, 17 Nov 2001 17:53:29 -0500
Message-ID: <20011117225327.5368.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Sat, 17 Nov 2001 23:53:27 +0100
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <20011116142344.A7316@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011116142344.A7316@netnation.com>; from sim@netnation.com on Fri, Nov 16, 2001 at 02:23:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2001 at 02:23:44PM -0800, Simon Kirby wrote:
> This box has Oopsed twice but is still running.  Both Oopses followed a
> BUG() report (same in both cases):
> 
> kernel BUG at page_alloc.c:76!
> 
> Which maps to:
> 
>         if (page->mapping)
> 		BUG();
> 
> ...in __free_pages_ok() in mm/page_alloc.c.

I think this one liner (diffed against 2.4.14) could fix this Oops:

--- mm/vmscan.c.vanilla	Sat Nov 17 23:37:01 2001
+++ mm/vmscan.c	Sat Nov 17 23:39:04 2001
@@ -414,10 +414,9 @@
 		 * the page as well.
 		 */
 		if (page->buffers) {
-			spin_unlock(&pagemap_lru_lock);
-
 			/* avoid to free a locked page */
 			page_cache_get(page);
+			spin_unlock(&pagemap_lru_lock);
 
 			if (try_to_free_buffers(page, gfp_mask)) {
 				if (!page->mapping) {

    regards   Christian

-- 
THAT'S ALL FOLKS!
