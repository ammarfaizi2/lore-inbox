Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbUAOHBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 02:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbUAOHBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 02:01:06 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.117]:55775 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S264394AbUAOHBD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 02:01:03 -0500
Message-ID: <40063A20.9000406@myrealbox.com>
Date: Wed, 14 Jan 2004 22:58:40 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5a (20031223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Murilo Pontes <murilo_pontes@yahoo.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: loop device not work in 2.6.1-mm2 an 2.6.1-mm3
References: <fa.l6gqnit.t52ubp@ifi.uio.no>
In-Reply-To: <fa.l6gqnit.t52ubp@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Murilo Pontes wrote:

 > 21:44:56 [root@murilo:~]#mount -V
 > mount: mount-2.12
 >
 > umount: /tmp/ramdisk_mountdir: não montado
 > ioctl: LOOP_CLR_FD: No such device or address
 > mount: será usado o dispositivo de laço /dev/loop/0
 > ioctl: LOOP_SET_FD: Argumento inválido
 >
 >
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 >  in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/

Are you running reiserfs?  If so, this patch (from Ben Slusky) fixed it:

--- drivers/block/loop.c.old	2004-01-11 13:05:05.000000000 -0500
+++ drivers/block/loop.c	2004-01-14 07:49:24.795161024 -0500
@@ -853,9 +853,7 @@
  		blk_queue_merge_bvec(lo->lo_queue, q->merge_bvec_fn);
  	}

-	error = set_blocksize(bdev, lo_blocksize);
-	if (error)
-		goto out_putf;
+	set_blocksize(bdev, lo_blocksize);

  	kernel_thread(loop_thread, lo, CLONE_KERNEL);
  	down(&lo->lo_sem);
