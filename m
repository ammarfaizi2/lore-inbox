Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277585AbRJHWtF>; Mon, 8 Oct 2001 18:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277577AbRJHWsz>; Mon, 8 Oct 2001 18:48:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41606 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277587AbRJHWsk>;
	Mon, 8 Oct 2001 18:48:40 -0400
Date: Mon, 08 Oct 2001 15:46:50 -0700 (PDT)
Message-Id: <20011008.154650.48796051.davem@redhat.com>
To: dwmw2@infradead.org
Cc: frival@zk3.dec.com, paulus@samba.org, Martin.Bligh@us.ibm.com,
        alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, jay.estabrook@compaq.com,
        rth@twiddle.net
Subject: Re: [PATCH] change name of rep_nop 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <13962.1002580586@redhat.com>
In-Reply-To: <1573466920.1002300846@mbligh.des.sequent.com>
	<15294.24873.866942.423260@cargo.ozlabs.ibm.com>
	<13962.1002580586@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Woodhouse <dwmw2@infradead.org>
   Date: Mon, 08 Oct 2001 23:36:26 +0100

   While we're on the subject of stupidly named routines and x86-isms, I'm 
   having trouble reconciling this text in Documentation/cachetlb.txt:
   
   	1) void flush_cache_all(void)
   
   	        The most severe flush of all.  After this interface runs,
   	        the entire cpu cache is flushed.
   
   ... with this implementation in include/asm-i386/pgtable.h:
   
   	#define flush_cache_all()			do { } while (0)
   
   That really doesn't seem to be doing what it says on the tin.
   
"for the purposes of having the processor maintain cache coherency
 due to a kernel level TLB mapping change"

Yes, I know the text isn't there, but that is the implication.
Add the text, don't add a stupid "simon_says.." interface.

The mtrr stuff, if it really does need the flush, should probably
make it's own macro/inline with a huge comment about it explaining
why the flush is actually needed.

   Some people have asserted, falsely, that it's never sane to want an i386 to
   flush its cache.

"for the purposes of having the processor maintain cache coherency
 due to a kernel level TLB mapping change"

All of these flush_foo interfaces are about cache flushes needed when
address space changes occur.  They are not meant to be a way to deal
with all sorts of other cache details, for those we have the PCI DMA
interfaces, flush_dcache_page etc.

   Even if that were true, it wouldn't really be an excuse for
   the above discrepancy.
   
There is no discrepancy, only missing text in cachetlb.txt, please
add it, but I thought that the location of the routine made it obvious
what context it is meant to operate and be used.

Franks a lot,
David S. Miller
davem@redhat.com
