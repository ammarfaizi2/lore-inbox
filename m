Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUEEMPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUEEMPp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbUEEMPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:15:45 -0400
Received: from niit.caravan.ru ([217.23.131.158]:8453 "EHLO mail.tv-sign.ru")
	by vger.kernel.org with ESMTP id S264627AbUEEMPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:15:44 -0400
Message-ID: <4098DB41.1A7FC5DF@tv-sign.ru>
Date: Wed, 05 May 2004 16:17:05 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-rc3-mm2
References: <4098CFEB.468E6326@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> This way only waiters must be modified, and we can use
> page_waitqueue(page) for nonfiltered wait too.

also, exclusive wakeups have no problems, and process
waiting in wait_on_page_writeback() won't be waken
by unlock_page(). it will be waken _only_ when that
bit will be cleared.

> +wake-one-pg_locked-bh_lock-semantics.patch
>
> +static void *page_key(struct page *page, unsigned long bit)
> +{
> + 	return (void *)(page_to_pfn(page) | bit << PAGE_KEY_SHIFT);
> }

become unneeded as well.

Oleg.
