Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVFJVQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVFJVQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 17:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFJVQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 17:16:47 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8601 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261249AbVFJVQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 17:16:38 -0400
Subject: Re: DMA mapping (was Re: [PATCH] cciss 2.6; replaces DMA masks
	with kernel defines)
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, mike.miller@hp.com, akpm@osdl.org,
       axboe@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <1118436306.5272.37.camel@laptopd505.fenrus.org>
References: <20050610143453.GA26476@beardog.cca.cpqcorp.net>
	 <42A9C60E.3080604@pobox.com>  <1118436000.6423.42.camel@mindpipe>
	 <1118436306.5272.37.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 17:17:32 -0400
Message-Id: <1118438253.6423.72.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 22:45 +0200, Arjan van de Ven wrote:
> On Fri, 2005-06-10 at 16:39 -0400, Lee Revell wrote:
> > On Fri, 2005-06-10 at 12:55 -0400, Jeff Garzik wrote:
> > > mike.miller@hp.com wrote:
> > > > This patch removes our homegrown DMA masks and uses the ones defined in
> > > > the kernel instead.
> > > > Thanks to Jens Axboe for the code. Please consider this for inclusion.
> > > > 
> > > > Signed-off-by: Mike Miller <mike.miller@hp.com>
> > > 
> > > You need to add '#include <linux/dma-mapping.h>'
> > > 
> > 
> > Why doesn't this file define 29, 30, 31 bit DMA masks, required by many
> > devices?  I know of at least 2 soundcards that need a 29 bit DMA mask.
> 
> your mail unfortunately was not in diff -u form ;)
> I'm pretty sure that such constants are welcome
> 

OK, this covers the drivers I know.  I didn't make any attempt to check
them all.


According to Robert Love's book there's at least one device than can
only DMA into a 24 bit address space, maybe the PCI NE2K?

Sommary: Add mask defines for some devices that can't DMA into full
32/64 bit address space.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- linux-2.6.12-rc5-k7/include/linux/dma-mapping.h~	2005-03-02 02:38:25.000000000 -0500
+++ linux-2.6.12-rc5-k7/include/linux/dma-mapping.h	2005-06-10 17:10:12.000000000 -0400
@@ -15,6 +15,8 @@
 
 #define DMA_64BIT_MASK	0xffffffffffffffffULL
 #define DMA_32BIT_MASK	0x00000000ffffffffULL
+#define DMA_31BIT_MASK	0x000000007fffffffULL
+#define DMA_29BIT_MASK	0x000000001fffffffULL
 
 #include <asm/dma-mapping.h>
 


