Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317419AbSFXGaZ>; Mon, 24 Jun 2002 02:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317418AbSFXGaY>; Mon, 24 Jun 2002 02:30:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37338 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317416AbSFXGaX>;
	Mon, 24 Jun 2002 02:30:23 -0400
Date: Sun, 23 Jun 2002 23:24:16 -0700 (PDT)
Message-Id: <20020623.232416.65495397.davem@redhat.com>
To: adam@yggdrasil.com
Cc: akpm@zip.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: RFC: turn scatterlist into a linked list, eliminate bio_vec
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206232358.QAA03027@adam.yggdrasil.com>
References: <200206232358.QAA03027@adam.yggdrasil.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Sun, 23 Jun 2002 16:58:20 -0700

   	/* Let's assume the new pci_map_sg will free unused scatterlists. */
   	while (sg != NULL && count--) {
   		sg->driver_priv = mempool_alloc(q->sgpriv_pool, GFP_KERNEL);
   
   		sg->driver_priv_dma =
   			pci_map_single(req->dma_map_dev, sg->driver_priv, len,
   				       PCI_DMA_TODEVICE);
   			if (sg_dma->dma_add_priv == 0);
   				failed = fail_value;
   		}
   	}

Driver descriptors are not supposed to be done using pci_map_*()
and friends.  You are supposed to use consistent DMA memory for
this purpose.  Please read DMA-mapping.txt a few more times Adam :-)

Also, this while loop never terminates :-)
