Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVCNLbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVCNLbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 06:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVCNLa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 06:30:59 -0500
Received: from [151.97.230.9] ([151.97.230.9]:55305 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261371AbVCNLam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 06:30:42 -0500
Subject: [patch 2/2] (undescribed patch)
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 11 Mar 2005 20:29:48 +0100
Message-Id: <20050311192948.5C65F9764E@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/slip_user.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN arch/um/drivers/slip_user.c~uml-uml_net-security-fix arch/um/drivers/slip_user.c
--- linux-2.6.11/arch/um/drivers/slip_user.c~uml-uml_net-security-fix	2005-03-09 12:44:10.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/slip_user.c	2005-03-09 12:44:10.000000000 +0100
@@ -108,6 +108,9 @@ static int slip_tramp(char **argv, int f
 			err = -EINVAL;
 		}
 	}
+
+	os_close_file(fds[0]);
+
 	return(err);
 }
 
@@ -128,6 +131,7 @@ static int slip_open(void *data)
 	sfd = os_open_file(ptsname(mfd), of_rdwr(OPENFLAGS()), 0);
 	if(sfd < 0){
 		printk("Couldn't open tty for slip line, err = %d\n", -sfd);
+		os_close_file(mfd);
 		return(sfd);
 	}
 	if(set_up_tty(sfd)) return(-1);
@@ -175,7 +179,7 @@ static void slip_close(int fd, void *dat
 
 	sprintf(version_buf, "%d", UML_NET_VERSION);
 
-	err = slip_tramp(argv, -1);
+	err = slip_tramp(argv, pri->slave);
 
 	if(err != 0)
 		printk("slip_tramp failed - errno = %d\n", -err);
_
