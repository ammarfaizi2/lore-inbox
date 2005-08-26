Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbVHZNpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbVHZNpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 09:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbVHZNpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 09:45:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58048 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751571AbVHZNpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 09:45:07 -0400
Date: Fri, 26 Aug 2005 15:45:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move tasklist walk from cfq-iosched to elevator.c
Message-ID: <20050826134509.GF4018@suse.de>
References: <20050826114924.GA28166@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826114924.GA28166@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26 2005, Christoph Hellwig wrote:
> We're trying to get rid of as much as possible tasklist walks, or at
> least moving them to core code.  This patch falls into the second
> category.
> 
> Instead of walking the tasklist in cfq-iosched move that into
> elv_unregister.  The added benefit is that with this change the as
> ioscheduler might be might unloadable more easily aswell.
> 
> The new code uses read_lock instead of read_lock_irq because the
> tasklist_lock only needs irq disabling for writers.

Looks innocent enough, fine with me. 'as' will need additional work to
be unloadable, but it wont break anything since it's running with an
elevated module count right now anyways.

-- 
Jens Axboe

