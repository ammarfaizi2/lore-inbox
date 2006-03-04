Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751990AbWCDTZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbWCDTZj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 14:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbWCDTZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 14:25:39 -0500
Received: from kanga.kvack.org ([66.96.29.28]:16525 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751924AbWCDTZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 14:25:38 -0500
Date: Sat, 4 Mar 2006 14:20:30 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/8] [I/OAT] DMA memcpy subsystem
Message-ID: <20060304192030.GA6510@kvack.org>
References: <20060303214036.11908.10499.stgit@gitlost.site> <20060303214220.11908.75517.stgit@gitlost.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303214220.11908.75517.stgit@gitlost.site>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 01:42:20PM -0800, Chris Leech wrote:
> +void dma_async_device_unregister(struct dma_device* device)
> +{
...
> +	kref_put(&device->refcount, dma_async_device_cleanup);
> +	wait_for_completion(&device->done);
> +}

This looks like a bug: device is dereferenced after it is potentially 
freed.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
