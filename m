Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVAMQUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVAMQUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVAMQUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:20:08 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:58584 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261676AbVAMQSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:18:36 -0500
Message-ID: <41E6AE31.5812BAF9@tv-sign.ru>
Date: Thu, 13 Jan 2005 20:21:53 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Q: shrink_cache() vs release_pages()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

shrink_cache:
	if (get_page_testone(page)) {
		__put_page(page);
		SetPageLRU(page);
		list_add(&page->lru, &zone->inactive_list);
		continue;
	}

Is it really necessary to re-add the page to inactive_list?

It seems to me that shrink_cache() can just do:

	if (get_page_testone(page)) {
		__put_page(page);
		--zone->nr_inactive;
		continue;
	}

When the __page_cache_release (or whatever) takes zone->lru_lock
it must check PG_lru before del_page_from_lru().

The same question applies to refill_inactive_zone().

Thanks,
Oleg.
