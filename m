Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276552AbRKAABP>; Wed, 31 Oct 2001 19:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRKAAA6>; Wed, 31 Oct 2001 19:00:58 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:18159 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S276429AbRJaX7W>;
	Wed, 31 Oct 2001 18:59:22 -0500
Date: Thu, 1 Nov 2001 01:29:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvlads <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Hood <jdthood@mail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Stop APM readers from responding to events
Message-Id: <20011101012900.1a2f3287.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.6.3claws18 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is just a small patch, but fills a hole.  Thanks to Thomas Hood for a
patch.

Alan, This will also apply to 2.4.13-ac5.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.4.14-pre5/arch/i386/kernel/apm.c 2.4.14-pre5-APM.1/arch/i386/kernel/apm.c
--- 2.4.14-pre5/arch/i386/kernel/apm.c	Wed Oct 24 16:12:20 2001
+++ 2.4.14-pre5-APM.1/arch/i386/kernel/apm.c	Thu Nov  1 01:09:48 2001
@@ -1471,7 +1471,7 @@
 	as = filp->private_data;
 	if (check_apm_user(as, "ioctl"))
 		return -EIO;
-	if (!as->suser)
+	if ((!as->suser) || (!as->writer))
 		return -EPERM;
 	switch (cmd) {
 	case APM_IOC_STANDBY:
