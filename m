Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVC2KUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVC2KUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVC2KUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:20:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56247 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262284AbVC2KT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:19:57 -0500
Date: Tue, 29 Mar 2005 12:19:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
Message-ID: <20050329101947.GL16636@suse.de>
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com> <20050329080646.GE16636@suse.de> <42491DBE.6020303@yahoo.com.au> <1112091026.6282.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112091026.6282.43.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29 2005, Arjan van de Ven wrote:
> On Tue, 2005-03-29 at 19:19 +1000, Nick Piggin wrote:
> > - removes the relock/retry merge mechanism in __make_request if we
> >    aren't able to get the GFP_ATOMIC allocation. Just fall through
> >    and assume the chances of getting a merge will be small (is this
> >    a valid assumption? Should measure it I guess).
> 
> this may have a potential problem; if the vm gets in trouble, you
> suddenly start to generate worse IO patterns, which means IO performance
> goes down right when it's most needed.....
> 
> of course we need to figure if this actually ever hits in practice,
> because if it doesn't I'm all for simpler code.

Precisely, see my response as well. If the noretry flag works, that
should be fine.

-- 
Jens Axboe

