Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267501AbRGRTQy>; Wed, 18 Jul 2001 15:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbRGRTQn>; Wed, 18 Jul 2001 15:16:43 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:62030 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267528AbRGRTQh>; Wed, 18 Jul 2001 15:16:37 -0400
Date: Wed, 18 Jul 2001 15:16:42 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200107181916.f6IJGgG04414@devserv.devel.redhat.com>
To: alexander.ehlert@uni-tuebingen.de, <linux-kernel@vger.kernel.org>
Subject: Re: Right Semantics for ioremap, remap_page_range
In-Reply-To: <mailman.995456342.9505.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.995456342.9505.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> base for 64Mb Ram Onboard. After ioremap() I actually like
> to do remap_page_range through fileops/mmap call.

Bad idea. The remap_page_range can remap actual memory only,
located on the CPU side of the I/O bridge.
What ioremap returns is useful in readb/writeb only, and
not to be fed into other functions.

Instead, use io_remap_page_range, lift the example from
drivers/video/fbmem.c.

-- Pete
