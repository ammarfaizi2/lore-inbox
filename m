Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264699AbUD1I5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264699AbUD1I5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 04:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUD1I5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 04:57:43 -0400
Received: from math.ut.ee ([193.40.5.125]:53730 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264699AbUD1I5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 04:57:42 -0400
Date: Wed, 28 Apr 2004 11:57:38 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Gerd Knorr <kraxel@bytesex.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: video-buf warning
Message-ID: <Pine.GSO.4.44.0404281150410.24906-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.6-rc3 on a sparc64. The warning has been there for quite
some time, finally got around to report it.

  CC [M]  drivers/media/video/video-buf.o
drivers/media/video/video-buf.c: In function `videobuf_iolock':
drivers/media/video/video-buf.c:327: warning: cast from pointer to integer of different size

The specific code is
/* FIXME: need sanity checks for vb->boff */
bus   = (dma_addr_t)fbuf->base + vb->boff;

bus is dma_addr_t (==u32 on sparc64), base is void*

So if buf->base is really an arbitrary pointer, it might not fit into
u32. What is it actually?

-- 
Meelis Roos (mroos@linux.ee)

