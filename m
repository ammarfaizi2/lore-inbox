Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbUKHWQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbUKHWQb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUKHWQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:16:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54232 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261268AbUKHWQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:16:28 -0500
Date: Mon, 8 Nov 2004 16:55:46 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041108185546.GA3468@logos.cnet>
References: <20041105200118.GA20321@logos.cnet> <20041108162731.GE2336@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108162731.GE2336@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 02:27:31PM -0200, Marcelo Tosatti wrote:
> On Fri, Nov 05, 2004 at 06:01:18PM -0200, Marcelo Tosatti wrote:
> 
> > While doing this, I noticed that kswapd will happily go to sleep 
> > if all zones have all_unreclaimable set. I bet this is the reason 
> > for the page allocation failures we are seeing. So the patch 
> > also makes balance_pgdat() NOT return and go to "loop_again" 
> > instead in case of page shortage - even if all_unreclaimable is set.
> > 
> > Basically the "loop_again" logic IS NOT WORKING! 
> 
> Wrong, the loop_again logic is working, all_zones_ok will be
> set when DEF_PRIORITY = 0. 

I meant priority=DEF_PRIORITY. 

> So the page allocation failures are happening for some other 
> reason(s).

