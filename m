Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSFKEZo>; Tue, 11 Jun 2002 00:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316773AbSFKEZn>; Tue, 11 Jun 2002 00:25:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17601 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316750AbSFKEZl>;
	Tue, 11 Jun 2002 00:25:41 -0400
Date: Mon, 10 Jun 2002 21:21:35 -0700 (PDT)
Message-Id: <20020610.212135.129520403.davem@redhat.com>
To: roland@topspin.com
Cc: wjhun@ayrnetworks.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52lm9m7969.fsf@topspin.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Dreier <roland@topspin.com>
   Date: 10 Jun 2002 21:04:30 -0700

   That's fine but there are drivers (USB, etc) doing
   
   	struct something {
   	        int field1;
   	        char dma_buffer[SMALLER_THAN_CACHE_LINE];
   	        int field2;
   	};
   
   	struct something *dev = kmalloc(sizeof *dev, GFP_KERNEL);
   
   Do they have to change to
   
How about allocating struct something using pci_pool?
