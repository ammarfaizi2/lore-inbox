Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVAWQtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVAWQtg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 11:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVAWQtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 11:49:36 -0500
Received: from waste.org ([216.27.176.166]:49387 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261326AbVAWQte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 11:49:34 -0500
Date: Sun, 23 Jan 2005 08:49:04 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050123164903.GU12076@waste.org>
References: <20050122203326.402087000@blunzn.suse.de> <200501230608.36501.agruen@suse.de> <20050123053255.GT12076@waste.org> <200501231322.14332.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501231322.14332.agruen@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 01:22:13PM +0100, Andreas Gruenbacher wrote:
> On Sunday 23 January 2005 06:32, Matt Mackall wrote:
> > Yes, indeed. Though I think even here, we'd prefer to use kmalloc
> > because gcc generates suboptimal code for variable-sized stack vars.
> 
> That's ridiculous. kmalloc isn't even close to whatever suboptimal
> code gcc might produce here. Also I'm not convinced that gcc
> generates bad code in the first place. The code I get makes perfect
> sense.

Fixed-sized slab-based kmalloc is O(1) (and pretty darn fast). If we
take a constant overhead for every local variable lookup in qsort,
that's O(n log n). Putting the stack vars last might fix that, but I
think it needs testing. I'll try it.

-- 
Mathematics is the supreme nostalgia of our time.
