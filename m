Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbVKWXdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbVKWXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVKWXdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:33:09 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:44753 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751317AbVKWXdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:33:07 -0500
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Grover <andrew.grover@intel.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, christopher.leech@intel.com
In-Reply-To: <20051123223007.GA5921@wotan.suse.de>
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com>
	 <4384E7F2.2030508@pobox.com>  <20051123223007.GA5921@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Nov 2005 00:05:40 +0000
Message-Id: <1132790740.13095.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-23 at 23:30 +0100, Andi Kleen wrote:
> Another proposal was swiotlb.

I was hoping Intel might have rediscovered the IOMMU by then and be back
on feature parity with the VAX 11/750 
> 
> But it's not clear it's a good idea: a lot of these applications prefer to 
> have the target in cache. And IOAT will force it out of cache.

This is true for some cases but not all for iotlb

CPU generated data going out that won't be rewritten immediately should
be a cheap path not needing the cache. Incoming data would invalidate
the cache anyway if it arrives by DMA so the ioat would move it
asynchronously of the CPU without cache harm

Might also be interesting to use one half of a hypedthread CPU as a
copier using the streaming instructions, might be better than turning it
off to improve performance ?

Alan

