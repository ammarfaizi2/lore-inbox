Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317542AbSFMIvb>; Thu, 13 Jun 2002 04:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317552AbSFMIvb>; Thu, 13 Jun 2002 04:51:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4059 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317542AbSFMIv3>;
	Thu, 13 Jun 2002 04:51:29 -0400
Date: Thu, 13 Jun 2002 01:47:00 -0700 (PDT)
Message-Id: <20020613.014700.26430433.davem@redhat.com>
To: saw@saw.sw.com.sg
Cc: fxzhang@ict.ac.cn, linux-mips@oss.sgi.com, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com, jgarzik@mandrakesoft.com
Subject: Re: NAPI for eepro100
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020613125753.A23693@castle.nmd.msu.ru>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrey Savochkin <saw@saw.sw.com.sg>
   Date: Thu, 13 Jun 2002 12:57:53 +0400

   On Wed, Jun 12, 2002 at 04:05:32PM -0700, David S. Miller wrote:
   > No, it's worse than that.
   > 
   > See how non-consistent memory is used by the eepro100 driver
   > for descriptor bits?  The skb->tail bits?
   > 
   > That is very problematic.
   
   What's the problem?
   If it isn't allowed to do, then what is the meaning of PCI_DMA_BIDIRECTIONAL
   mappings?

It's slow.  Not wrong, just inefficient.

Descriptors were meant to be done using consistent mappings, not
"pci_map_*()"'d memory.  The latter is meant to be used for long
linear DMA transfers to/from the device.  It is not meant for things
the cpu pokes small bits of data in and out of, that is what
consistent DMA memory is for.
