Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbTFCPmC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbTFCPmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:42:01 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:63913 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265053AbTFCPmA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:42:00 -0400
Date: Tue, 3 Jun 2003 10:55:21 -0500
Subject: [CHECKER][PATCH] bw-qcam.c bad copy_to_user
Content-Type: multipart/mixed; boundary=Apple-Mail-4--960889775
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@transmeta.com>
From: Hollis Blanchard <hollisb@us.ibm.com>
Message-Id: <C7EB052A-95DB-11D7-A933-000A95A0560C@us.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-4--960889775
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Like radio-cadet.c, bw-qcam.c is calling copy_to_user() where it 
shouldn't. The user buffer is copied to/from kernel space by 
drivers/media/video/videodev.c:video_usercopy() . Please apply.

-- 
Hollis Blanchard
IBM Linux Technology Center

--Apple-Mail-4--960889775
Content-Disposition: attachment;
	filename=bwqcam-copy_to_user.txt
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	x-unix-mode=0644;
	name="bwqcam-copy_to_user.txt"

===== drivers/media/video/bw-qcam.c 1.11 vs edited =====
--- 1.11/drivers/media/video/bw-qcam.c	Sun Feb 16 18:16:53 2003
+++ edited/drivers/media/video/bw-qcam.c	Tue Jun  3 10:28:29 2003
@@ -723,8 +723,6 @@
 			/* Good question.. its composite or SVHS so.. */
 			v->type = VIDEO_TYPE_CAMERA;
 			strcpy(v->name, "Camera");
-			if(copy_to_user(arg, &v, sizeof(v)))
-				return -EFAULT;
 			return 0;
 		}
 		case VIDIOCSCHAN:

--Apple-Mail-4--960889775--

