Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTHVMns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbTHVMkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:40:42 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:14745 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263170AbTHVL4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 07:56:01 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jes@wildopensource.com,
       zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 22 Aug 2003 13:54:11 +0200
In-Reply-To: <m34r0dwfrr.fsf@defiant.pm.waw.pl>
Message-ID: <m38ypl29i4.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think we should do it the following way:
- adding pci_alloc_consistent_mask(..., u64 mask), pci_map_*_mask(..., mask)
  and DMA API friends
- adding a routine checking if a mask is valid on given system
- renaming existing routines to *_nomask and aliasing old names to them.

then:

- migrating drivers from old ones to _mask (the non-trivial part)

then:

- dropping support for _nomasks and then probably renaming _masks to
  old names.


alternative, probably a cleaner one - using "int bits" instead of "u64 mask".
Devices tend to be X-bit (32-bit, 64-bit, 28-bit etc) rather than to have
0xFFFFFFFFFFFFFFFFFFFFF masks anyway. And the dma_mask has to be
continuous, right? The "bits" value is much more readable, too. Of course,
moving from bits to mask and vice versa is easy, it could even be a macro.

Unless there are objections I'm going to start with *_bits.
-- 
Krzysztof Halasa
Network Administrator
