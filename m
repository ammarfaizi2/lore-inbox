Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbUKDL5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUKDL5j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbUKDLza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:55:30 -0500
Received: from sd291.sivit.org ([194.146.225.122]:65498 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261385AbUKDLsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:48:55 -0500
Date: Thu, 4 Nov 2004 12:49:04 +0100
From: Stelian Pop <stelian@popies.net>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/12] meye: the driver is no longer experimental and depends on PCI
Message-ID: <20041104114904.GV3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr> <20041104111613.GM3472@crusoe.alcove-fr> <20041104114126.GA31736@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104114126.GA31736@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 11:41:26AM +0000, Christoph Hellwig wrote:
> > +	depends on VIDEO_DEV && PCI && SONYPI && !HIGHMEM64G
> 
> What's the problem with PAE?

Read the source:
-----------------
 * NOTE: The meye device expects dma_addr_t size to be 32 bits
 * (the toc must be exactly 1024 entries each of them being 4 bytes
 * in size, the whole result being 4096 bytes). We're using here
 * dma_addr_t for corectness but the compilation of this driver is
 * disabled for HIGHMEM64G=y, where sizeof(dma_addr_t) != 4 !
-----------------

Of course, the actual hardware does exist only on C1V* Vaio Laptops,
which can accept at most 256 MB RAM, so the test is there in Kconfig
only to prevent 'make allyesconfig' and equivalents from spitting
warnings...

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
