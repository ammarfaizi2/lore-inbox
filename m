Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130546AbQKTIJI>; Mon, 20 Nov 2000 03:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130440AbQKTII7>; Mon, 20 Nov 2000 03:08:59 -0500
Received: from mx7.sac.fedex.com ([199.81.194.38]:19210 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S130546AbQKTIIs>; Mon, 20 Nov 2000 03:08:48 -0500
Message-ID: <000901c052c4$9d315ee0$589ca19b@corp.fedex.com>
From: "Jeff Chua" <jchua@fedex.com>
To: "Werner Almesberger" <Werner.Almesberger@epfl.ch>, <viro@math.psu.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20001120042151.A599@almesberger.net>
Subject: Re: [PATCH,RFC] initrd vs. BLKFLSBUF
Date: Mon, 20 Nov 2000 15:36:12 +0800
Organization: FedEx
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner,

Thanks for fix. Applied the patch and it's working now.

Linus, please add this patch to the kernel source codes for 2.4.0.

Under 2.2.18, it's working fine without the patch.

Thanks,
Jeff
[ jchua@fedex.com ]
----- Original Message -----
From: "Werner Almesberger" <Werner.Almesberger@epfl.ch>
To: <viro@math.psu.edu>
Cc: <jchua@fedex.com>; <linux-kernel@vger.kernel.org>
Sent: Monday, November 20, 2000 11:21 AM
Subject: [PATCH,RFC] initrd vs. BLKFLSBUF


Hi Al,

Jeff Chua reported a while ago that BLKFLSBUF returns EBUSY on a RAM disk
that was obtained via initrd. I think the problem is that the effect of
the blkdev_open(out_inode, ...) in drivers/block/rd.c:rd_load_image is
not undone at the end. I've attached a patch for 2.4.0-test11-pre7 that
seems to solve the problem. Since I'm not quite sure I understand the
reference counting rules there, I would appreciate your comment.

Thanks,
- Werner

---------------------------------- cut
here -----------------------------------

--- linux.orig/drivers/block/rd.c Mon Nov 20 02:07:47 2000
+++ linux/drivers/block/rd.c Mon Nov 20 04:03:42 2000
@@ -690,6 +690,7 @@
 done:
  if (infile.f_op->release)
  infile.f_op->release(inode, &infile);
+ blkdev_put(out_inode->i_bdev, BDEV_FILE);
  set_fs(fs);
  return;
 free_inodes: /* free inodes on error */

--
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
