Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267657AbUJOBT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267657AbUJOBT7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUJOBT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:19:59 -0400
Received: from cantor.suse.de ([195.135.220.2]:42661 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267657AbUJOBT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:19:56 -0400
Date: Fri, 15 Oct 2004 03:18:38 +0200
From: Andi Kleen <ak@suse.de>
To: Adam Heath <doogie@debian.org>
Cc: Andi Kleen <ak@suse.de>, "Martin K. Petersen" <mkp@wildopensource.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org,
       tony.luck@intel.com
Subject: Re: [PATCH] General purpose zeroed page slab
Message-ID: <20041015011838.GC9753@wotan.suse.de>
References: <yq1oej5s0po.fsf@wilson.mkp.net> <20041014180427.GA7973@wotan.suse.de> <Pine.LNX.4.58.0410141836270.1221@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410141836270.1221@gradall.private.brainfood.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 06:36:47PM -0500, Adam Heath wrote:
> On Thu, 14 Oct 2004, Andi Kleen wrote:
> 
> > Also that's pretty dumb. How about keeping track how much of the
> > page got non zeroed (e.g. by using a few free words in struct page
> > for a coarse grained dirty bitmap)
> >
> > Then you could memset on free only the parts that got actually
> > changed, and never waste cache lines for anything else.
> 
> That will fail when a struct is placed in the page, and only the beginning and
> end of the struct was changed.

Hmm? I think you're misunderstanding me. The dirty bitmap would cover 
all areas that are potentially not zero. If someone changes a byte
without setting the bitmap they're buggy. 


-Andi
> 
