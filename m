Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbVKWWVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbVKWWVv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVKWWVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:21:51 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:35008 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932586AbVKWWVu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:21:50 -0500
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Grover <andrew.grover@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, john.ronciak@intel.com,
       christopher.leech@intel.com
In-Reply-To: <4384E7F2.2030508@pobox.com>
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com>
	 <4384E7F2.2030508@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Nov 2005 22:54:04 +0000
Message-Id: <1132786445.13095.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-23 at 17:06 -0500, Jeff Garzik wrote:
> Sample ideas:  VM page pre-zeroing.  ATA PIO data xfers (async copy to 
> static buffer, to dramatically shorten length of kmap+irqsave time). 
> Extremely large memcpy() calls.

ATA PIO copies are 512 bytes of memory per sector and that is usually
already in cache and on cache line boundaries. You won't even be able to
measure it done by the CPU. I can't see the I/O engine sync cost being
worth it.

Might just about help large transfers I guess but you don't do
multisector which is the only case you'd get perhaps 8K an I/O.

> Additionally, current IOAT is memory->memory.  I would love to be able 
> to convince Intel to add transforms and checksums, 

Not just transforms but also masks and maybe even merges and textures
would be rather handy 8)

