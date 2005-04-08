Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbVDHKCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVDHKCo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 06:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbVDHKCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 06:02:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63924 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262781AbVDHKCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 06:02:41 -0400
Date: Fri, 8 Apr 2005 12:02:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
Message-ID: <20050408100235.GI22988@suse.de>
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com> <20050329080646.GE16636@suse.de> <42491DBE.6020303@yahoo.com.au> <20050329092819.GK16636@suse.de> <424928A1.8060400@yahoo.com.au> <4249F98D.9040706@yahoo.com.au> <20050408094557.GG22988@suse.de> <425654F5.70707@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425654F5.70707@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08 2005, Nick Piggin wrote:
> Jens Axboe wrote:
> >On Wed, Mar 30 2005, Nick Piggin wrote:
> 
> >>So Kenneth if you could look into this one as well, to see if
> >>it is worthwhile, that would be great.
> >
> >
> >For that to work, you have to change the get_io_context() allocation to
> >be GFP_ATOMIC.
> >
> 
> Yes of course, thanks for picking that up.
> 
> I guess this isn't a problem, as io contexts should be allocated
> comparatively rarely. It would be possible to move it out of the
> lock though if we really want to.

Lets just keep it inside the lock, for the fast case it should just be
an increment of the already existing io context.

-- 
Jens Axboe

