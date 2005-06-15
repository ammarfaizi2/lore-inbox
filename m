Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVFOL3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVFOL3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 07:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVFOL3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 07:29:21 -0400
Received: from [80.71.243.242] ([80.71.243.242]:41884 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261418AbVFOL3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 07:29:15 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17072.4363.161693.887061@gargle.gargle.HOWL>
Date: Wed, 15 Jun 2005 15:29:15 +0400
To: "liyu@LAN" <liyu@ccoss.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: one question about LRU mechanism
Newsgroups: gmane.linux.kernel
In-Reply-To: <1118817991.5828.23.camel@liyu.ccoss.com.cn>
References: <1118812376.32766.4.camel@liyu.ccoss.com.cn>
	<20050615052530.GA3913@holomorphy.com>
	<1118817991.5828.23.camel@liyu.ccoss.com.cn>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

liyu@LAN writes:

[...]

 > 
 > /************************************************************/
 >         while (scan++ < nr_to_scan && !list_empty(src)) {
 >                 page = lru_to_page(src);
 >                 prefetchw_prev_lru_page(page, src, flags);
 >                                                                                                     
 >                 if (!TestClearPageLRU(page))
 >                         BUG();
 >                 list_del(&page->lru);

[...]

 > 
 > /***************************************************/
 >         while (scan++ < nr_to_scan && !list_empty(src->prev)) {

list_empty(something) and list_empty(something->prev) are equivalent for
well-formed lists.

list_empty(src) check in isolate_lru_pages() is for pathological case
when active list becomes empty. Also active and inactive lists are not
LRU, they are closer to second-chance-FIFO, it is _together_ that they
emulate LRU.

Nikita.
