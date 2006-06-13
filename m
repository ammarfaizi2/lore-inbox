Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932886AbWFMFDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbWFMFDh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 01:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932887AbWFMFDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 01:03:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49025
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932885AbWFMFDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 01:03:36 -0400
Date: Mon, 12 Jun 2006 22:03:46 -0700 (PDT)
Message-Id: <20060612.220346.71553967.davem@davemloft.net>
To: ak@suse.de
Cc: jeremy@goop.org, lkml@rtr.ca, mpm@selenic.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Using netconsole for debugging suspend/resume
From: David Miller <davem@davemloft.net>
In-Reply-To: <200606130654.14477.ak@suse.de>
References: <200606130547.49624.ak@suse.de>
	<20060612.214948.124554804.davem@davemloft.net>
	<200606130654.14477.ak@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Tue, 13 Jun 2006 06:54:14 +0200

> I guess if you use 1394 with remote DMA for other protocols (like
> video etc.) there must be some way for the subsystem to map
> the memory even on IOMMU systems. I admit I haven't dived that
> deeply into the 1394 subsystem so I don't know how that works.

Video-1394 has it's own driver, which does a consistent DMA
allocation, and then maps that into userspace using remap_pfn_range().
Entirely portable.

Strangely I don't even see any bus_to_virt() etc. calls in
the raw1394 driver, just these ptr2int() things...

