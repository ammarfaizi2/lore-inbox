Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289537AbSBGOAB>; Thu, 7 Feb 2002 09:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289564AbSBGN7w>; Thu, 7 Feb 2002 08:59:52 -0500
Received: from mail.chs.ru ([194.154.71.136]:27155 "EHLO mail.unix.ru")
	by vger.kernel.org with ESMTP id <S289537AbSBGN7k>;
	Thu, 7 Feb 2002 08:59:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Subject: [PATCH ] 2.5.4-pre2 i810_audio.c compile fix (was Fwd: Re: 2.5.3 won't compile (i810_audio))
Date: Thu, 7 Feb 2002 16:59:37 +0300
X-Mailer: KMail [version 1.3.2]
Cc: Doug Ledford <dledford@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Message-Id: <E16Yp5P-0005xO-00@mail.unix.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This patch make drivers/sound/i810_audio.c to be compiled
Still needed and applies cleanly to 2.5.4-pre2

compiled, booted and tested on my pc.

--
			Best regards,
			Sergey S. Kostyliov <rathamahata@php4.ru>

----------  Forwarded message ----------

Subject: Re: 2.5.3 won't compile (i810_audio)
Date: Wed, 30 Jan 2002 18:32:55 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Pawel Worach <pawel.worach@mysun.com>
Cc: <linux-kernel@vger.kernel.org>, <dledford@redhat.com>

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
