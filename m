Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbSK3TgC>; Sat, 30 Nov 2002 14:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267288AbSK3TgC>; Sat, 30 Nov 2002 14:36:02 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:15517 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267286AbSK3TgB>; Sat, 30 Nov 2002 14:36:01 -0500
Date: Sat, 30 Nov 2002 11:43:05 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Trivial patch: linux-2.5.50/fs/read_write.c contained unnecessary assignment in do_readv_writev
Message-ID: <20021130114305.A503@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Al,

	I'm not sure if you are the right person to send this
to.  If there is a more appropriate person to send this patch
to, feel free to redirect me.

	The following patch deletes an unncessary assignment
in do_readv_writev.  I've widened the patch context to make it
clear that the assignment was being overwritten immediately,
regardless of the result of the "if" statement that follows it.

	If this patch looks OK, can you please forward it to Linus?
If you'd rather I send this down some other path to Linus, please let
me know.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

--- linux-2.5.50/fs/read_write.c	2002-11-27 14:36:14.000000000 -0800
+++ linux/fs/read_write.c	2002-11-30 11:35:14.000000000 -0800
@@ -400,15 +400,14 @@
 	/* VERIFY_WRITE actually means a read, as we write to user space */
 	ret = locks_verify_area((type == READ 
 				 ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE),
 				inode, file, *pos, tot_len);
 	if (ret)
 		goto out;
 
-	fnv = NULL;
 	if (type == READ) {
 		fn = file->f_op->read;
 		fnv = file->f_op->readv;
 	} else {
 		fn = (io_fn_t)file->f_op->write;
 		fnv = file->f_op->writev;
 	}

--+QahgC5+KEYLbs62--
