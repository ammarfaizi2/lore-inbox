Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVHANPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVHANPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 09:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVHANPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 09:15:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48275 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261932AbVHANPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 09:15:17 -0400
Date: Mon, 1 Aug 2005 15:17:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master] block: fix try_module_get race in elevator_find
Message-ID: <20050801131716.GC22569@suse.de>
References: <20050726131928.GB23916@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726131928.GB23916@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26 2005, Tejun Heo wrote:
>  Hello, Jens.
> 
>  This patch removes try_module_get race in elevator_find.
> try_module_get should always be called with the spinlock protecting
> what the module init/cleanup routines register/unregister to held.  In
> the case of elevators, we should be holding elv_list to avoid it going
> away between spin_unlock_irq and try_module_get.
> 
>  This currently doesn't cause any problem as elevators are never
> unloaded, but the fix is simple and it's always nice to be correct.

Looks good. Elevators _are_ unloaded, right now you just can't unload as
and cfq because they use io contexts. But that will happen in the future
as well.

-- 
Jens Axboe

