Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVBCKis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVBCKis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVBCKfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:35:01 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:22483 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262504AbVBCKaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:30:01 -0500
Message-ID: <42020C29.99CF1D87@tv-sign.ru>
Date: Thu, 03 Feb 2005 14:34:01 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ram <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/4] readahead: factor out duplicated code
References: <41FB6F45.848CEFF6@tv-sign.ru>  <41FB7517.418D556A@tv-sign.ru> <1107398594.5992.134.camel@localhost>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> > unsigned long page_cache_readahead(mapping, ra, filp, offset, req_size)
> > {
> > 	unsigned long max, newsize = req_size;
> > 	int sequential = (offset == ra->prev_page + 1);
> >
> > 	if (offset == ra->prev_page && req_size == 1 && ra->size != 0)
> > 		goto out;
> > 	ra->prev_page = offset;		<============== PLEASE LOOK HERE :)
> > 	max = get_max_readahead(ra);
> > 	newsize = min(req_size, max);
> >
> > 	if (newsize == 0 || (ra->flags & RA_FLAG_INCACHE)) {
> > 		newsize = 1;
>
> At this point prev_page has to be updated:
>               ra->prev_page = offset;

Yes, it is already updated, before "max = get_max_readahead(ra);"

> Otherwise this code looks much cleaner and correct. Can you send me a
> updated patch. I will run it through my test harness.

Well, currently I do not know, what should be changed :)

Oleg.
