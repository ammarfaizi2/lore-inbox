Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSFEQtg>; Wed, 5 Jun 2002 12:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315544AbSFEQtf>; Wed, 5 Jun 2002 12:49:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55820 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315529AbSFEQte>; Wed, 5 Jun 2002 12:49:34 -0400
Date: Wed, 5 Jun 2002 17:49:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@cambridge.redhat.com>
Subject: [PATCH] Allow jffs2/super.c to build
Message-ID: <20020605174928.F10293@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, lkml, dwmw2,

  Note: This is not in the MTD CVS (I'm not clear on David's handling
        of 2.5 MTD)

The following patch adds <linux/namei.h> which seems to be required to
allow fs/jffs2 to build in 2.5.20.  This fixes all the following
warnings/errors:

super.c: In function `jffs2_get_sb':
super.c:197: storage size of `nd' isn't known
super.c:245: warning: implicit declaration of function `path_lookup'
super.c:245: `LOOKUP_FOLLOW' undeclared (first use in this function)
super.c:245: (Each undeclared identifier is reported only once
super.c:245: for each function it appears in.)
super.c:254: warning: implicit declaration of function `path_release'
super.c:197: warning: unused variable `nd'

diff -ur orig/fs/jffs2/super.c linux/fs/jffs2/super.c
--- orig/fs/jffs2/super.c	Sat May 25 11:12:37 2002
+++ linux/fs/jffs2/super.c	Sat May 25 11:16:14 2002
@@ -48,6 +48,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/interrupt.h>
 #include <linux/ctype.h>
+#include <linux/namei.h>
 #include "nodelist.h"
 
 void jffs2_put_super (struct super_block *);

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

