Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUHDFj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUHDFj1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 01:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267264AbUHDFj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 01:39:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9146 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267259AbUHDFj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 01:39:26 -0400
Date: Wed, 4 Aug 2004 07:39:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Brian King <brking@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk_queue_free_tags
Message-ID: <20040804053909.GB10340@suse.de>
References: <410FCFAF.3090207@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410FCFAF.3090207@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03 2004, Brian King wrote:
> 
> -- 
> Brian King
> eServer Storage I/O
> IBM Linux Technology Center

> 
> Currently blk_queue_free_tags cannot be called with ops outstanding. The
> scsi_tcq API defined to LLD scsi drivers allows for scsi_deactivate_tcq
> to be called (which calls blk_queue_free_tags) with ops outstanding. Change
> blk_queue_free_tags to no longer free the tags, but rather just disable
> tagged queuing and also modify blk_queue_init_tags to handle re-enabling
> tagged queuing after it has been disabled.

Not sure I completely agree with changing our exported interface just
because that's what SCSI wants, but I guess there's no harm. As long as
the tags are freed on queue exit, we can leave them around. I'll just
make it __blk_queue_free_tags(), else applied directly.

-- 
Jens Axboe

