Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290589AbSA3UpH>; Wed, 30 Jan 2002 15:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290588AbSA3Uo7>; Wed, 30 Jan 2002 15:44:59 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:19466 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S290575AbSA3Uon>; Wed, 30 Jan 2002 15:44:43 -0500
Date: Wed, 30 Jan 2002 21:44:39 +0100 (CET)
From: Martin Bahlinger <ry42@rz.uni-karlsruhe.de>
X-X-Sender: <ry42@hek411.hek.uni-karlsruhe.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.3: zutil.h; i810_audio.c
Message-ID: <Pine.LNX.4.31.0201302143320.11860-100000@hek411.hek.uni-karlsruhe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In the just released 2.5.3 source-tree the files zutil.h and zconf.h are
not found when building /usr/src/linux/lib/zlib_deflate/deflate.c
Moving them from linux/linux to linux/include/linux worked for me.

And to make i810_audio build, apply:


--- i810_audio.c.orig   Mon Jan 28 23:35:13 2002
+++ i810_audio.c        Wed Jan 30 21:35:43 2002
@@ -1669,7 +1669,7 @@
        if (size > (PAGE_SIZE << dmabuf->buforder))
                goto out;
        ret = -EAGAIN;
-       if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+       if (remap_page_range(vma, vma->vm_start,
virt_to_phys(dmabuf->rawbuf),
                             size, vma->vm_page_prot))
                goto out;
        dmabuf->mapped = 1;




bye
  Martin

-- 
Martin Bahlinger <bahlinger@rz.uni-karlsruhe.de>   (PGP-ID: 0x98C32AC5)

