Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWCLKri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWCLKri (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWCLKri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:47:38 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:34762 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932110AbWCLKrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:47:37 -0500
Date: Sun, 12 Mar 2006 13:47:28 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: "Leech, Christopher" <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/8] [I/OAT] Driver for the Intel(R) I/OAT DMA engine
Message-ID: <20060312104728.GA25301@2ka.mipt.ru>
References: <E3A930D59AFC3345AEBA35189102A8A6060E15E7@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E3A930D59AFC3345AEBA35189102A8A6060E15E7@orsmsx404.amr.corp.intel.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 12 Mar 2006 13:47:28 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 06:29:46PM -0800, Leech, Christopher (christopher.leech@intel.com) wrote:
> From: Chris Leech [mailto:christopher.leech@intel.com] 
> Sent: Friday, March 10, 2006 6:29 PM
> To: 
> Subject: [PATCH 2/8] [I/OAT] Driver for the Intel(R) I/OAT DMA engine
> 
> 
> Adds a new ioatdma driver

enumerate_dma_channels() is still broken, if it can not fail add NOFAIL
gfp flag.
And you play tricky games with common_node/device_node of struct
dma_chan - one of that lists is never protected, while other is called 
under RCU and other locks (btw, why does insertion use RCU and deletion
in dma_async_device_unregister() does not?).
struct ioat_dma_chan - is it somewhere freed?

-- 
	Evgeniy Polyakov
