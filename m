Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290837AbSAaCdZ>; Wed, 30 Jan 2002 21:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290838AbSAaCdQ>; Wed, 30 Jan 2002 21:33:16 -0500
Received: from lsanca1-ar27-4-63-184-089.vz.dsl.gtei.net ([4.63.184.89]:19840
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S290837AbSAaCdD>; Wed, 30 Jan 2002 21:33:03 -0500
Date: Wed, 30 Jan 2002 18:32:55 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Pawel Worach <pawel.worach@mysun.com>
cc: <linux-kernel@vger.kernel.org>, <dledford@redhat.com>
Subject: Re: 2.5.3 won't compile (i810_audio)
In-Reply-To: <3C5870E2.7030102@mysun.com>
Message-ID: <Pine.LNX.4.33.0201301829510.2090-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Pawel Worach wrote:

> The new i810_audio driver merged into 2.5.3 won't compile.

I made the following one line change, and it seems to be working.

--- drivers/sound/i810_audio.c-src	Wed Jan 30 18:30:51 2002
+++ drivers/sound/i810_audio.c	Wed Jan 30 18:22:39 2002
@@ -1669,7 +1669,7 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;


-- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Job Required in Los Angeles - Will do most things unix or IP for money.
http://www.hawaga.org.uk/resume/resume001.pdf
Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi


