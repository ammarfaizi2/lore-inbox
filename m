Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTERJXl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 05:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbTERJXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 05:23:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26811 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262001AbTERJXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 05:23:39 -0400
Date: Sun, 18 May 2003 02:35:33 -0700 (PDT)
Message-Id: <20030518.023533.98888328.davem@redhat.com>
To: arjanv@redhat.com
Cc: jes@wildopensource.com, torvalds@transmeta.com,
       James.Bottomley@steeleye.com, grundler@dsl2.external.hp.com,
       cngam@sgi.com, jeremy@sgi.com, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org, wildos@sgi.com
Subject: Re: [patch] support 64 bit pci_alloc_consistent
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1053250142.1300.8.camel@laptop.fenrus.com>
References: <16071.1892.811622.257847@trained-monkey.org>
	<1053250142.1300.8.camel@laptop.fenrus.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arjan van de Ven <arjanv@redhat.com>
   Date: 18 May 2003 11:29:02 +0200

   #define PCI_DMA_64BIT 0xffffffffffffffffULL
   #define PCI_DMA_32BIT 0xffffffffULL
   
   void pci_set_dma_capabilities(device, 
                  u64 streaming_mask, u64 persistent_mask);
   u64 pci_get_effective_streaming_mask(device);
   u64 pci_get_effective_persistent_mask(device);
   
   if for some reason the architecture PCI code needs or wants to reduce
   the DMA mask

WHile logically you are correct, the probing code is going to
look basically identical.

Instead of frobbing around with pci_set_dma() calls, you're going
to be frobbing around with pci_get_effective*() calls and branching
based upon that.

I really see no value in this.  Both are effectively equivalent
and the present setup has the advantage that it has existed for
some time and driver authors (at least some :-) know how to use
it already.
