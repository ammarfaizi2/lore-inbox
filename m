Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVA1URL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVA1URL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVA1UPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:15:51 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:13773 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262728AbVA1UNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:13:50 -0500
Subject: Re: [PATCH 2/4] page_cache_readahead: remove duplicated code
From: Ram <linuxram@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <41F786EF.9FE19AEC@tv-sign.ru>
References: <41F63493.309B0ADB@tv-sign.ru>
	 <1106698119.3298.57.camel@localhost>  <41F786EF.9FE19AEC@tv-sign.ru>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1106943227.4286.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 28 Jan 2005 12:13:47 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 04:02, Oleg Nesterov wrote:
> Ram wrote:
> >
> > No. There is a reason why we had some duplication. With your patch,
> > we will end up reading-on-demand instead of reading ahead.
> >
> > When we notice a sequential reads have resumed, we first read in the
> > data that is requested.
> > However if the read request is for more pages than what are being held
> > in the current window, we make the ahead window as the current window
> > and read in more pages in the ahead window. Doing that gives the
> > opportunity of always having pages in the ahead window when the next
> > sequential read request comes in.
> 
> Yes, sorry. I have not noticed that this 'goto out' is conditional in
> the 'no ahead window' case.
> 
> Thank you for explanation.
> 
> However, I still think it makes sense to factor out the common code in
> these two cases, just for readability.

We did consider putting a while loop, which looped twice. That looked
ugly too. So we left it as is. You might have better ideas.

> 
> I'll redo these patches.
> 
Your 1st patch was fine. I have not looked deeply through your 3rd and
4th patch. However I will wait till you redo your patches.

RP
> Oleg.

