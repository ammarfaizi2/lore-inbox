Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSL1Ckg>; Fri, 27 Dec 2002 21:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbSL1Ckg>; Fri, 27 Dec 2002 21:40:36 -0500
Received: from h-64-105-35-71.SNVACAID.covad.net ([64.105.35.71]:61367 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265400AbSL1Ckf>; Fri, 27 Dec 2002 21:40:35 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 27 Dec 2002 18:48:48 -0800
Message-Id: <200212280248.SAA25890@adam.yggdrasil.com>
To: david-b@pacbell.net, James.bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, manfred@colorfulllife.com
Subject: Re: [RFT][PATCH] generic device DMA implementation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2002-12-28 1:29:54 GMT, David Brownell wrote:
>Isn't the goal to make sure that for every kind of "struct device *"
>it should be possible to use those dma_*() calls, without BUGging
>out.

	No.

>If that's not true ... then why were they defined?

	So that other memory mapped busses such as ISA and sbus
can use them.

	USB devices should do DMA operations with respect to their USB
host adapters, typically a PCI device.  For example, imagine a machine
with two USB controllers on different bus instances.

	One of these days, I'd like to add "struct device *dma_dev;" to
struct request_queue to facilitate optional centralization of
dma_{,un}map_sg for most hardware drivers.  PCI scsi controllers, for
example would set dma_dev to the PCI device.  USB scsi controllers
would set it to the USB host adapter.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
