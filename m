Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVJQKD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVJQKD6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 06:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVJQKD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 06:03:58 -0400
Received: from mx1.actcom.net.il ([192.114.47.64]:47574 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S932245AbVJQKD5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 06:03:57 -0400
Date: Mon, 17 Oct 2005 12:02:57 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, ak@suse.de,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       torvalds@osdl.org, shai@scalex86.org,
       "John W. Linville" <linville@tuxdriver.com>
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051017100257.GD21783@granada.merseine.nu>
References: <20051017093654.GA7652@localhost.localdomain> <20051017025007.35ae8d0e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017025007.35ae8d0e.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 02:50:07AM -0700, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > On x86_64 NUMA boxes, the revert
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6e3254c4e2927c117044a02acf5f5b56e1373053
> > meant that swiotlb gets the IOTLB
> > memory from pages over 4G (if mem > 4G), which basically renders swiotlb useless, causing
> > breakage with devices not capable of DMA beyond 4G.  2.6.13 was (kinda) not
> > broken, although the patch titled "Reverse order of bootmem lists" was
> > not in 2.6.13, The reason is commit
> > http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6142891a0c0209c91aa4a98f725de0d6e2ed4918
> > was not in 2.6.13, PCI_DMA_BUS_IS_PHYS was 1 when no mmu was present, and the block layer did 
> > the bouncing, never using swiotlb.  I guess the right fix is to make sure
> > swiotlb gets the right memory.  Here is a patch doing that.  Tested on IBM
> > x460.  I hope the patch is ok for ia64s too.  I do not have access to ia64
> > boxen.
> > 
> 
> This is an ia64 patch - what point was there in testing it on an x460?
> 
> Is something missing here?

x86-64 uses swioltb as well, via arch/ia64 directly. John Linville has
a patch to move the swiotlb to lib/swiotlb.c that is waiting in an
IA64 for inclusion (post 2.6.14, I guess?)

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

