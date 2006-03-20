Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWCTQLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWCTQLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWCTQLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:11:07 -0500
Received: from mtaout2.012.net.il ([84.95.2.4]:51555 "EHLO mtaout2.012.net.il")
	by vger.kernel.org with ESMTP id S932307AbWCTQKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:10:41 -0500
Date: Mon, 20 Mar 2006 18:10:08 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] Make sure nobody's leaking resources
In-reply-to: <20060320155304.GI8980@parisc-linux.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Message-id: <20060320161007.GA25444@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060320155304.GI8980@parisc-linux.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 08:53:04AM -0700, Matthew Wilcox wrote:
> 
> Currently, releasing a resource also releases all of its children.  That
> made sense when request_resource was the main method of dividing up the
> memory map.  With the increased use of insert_resource, it seems to me
> that we should instead reparent the newly orphaned resources.  Before
> we do that, let's make sure that nobody's actually relying on the current
> semantics.
> 
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> 
> diff -urpNX dontdiff linus-2.6/kernel/resource.c parisc-2.6/kernel/resource.c
> --- linus-2.6/kernel/resource.c	2006-03-20 07:29:06.000000000 -0700
> +++ parisc-2.6/kernel/resource.c	2006-03-20 07:00:47.000000000 -0700
> @@ -181,6 +181,8 @@ static int __release_resource(struct res
>  {
>  	struct resource *tmp, **p;
>  
> +	BUG_ON(old->child);
> +

Is this expressely forbidden at this stage, or just "not recommended"?
if the latter, WARN_ON() might be more appropriate.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

