Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVAZK7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVAZK7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 05:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVAZK7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 05:59:33 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:52709 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262270AbVAZK7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 05:59:14 -0500
Message-ID: <41F786EF.9FE19AEC@tv-sign.ru>
Date: Wed, 26 Jan 2005 15:02:55 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ram <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/4] page_cache_readahead: remove duplicated code
References: <41F63493.309B0ADB@tv-sign.ru> <1106698119.3298.57.camel@localhost>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
>
> No. There is a reason why we had some duplication. With your patch,
> we will end up reading-on-demand instead of reading ahead.
>
> When we notice a sequential reads have resumed, we first read in the
> data that is requested.
> However if the read request is for more pages than what are being held
> in the current window, we make the ahead window as the current window
> and read in more pages in the ahead window. Doing that gives the
> opportunity of always having pages in the ahead window when the next
> sequential read request comes in.

Yes, sorry. I have not noticed that this 'goto out' is conditional in
the 'no ahead window' case.

Thank you for explanation.

However, I still think it makes sense to factor out the common code in
these two cases, just for readability.

I'll redo these patches.

Oleg.
