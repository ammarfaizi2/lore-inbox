Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSIEE5R>; Thu, 5 Sep 2002 00:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSIEE5R>; Thu, 5 Sep 2002 00:57:17 -0400
Received: from dsl-213-023-038-092.arcor-ip.net ([213.23.38.92]:1700 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316860AbSIEE5Q>;
	Thu, 5 Sep 2002 00:57:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Race in shrink_cache
Date: Thu, 5 Sep 2002 07:04:28 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mooe-00064m-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

This looks really suspicious, vmscan.c#435:

	spin_unlock(&pagemap_lru_lock);
							if (put_page_testzero(page))
								__free_pages_ok(page, 0);
	/* avoid to free a locked page */
	page_cache_get(page);

	/* whoops, double free coming */

I suggest you bump the page count before releasing the lru lock.  The race
shown above may not in fact be possible, but the current code is fragile.

-- 
Daniel
