Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWGLXkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWGLXkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWGLXkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:40:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56251
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932206AbWGLXku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:40:50 -0400
Date: Wed, 12 Jul 2006 16:40:48 -0700 (PDT)
Message-Id: <20060712.164048.51855175.davem@davemloft.net>
To: ralphc@pathscale.com
Cc: rolandd@cisco.com, openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: Suggestions for how to remove bus_to_virt()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1152746967.4572.263.camel@brick.pathscale.com>
References: <1152746967.4572.263.camel@brick.pathscale.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <ralphc@pathscale.com>
Date: Wed, 12 Jul 2006 16:29:27 -0700

> Currently, the ib_ipath driver requires that the mapping be
> one-to-one since there is no practical way to reverse IOMMU
> mappings.

You can maintain a hash table that maps DMA addresses back to kernel
mappings.  Depending upon your situation, you can optimize this to use
very small keys if you have some kind of other identification method
for your buffers.

That would be for dynamic mappings.

You were using consistent DMA memory, which I gather you're not,
you could use the PCI DMA pool mechanism.
