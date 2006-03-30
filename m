Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWC3HVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWC3HVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWC3HVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:21:40 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:49593 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751203AbWC3HVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:21:40 -0500
Date: Thu, 30 Mar 2006 10:21:24 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/9] I/OAT
Message-ID: <20060330062124.GA8545@2ka.mipt.ru>
References: <1143672844.27644.5.camel@black-lazer.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1143672844.27644.5.camel@black-lazer.jf.intel.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 30 Mar 2006 10:21:25 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 02:54:04PM -0800, Chris Leech (christopher.leech@intel.com) wrote:
> [I/OAT] Driver for the Intel(R) I/OAT DMA engine
> 
> From: Chris Leech <christopher.leech@intel.com>
> 
> Adds a new ioatdma driver
> 
> Signed-off-by: Chris Leech <christopher.leech@intel.com>

Let's do it again.
Could you please describe how struct ioat_dma_chan channels are freed?
For example when device is removed just after it has been added.

ioat_probe() -> enumerate_dma_channels() (failures are ok now) ->
kmalloc a lot of channels.

ioat_remove() -> dma_async_device_unregister() which does not cleanup
ioat_dma_chan channels, but only clients.
It ends up in dma_async_device_cleanup() only.

-- 
	Evgeniy Polyakov
