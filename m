Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUKIKh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUKIKh1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUKIKh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:37:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41668 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261468AbUKIKhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:37:09 -0500
Date: Tue, 9 Nov 2004 05:15:45 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041109071545.GA5473@logos.cnet>
References: <20041105200118.GA20321@logos.cnet> <20041108162731.GE2336@logos.cnet> <20041108185546.GA3468@logos.cnet> <419029D9.90506@cyberone.com.au> <20041108183552.7caccad1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108183552.7caccad1.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 06:35:52PM -0800, Andrew Morton wrote:
> Nick Piggin <piggin@cyberone.com.au> wrote:
> >
> > I'm not sure... it could also be just be a fluke
> >  due to chaotic effects in the mm, I suppose :|
> 
> 2.6 scans less than 2.4 before declaring oom.  I looked at the 2.4
> implementation and thought "whoa, that's crazy - let's reduce it and see
> who complains".  My three-year-old memory tells me it was reduced by 2x to
> 3x.
> 
> We need to find testcases (dammit) and do the analysis.  It could be that
> we're simply not scanning far enough.

Andrew,

When reading the code I was really suspicious of the all_unreclaimable code. 
It basically stops scanning when reaching OOM conditions - that might be it.

I tried to disable it (ignore it if priority==0) - result: very slow progress 
on extreme load. 

