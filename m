Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTFZTzr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 15:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTFZTzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 15:55:47 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:4474 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263205AbTFZTzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 15:55:44 -0400
Date: Thu, 26 Jun 2003 13:10:05 -0700
From: Andrew Morton <akpm@digeo.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: phillips@arcor.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] My research agenda for 2.7
Message-Id: <20030626131005.4609acb5.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.53.0306262030500.5910@skynet>
References: <200306250111.01498.phillips@arcor.de>
	<20030625092938.GA13771@skynet.ie>
	<200306262100.40707.phillips@arcor.de>
	<Pine.LNX.4.53.0306262030500.5910@skynet>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jun 2003 20:09:57.0489 (UTC) FILETIME=[EA58F610:01C33C1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mel@csn.ul.ie> wrote:
>
> Buddy allocators, including the
>  one implemented in Linux, do not record what order allocation a struct
>  page belongs to.

We can do that.


--- 25/mm/page_alloc.c~a	2003-06-26 13:09:11.000000000 -0700
+++ 25-akpm/mm/page_alloc.c	2003-06-26 13:09:24.000000000 -0700
@@ -123,6 +123,7 @@ static void prep_compound_page(struct pa
 		SetPageCompound(p);
 		p->lru.next = (void *)page;
 	}
+	page[1].index = order;
 }
 
 static void destroy_compound_page(struct page *page, unsigned long order)

_

