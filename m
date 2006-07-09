Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWGIAHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWGIAHI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 20:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWGIAHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 20:07:08 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:47542 "HELO
	cerise.buici.com") by vger.kernel.org with SMTP id S1030423AbWGIAHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 20:07:06 -0400
Date: Sat, 8 Jul 2006 17:07:03 -0700
From: Marc Singer <elf@buici.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: DMA memory, split_page, BUG_ON(PageCompound()), sound
Message-ID: <20060709000703.GA9806@cerise.buici.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm investigating why I am triggering a BUG_ON in split_page() when I
use the sound subsystems dma memory allocation aide.

The crux of the problem appears to be that snd_malloc_dev_pages()
passes __GFP_COMP into dma_alloc_coherent().  On the ARM and several
other architectures, the dma allocation code calls split_page () with
pages allocated with this flag which, in turn, triggers the BUG_ON()
check for the CompoundPage flag.

So, the questions are these: Who is doing the wrong thing?  Should the
snd_malloc_dev_pages() call drop the __GFP_COMP flag?  Should
split_page() allow the page to be compound?  Should __GFP_COMP be 0 on
ARM and other architectures that don't support compound pages?


