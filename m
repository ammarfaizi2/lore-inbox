Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVJMSFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVJMSFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 14:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVJMSFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 14:05:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59910 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932145AbVJMSFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 14:05:03 -0400
Date: Thu, 13 Oct 2005 20:05:45 +0200
From: Jens Axboe <axboe@suse.de>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] indirect function calls elimination in IO eliminate
Message-ID: <20051013180545.GJ6603@suse.de>
References: <6694B22B6436BC43B429958787E454988AA6F7@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6694B22B6436BC43B429958787E454988AA6F7@mssmsx402nb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13 2005, Ananiev, Leonid I wrote:
>  
> 
> Fully modular io schedulers and enables online switching between
> them was introduced in Linux 2.6.10 but as a result percentage
> of CPU using by kernel was increased and performance degradation
> is marked on Itanium. A cause of degradation is in more steps
> for indirect IO scheduler type specific function calls.
> 
> The patch eliminates 45 indirect function calls in 16 elevator
> functions. Sysbench fileio benchmark throughput was increased at 2%
> for noop elevator after patching.

I don't really see the patch doing what you describe - the indirect
function calls are the same, what you did was inline the actual elevator
structure in the queue again. This breaks reference counting of said
structure, so it's not really something that can be applied.  I'm
guessing what you saw was a decrease in cache misses, maybe we can do
something about that instead.

Can you say more about the throughput increase? From what to what and on
what hardware?

Oh, and your patch is totally screwed, check your mail setup.

-- 
Jens Axboe

