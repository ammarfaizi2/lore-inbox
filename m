Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317688AbSFLMGs>; Wed, 12 Jun 2002 08:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317689AbSFLMGr>; Wed, 12 Jun 2002 08:06:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49616 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317688AbSFLMGq>;
	Wed, 12 Jun 2002 08:06:46 -0400
Date: Wed, 12 Jun 2002 05:02:17 -0700 (PDT)
Message-Id: <20020612.050217.74345581.davem@redhat.com>
To: oliver@neukum.name
Cc: benh@kernel.crashing.org, roland@topspin.com, wjhun@ayrnetworks.com,
        paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206121402.53622.oliver@neukum.name>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oliver Neukum <oliver@neukum.name>
   Date: Wed, 12 Jun 2002 14:02:53 +0200
   
   If I understand both Davids correctly this is the solution.
   Buffers for dma must be allocated seperately using a special allocation
   function which is given the device so it can allocate correctly.
   David B wants a bus specific pointer to a function in the generic
   driver structure, right ?
   
Eventually it could be exactly that, via the generic driver struct.

For now it can be a usb specific thing, and when the generic device
stuff is ready we just go:

#define usb_pool_alloc(...)	dev_pool_alloc(...)

without having to touch any of the driver call sites.
