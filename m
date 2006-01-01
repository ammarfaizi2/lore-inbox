Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWAAJMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWAAJMr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 04:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWAAJMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 04:12:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:734 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932189AbWAAJMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 04:12:46 -0500
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
From: Arjan van de Ven <arjan@infradead.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       barryn@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <200512312036.01351.a1426z@gawab.com>
References: <200512302306.28667.a1426z@gawab.com>
	 <200512311702.20525.a1426z@gawab.com>
	 <1136039178.2901.25.camel@laptopd505.fenrus.org>
	 <200512312036.01351.a1426z@gawab.com>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 10:12:33 +0100
Message-Id: <1136106754.17830.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 20:36 +0300, Al Boldi wrote:
> Arjan van de Ven wrote:
> > On Sat, 2005-12-31 at 17:02 +0300, Al Boldi wrote:
> > > Shouldn't it be possible to disable overcommit completely, thus giving
> > > kswapd a break from running wild trying to find something to swap/page,
> > > which is the reason why the system gets unstable going over 95% in your
> > > example.
> >
> > shared mappings make this impractical. To disable overcommit completely,
> > each process would need to account for all its own shared libraries, eg
> > each process gets glibc added etc. You'll find that on any
> > non-extremely-stripped system you then end up with much more memory
> > needed than you have ram.
> 
> Are you implying shared maps are implemented by way of overcommitting?

yes. Using only 1 page shared is already overcommitting because in
principle each user can cause a COW on that page and cause a memory
allocation for it in the future. (just like "traditional" overcommit can
cause a pagefault with an allocation)


> Really, overcommit is an add-on feature like swapping, only overcommit is 
> free because it's a lier.  So removing an add-on feature should not affect 
> the underlying system in any way, such as shared mappings or swapping.

then I think you're misunderstanding how the linux VM works


> It should be possible to allow swapping to handle all memory requests 
> exceeding physical RAM.  OverCommit should be a tuning option for those who 
> like to live on the edge, because it really is a gamble.

but it's a worthwhile gamble to not need GOBBLES of memory you're not
using 99.9999999999999% of the time

> 
> In the case where swap = physical RAM and overcommit_ratio = 0, the kernel is 
> in effect hiding the fact that it is overcommitting.

swap==ram is not really relevant; you'll need a LOT more to cover the
shared maps...


