Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSJAVD0>; Tue, 1 Oct 2002 17:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262499AbSJAVD0>; Tue, 1 Oct 2002 17:03:26 -0400
Received: from the-penguin.otak.com ([216.122.56.136]:10112 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S262446AbSJAVDX>; Tue, 1 Oct 2002 17:03:23 -0400
Date: Tue, 1 Oct 2002 14:08:41 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops iee1394 video1394 rmap
Message-ID: <20021001210841.GA25577@the-penguin.otak.com>
References: <3D9A04B4.B1355CB6@digeo.com> <Pine.LNX.4.44L.0210011729010.1909-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210011729010.1909-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.5.39 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel [riel@conectiva.com.br] wrote:
> On Tue, 1 Oct 2002, Andrew Morton wrote:
> 
> > This would appear to be a page which was mapped by remap_page_range().
> > It's not PageReserved, and it has no reverse mapping.
> >
> > I believe the right fix is to just delete the BUG check at rmap.c:280.
> 
> Yes.  I used to have this bugcheck in 2.4-rmap but removed it
> ages ago. I have no idea why it was reintroduced in 2.5...
> 
It works fine, no surprises at all, I am doing a fresh mozilla compile, burning a CD, 
playing music, and the camera works great!

Here is my pitiful patch. :)

--- mm/rmap.c.org	2002-10-01 13:28:54.000000000 -0700
+++ mm/rmap.c	2002-10-01 13:29:07.000000000 -0700
@@ -277,8 +277,6 @@
 
 	pte_chain_lock(page);
 
-	BUG_ON(page->pte.direct == 0);
- 
 	if (PageDirect(page)) {
 		if (page->pte.direct == pte_paddr) {
 			page->pte.direct = 0;
-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


