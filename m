Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262714AbRE0C0d>; Sat, 26 May 2001 22:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbRE0C0X>; Sat, 26 May 2001 22:26:23 -0400
Received: from epic17.Stanford.EDU ([171.64.15.52]:41402 "EHLO
	epic17.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S262714AbRE0C0E>; Sat, 26 May 2001 22:26:04 -0400
Date: Sat, 26 May 2001 19:25:52 -0700 (PDT)
From: John Martin <suntzu@stanford.edu>
To: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: [PATCH] zr36120.c
Message-ID: <Pine.GSO.4.31.0105261911170.2445-100000@epic17.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found this error using xgcc with metal as an error checker.  It seems to
be a simple case of not freeing allocatd memory on an error path.
    -john martin


--- drivers/media/video/zr36120.c.orig      Fri Mar  2 11:12:10 2001
+++ drivers/media/video/zr36120.c   Sat May 19 15:31:03 2001
@@ -1195,7 +1195,10 @@
                if (vcp==NULL)
                        return -ENOMEM;
                if (vw.clipcount && copy_from_user(vcp,vw.clips,sizeof(struct video_clip)*vw.clipcount))
+               {
+                       vfree(vcp);
                        return -EFAULT;
+               }

                on = ztv->running;
                if (on)

