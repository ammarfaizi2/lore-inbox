Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVDGJLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVDGJLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVDGJLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:11:24 -0400
Received: from mtaout2.barak.net.il ([212.150.49.172]:43938 "EHLO
	mtaout2.barak.net.il") by vger.kernel.org with ESMTP
	id S262396AbVDGJLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:11:21 -0400
Date: Thu, 07 Apr 2005 12:11:13 +0300
From: Leonid Podolny <leonid99@mail.ru>
Subject: Bug in mm.h?
To: lkml <linux-kernel@vger.kernel.org>
Message-id: <4254F931.6010200@mail.ru>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.91.0.0
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I fail to understand whether the following is a bug. From what I see, if
the page is reserved, page->count is not decreased. The order of the
conditions should be reversed.

>From mm.h:

static inline void put_page(struct page *page)
{
        if (!PageReserved(page) && put_page_testzero(page))
                __page_cache_release(page);
}

static inline void get_page(struct page *page)
{
        atomic_inc(&page->_count);
}

#define put_page_testzero(p)                            \
        ({                                              \
                BUG_ON(page_count(p) == 0);             \
                atomic_add_negative(-1, &(p)->_count);  \
        })

