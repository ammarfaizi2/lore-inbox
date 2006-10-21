Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993074AbWJUPHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993074AbWJUPHL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 11:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993091AbWJUPHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 11:07:11 -0400
Received: from 85-210-250-36.dsl.pipex.com ([85.210.250.36]:25310 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S2993074AbWJUPHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 11:07:09 -0400
Date: Sat, 21 Oct 2006 16:05:57 +0100
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux390@de.ibm.com, linux-390@vm.marist.edu,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] s390 move to using ktermios structure
Message-ID: <d55a80b249f79f802547e982a1343b8f@pinky>
References: <1161193659.9363.117.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <1161193659.9363.117.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seem to be getting compile failures due to the switch to ktermios
in the serial subsystem.  Need this to get S390 to build on
latest -mm's.

Not sure if this is all thats needed?  Perhaps someone who groks
this architecture better can confirm.

-apw
=== 8< ===
s390: move to using ktermios structure

The new serial framwork uses the ktermios structure, switch s390 to
use that.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 6f43e04..1421087 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -60,7 +60,7 @@ static unsigned short int sclp_tty_chars
 
 struct tty_driver *sclp_tty_driver;
 
-extern struct termios  tty_std_termios;
+extern struct ktermios  tty_std_termios;
 
 static struct sclp_ioctls sclp_ioctls;
 static struct sclp_ioctls sclp_ioctls_init =
