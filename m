Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVA1G6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVA1G6I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 01:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVA1G6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 01:58:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22957 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261488AbVA1G6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 01:58:03 -0500
Date: Fri, 28 Jan 2005 07:58:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Doug Maxey <dwm@maxeymade.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi/sata write barrier support
Message-ID: <20050128065759.GD4800@suse.de>
References: <20050127120244.GO2751@suse.de> <200501272242.j0RMgoP5016154@falcon30.maxeymade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501272242.j0RMgoP5016154@falcon30.maxeymade.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27 2005, Doug Maxey wrote:
> 
> On Thu, 27 Jan 2005 13:02:48 +0100, Jens Axboe wrote:
> >Hi,
> >
> >For the longest time, only the old PATA drivers supported barrier writes
> >with journalled file systems. This patch adds support for the same type
> >of cache flushing barriers that PATA uses for SCSI, to be utilized with
> >libata. 
> 
> What, if any mechanism supports changing the underlying write cache?  
> 
> That is, assuming this is common across PATA and SCSI drives, and it is 
> possible to turn the cache off on the IDE drives, would switching the 
> cache underneath require completing the inflight IO?

Not sure what you mean, switching it off while the io is in flight? You
cannot do that, either the cache state will change right before starting
the io or right after. The cache state at the start of the barrier write
will determine the action taken.

-- 
Jens Axboe

