Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbUKHTrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUKHTrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbUKHTrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:47:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19387 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261187AbUKHTrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:47:21 -0500
Date: Mon, 8 Nov 2004 14:27:31 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041108162731.GE2336@logos.cnet>
References: <20041105200118.GA20321@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105200118.GA20321@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 06:01:18PM -0200, Marcelo Tosatti wrote:

> While doing this, I noticed that kswapd will happily go to sleep 
> if all zones have all_unreclaimable set. I bet this is the reason 
> for the page allocation failures we are seeing. So the patch 
> also makes balance_pgdat() NOT return and go to "loop_again" 
> instead in case of page shortage - even if all_unreclaimable is set.
> 
> Basically the "loop_again" logic IS NOT WORKING! 

Wrong, the loop_again logic is working, all_zones_ok will be
set when DEF_PRIORITY = 0. 

So the page allocation failures are happening for some other 
reason(s).
