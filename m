Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVAWFdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVAWFdY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 00:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVAWFdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 00:33:24 -0500
Received: from waste.org ([216.27.176.166]:28571 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261229AbVAWFdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 00:33:21 -0500
Date: Sat, 22 Jan 2005 21:32:55 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050123053255.GT12076@waste.org>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <20050122232814.GG3867@waste.org> <200501230608.36501.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501230608.36501.agruen@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 06:08:36AM +0100, Andreas Gruenbacher wrote:
> On Sunday 23 January 2005 00:28, Matt Mackall wrote:
> > So the stack is going to be either 256 or 1024 bytes. Seems like we
> > ought to kmalloc it.
> 
> This will do. I didn't check if the +1 is strictly needed.
> 
> -      stack_node stack[STACK_SIZE];
> +      stack_node stack[fls(size) - fls(MAX_THRESH) + 1];

Yes, indeed. Though I think even here, we'd prefer to use kmalloc
because gcc generates suboptimal code for variable-sized stack vars.

-- 
Mathematics is the supreme nostalgia of our time.
