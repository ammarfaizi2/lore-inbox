Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbTA2GSF>; Wed, 29 Jan 2003 01:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbTA2GSF>; Wed, 29 Jan 2003 01:18:05 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:5169 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S264878AbTA2GSE>; Wed, 29 Jan 2003 01:18:04 -0500
Date: Wed, 29 Jan 2003 01:29:11 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
In-Reply-To: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.50L0.0301290119320.23868-100000@quinn.larvalstage.com>
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo,

Having CONFIG_DRM40_I810=y causes following compile error:

i810_dma.c: In function `i810_unmap_buffer':
i810_dma.c:234: too many arguments to function `do_munmap'


Following patch fixes that breakage.

John Kim


--- linux-2.4.21-pre4/drivers/char/drm-4.0/i810_dma.c	2003-01-28 23:30:41.000000000 -0500
+++ linux-2.4.21-pre4-new/drivers/char/drm-4.0/i810_dma.c	2003-01-29 01:14:28.000000000 -0500
@@ -231,7 +231,7 @@
 #else
         	retcode = do_munmap(current->mm, 
 				    (unsigned long)buf_priv->virtual, 
-				    (size_t) buf->total, 1);
+				    (size_t) buf->total);
 #endif
    		up_write(&current->mm->mmap_sem);
 	}

