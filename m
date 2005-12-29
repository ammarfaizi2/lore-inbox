Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbVL2JR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbVL2JR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 04:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVL2JR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 04:17:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5125 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965088AbVL2JR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 04:17:56 -0500
Date: Thu, 29 Dec 2005 10:19:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Zhu Yi <yi.zhu@intel.com>
Cc: jketreno@linux.intel.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipw2200 stack reduction
Message-ID: <20051229091940.GD2772@suse.de>
References: <20051228212934.GA2772@suse.de> <1135847228.9670.69.camel@debian.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135847228.9670.69.camel@debian.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29 2005, Zhu Yi wrote:
> On Wed, 2005-12-28 at 22:29 +0100, Jens Axboe wrote:
> > The reason is the host_cmd structure is large (500 bytes). All other
> > functions currently using ipw_send_cmd() suffer from the same problem.
> > This patch introduces ipw_send_cmd_simple() for commands with no data
> > transfer, and ipw_send_cmd_pdu() for commands with a data payload.
> 
> Hi Jens,
> 
> Thanks for point this out and provide the patch. One comment:
> 
> > +static struct host_cmd *ipw_host_cmd_get(u8 command, u8 len)
> >  {
> > ...
> > +       cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
> 
> This will still alloc 500 bytes for each command. I think if we want to
> dynamically alloc the struct, we can split the struct to head and
> payload and alloc the payload according to the real size.

Well you could do that if you wanted, but 500 bytes of dynamic
allocation is not a big issue. But it could be an optimization on top of
this patch, indeed. The downside is that you then have to do 2
allocations for each command, so whether it would be a win or not I
don't know.

-- 
Jens Axboe

