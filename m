Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWBFF03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWBFF03 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 00:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWBFF03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 00:26:29 -0500
Received: from web33004.mail.mud.yahoo.com ([68.142.206.68]:1182 "HELO
	web33004.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750994AbWBFF02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 00:26:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CVxE/t7RWjrw6HdsTHmyGtfEtnkxbEO9NSJyJm2UITGZ9bwHV3h2z2CCDm9AasNiNNkXA7vqJB75UlETaKFF5tvzj2Sx851BwZMJwNZ6QAewhDmY590Ew+KcyYnIhTP+CseM/dHHtea5dzwnf0zMqSrNxGf/bdmFs2mRBIMZgk0=  ;
Message-ID: <20060206052627.8205.qmail@web33004.mail.mud.yahoo.com>
Date: Sun, 5 Feb 2006 21:26:27 -0800 (PST)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: [VM PATCH] rotate_reclaimable_page fails frequently
To: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@surriel.com>
Cc: sgoel01@yahoo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20060205205056.01a025fa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:

> Rik van Riel <riel@surriel.com> wrote:
> >  The question is, why is the page not yet back on
> the
> >  LRU by the time the data write completes ?
> 
> Could be they're ext3 pages which were written out
> by kjournald.  Such
> pages are marked dirty but have clean buffers. 
> ext3_writepage() will
> discover that the page is actually clean and will
> mark it thus without
> performing any I/O.
> 

I had conjectured that something like this might be
happening without knowing the details of how ext3
implements writepage.  The filesystem tested on here
is  ext3.

> Shantanu, I suggest you add some instrumentation
> there too, see if it's
> working.  (That'll be non-trivial.  Just because we
> hit PAGE_CLEAN: here
> doesn't necessarily mean that the page will be
> reclaimed).

I'll do so and report back the results.

Shantanu


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
