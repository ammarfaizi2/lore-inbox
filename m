Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264843AbRFTFxw>; Wed, 20 Jun 2001 01:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264846AbRFTFxn>; Wed, 20 Jun 2001 01:53:43 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:16144 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S264843AbRFTFx3>; Wed, 20 Jun 2001 01:53:29 -0400
Reply-To: <martin.frey@compaq.com>
From: "Martin Frey" <frey@scs.ch>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, <zippel@linux-m68k.org>,
        <tigran@veritas.com>, <hch@caldera.de>, <asun@cobaltnet.com>,
        <mikulas@artax.karlin.mff.cuni.cz>, <jffs-dev@axis.com>,
        <dwmw2@infradead.org>, <trond.myklebust@fys.uio.no>,
        <aia21@cus.cam.ac.uk>, <reiserfs-dev@namesys.com>
Cc: <baettig@scs.ch>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] large offset llseek breaks for device special files on ac series
Date: Wed, 20 Jun 2001 01:53:08 -0400
Message-ID: <017c01c0f94d$48e1f5e0$0100007f@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
In-Reply-To: <015e01c0f916$f9e33e30$0100007f@SCHLEPPDOWN>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Here is the patch.

Sorry, at least most of the patch was there. Here is the rest:

diff -r -u -N -b linux-2.4.5.ac16/include/linux/fs.h linux-2.4.5.ac16.patched/include/linux/fs.h
--- linux-2.4.5.ac16/include/linux/fs.h Tue Jun 19 15:12:50 2001
+++ linux-2.4.5.ac16.patched/include/linux/fs.h Tue Jun 19 18:28:47 2001
@@ -1336,6 +1336,7 @@
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
 
 extern ssize_t generic_read_dir(struct file *, char *, size_t, loff_t *);
+extern loff_t generic_file_llseek(struct file *, loff_t, int);
 extern int generic_file_open(struct inode *, struct file *);
 
 extern struct file_operations generic_ro_fops;
diff -r -u -N -b linux-2.4.5.ac16/kernel/ksyms.c linux-2.4.5.ac16.patched/kernel/ksyms.c
--- linux-2.4.5.ac16/kernel/ksyms.c     Tue Jun 19 15:13:08 2001
+++ linux-2.4.5.ac16.patched/kernel/ksyms.c     Wed Jun 20 01:41:21 2001
@@ -245,6 +245,7 @@
 EXPORT_SYMBOL(vfs_unlink);
 EXPORT_SYMBOL(vfs_rename);
 EXPORT_SYMBOL(vfs_statfs);
+EXPORT_SYMBOL(generic_file_llseek);
 EXPORT_SYMBOL(generic_read_dir);
 EXPORT_SYMBOL(__pollwait);
 EXPORT_SYMBOL(poll_freewait);


