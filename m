Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319667AbSIMTkO>; Fri, 13 Sep 2002 15:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319762AbSIMTkO>; Fri, 13 Sep 2002 15:40:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19660 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319667AbSIMTkN>;
	Fri, 13 Sep 2002 15:40:13 -0400
Date: Fri, 13 Sep 2002 12:36:41 -0700 (PDT)
Message-Id: <20020913.123641.50140065.davem@redhat.com>
To: akropel1@rochester.rr.com
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Streaming DMA mapping question
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020913193916.GA5004@www.kroptech.com>
References: <20020913193916.GA5004@www.kroptech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Adam Kropelin <akropel1@rochester.rr.com>
   Date: Fri, 13 Sep 2002 15:39:16 -0400
   
   According to the docs, you should either unmap or sync your DMA buffer before
   touching it from the host. The i386 implementation of pci_unmap is empty --no
   problem; there must not be any unmap work to do on this arch. But the 
   implementation of pci_dma_sync does contain a flush_write_buffers() call. This
   makes me think that perhaps if I'm going to modify the buffer before I submit it
   back to the controller I need to do:

Actually, rather it appears that the i386 pci_unmap_*() routines need
the write buffer flush as well.

The x86 implementation is a bad example to read if you're trying to
see what the worst case scenerio is.

Just follow the document and your driver will work properly on all
platforms.  DMA-mapping.txt was meant to be written in a way such
that you should not ever need to look at an implementation of the
interfaces to figure out how to use them.
