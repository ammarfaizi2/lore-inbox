Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291082AbSBNJfO>; Thu, 14 Feb 2002 04:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291088AbSBNJfH>; Thu, 14 Feb 2002 04:35:07 -0500
Received: from Expansa.sns.it ([192.167.206.189]:10245 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S291082AbSBNJe7>;
	Thu, 14 Feb 2002 04:34:59 -0500
Date: Thu, 14 Feb 2002 10:35:06 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: linux-kernel@vger.kernel.org
Subject: 2.5.5-pre1 and i810_audio.c
Message-ID: <Pine.LNX.4.44.0202141031470.27359-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i810audio.c actually does not compile.

this seems to solve:

--- linux/sound/oss/i810_audio.c.old    Thu Feb 14 10:33:12 2002
+++ linux/sound/oss/i810_audio.c        Thu Feb 14 10:29:40 2002
@@ -1669,7 +1669,7 @@
        if (size > (PAGE_SIZE << dmabuf->buforder))
                goto out;
        ret = -EAGAIN;
-       if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+       if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
                             size, vma->vm_page_prot))
                goto out;
        dmabuf->mapped = 1;


