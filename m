Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262535AbREUXfH>; Mon, 21 May 2001 19:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbREUXe6>; Mon, 21 May 2001 19:34:58 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:60927 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S262535AbREUXes>; Mon, 21 May 2001 19:34:48 -0400
Message-Id: <5.0.2.1.2.20010521162946.00ae8a18@pxwang.pobox.stanford.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 21 May 2001 16:34:37 -0700
To: alan@lxorguk.ukuu.org.uk
From: Philip Wang <PXWang@stanford.edu>
Subject: [PATCH] drivers/media/video/zr36120.c
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Dawson Engler <engler@cs.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm Philip, from Professor Dawson Engler's Meta-Compilation Group at 
Stanford University.

There is a bug in zr36120.c of not freeing memory on error paths.  This one 
is particularly dangerous, because kmalloc allocates a memory block the 
size of a memory clip!  I simply free the local pointer, vcp, before 
returning -EFAULT.

Warmly,

Philip

linux/2.4.4/drivers/media/video/zr36120.c Fri Mar 2 11:12:10 2001
+++ zr36120.c Mon May 21 13:26:17 2001
@@ -1195,8 +1195,10 @@
if (vcp==NULL)
return -ENOMEM;
if (vw.clipcount &&
copy_from_user(vcp,vw.clips,sizeof(struct video_clip)*vw.clipcount))
- return -EFAULT;
-
+ {
+ vfree(vcp);
+ return -EFAULT;
+ }
on = ztv->running;
if (on)
zoran_cap(ztv, 0);

