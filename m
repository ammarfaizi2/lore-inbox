Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030585AbWBHIyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030585AbWBHIyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030587AbWBHIyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:54:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13151 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030585AbWBHIyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:54:05 -0500
Date: Wed, 8 Feb 2006 09:56:29 +0100
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [SCSI] fix wrong context bugs in SCSI
Message-ID: <20060208085629.GE4338@suse.de>
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com> <1139342922.6065.12.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139342922.6065.12.camel@mulgrave.il.steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07 2006, James Bottomley wrote:
> +static void scsi_device_dev_release(struct device *dev)
> +{
> +	execute_in_process_context(scsi_device_dev_release_usercontext,	dev);
> +}
> +

Hmm, this (and further up) could fail, yet you don't check.

I don't think this API is very nice to be honest, there's no good way to
handle failures - you can't just sleep and loop retry the execute if you
are in_interrupt(). I'd prefer passing in a work_queue_work (with a
better name :-) that has been allocated at a reliable time during
initialization.


-- 
Jens Axboe

