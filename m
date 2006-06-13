Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWFMPRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWFMPRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 11:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWFMPRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 11:17:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47495 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932124AbWFMPRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 11:17:18 -0400
Subject: Re: [patch] s390: missing ifdef in bitops.h
From: David Woodhouse <dwmw2@infradead.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <20060613120916.GA9405@osiris.boeblingen.de.ibm.com>
References: <20060613120916.GA9405@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:17:07 +0100
Message-Id: <1150211828.2844.20.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 14:09 +0200, Heiko Carstens wrote:
> Add missing #ifdef __KERNEL__ to asm-s390/bitops.h

But asm/bitops.h isn't suitable for userspace _anyway_, is it?
We should be able to drop all instances of __KERNEL__ from it.

Which means that asm-s390/posix_types.h probably ought never to be
trying to include asm/bitops.h in the !__KERNEL__ case... we never had
libc5 on S390 anyway, did we?

Martin, is it OK for me to add this to the hdrcleanup-2.6.git tree?

diff --git a/include/asm-s390/posix_types.h b/include/asm-s390/posix_types.h
index 61788de..18344dc 100644
--- a/include/asm-s390/posix_types.h
+++ b/include/asm-s390/posix_types.h
@@ -76,7 +76,7 @@ #endif                       /* !defined
 } __kernel_fsid_t;
 
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
+#ifdef __KERNEL__
 
 #ifndef _S390_BITOPS_H
 #include <asm/bitops.h>
@@ -94,6 +94,6 @@ #define __FD_ISSET(fd,fdsetp)  test_bit(
 #undef  __FD_ZERO
 #define __FD_ZERO(fdsetp) (memset ((fdsetp), 0, sizeof(*(fd_set *)(fdsetp))))
 
-#endif     /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)*/
+#endif     /* __KERNEL__ */
 
 #endif


 

-- 
dwmw2

