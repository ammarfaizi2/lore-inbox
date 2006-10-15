Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWJORwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWJORwh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 13:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWJORwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 13:52:37 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:48080 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161074AbWJORwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 13:52:36 -0400
Date: Sun, 15 Oct 2006 19:38:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew James Wade <andrew.j.wade@gmail.com>
cc: Josef Jeff Sipek <jsipek@cs.sunysb.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, penberg@cs.helsinki.fi,
       ezk@cs.sunysb.edu, mhalcrow@us.ibm.com
Subject: [PATCH] Re: [PATCH 1 of 2] Stackfs: Introduce stackfs_copy_{attr,inode}_*
In-Reply-To: <200610131506.38609.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Message-ID: <Pine.LNX.4.61.0610151748310.7672@yvahk01.tjqt.qr>
References: <ceb6edcac7047367ca16.1160738329@thor.fsl.cs.sunysb.edu>
 <200610131506.38609.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Friday 13 October 2006 07:18, Josef Jeff Sipek wrote:
>> +static inline void stackfs_copy_inode_size(struct inode *dst,
>> +					   const struct inode *src)
>> +{
>> +	i_size_write(dst, i_size_read((struct inode *)src));
>
>Instead of casting, I'd change the signature of i_size_read.


Change the signature of i_size_read(), IMINOR() and IMAJOR() because 
they, or the functions they call, will never modify the argument.
Compile-tested on x86 allmodconfig.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>


Index: linux-2.6.19-rc1/include/linux/fs.h
===================================================================
--- linux-2.6.19-rc1.orig/include/linux/fs.h
+++ linux-2.6.19-rc1/include/linux/fs.h
@@ -633,7 +633,7 @@ enum inode_i_mutex_lock_class
  * cmpxchg8b without the need of the lock prefix). For SMP compiles
  * and 64bit archs it makes no difference if preempt is enabled or not.
  */
-static inline loff_t i_size_read(struct inode *inode)
+static inline loff_t i_size_read(const struct inode *inode)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 	loff_t i_size;
@@ -672,12 +672,12 @@ static inline void i_size_write(struct i
 #endif
 }
 
-static inline unsigned iminor(struct inode *inode)
+static inline unsigned iminor(const struct inode *inode)
 {
 	return MINOR(inode->i_rdev);
 }
 
-static inline unsigned imajor(struct inode *inode)
+static inline unsigned imajor(const struct inode *inode)
 {
 	return MAJOR(inode->i_rdev);
 }
#<EOF>


	-`J'
-- 
