Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWJ1Sqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWJ1Sqy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWJ1Sqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:46:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:52544 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932075AbWJ1Sqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:46:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=gIiU2Uq603MaOXXIq+GOLTWunWvJR1V0zqAH6fcXqdI62df/Md3SYFwX5k5j1mERGCqtZasRoRrv2YmCgrVPeVbUHT5bITYaEk/gFiOZWe3mAxOrVspaSE/UybGXBSQYKAu7+M3ExF2ECPF62QBnKbTzsvjldUShjdVFMSd4I/w=
Date: Sun, 29 Oct 2006 03:47:12 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Krzysztof Halasa <khc@pm.waw.pl>
Subject: [PATCH] n2: fix confusing error code
Message-ID: <20061028184712.GG9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, Krzysztof Halasa <khc@pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modprobe n2 with no parameters or no such devices
will get confusing error message.

# modprobe n2
...  Kernel does not have module support

This patch replaces return code from -ENOSYS to -EINVAL.

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/net/wan/n2.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: work-fault-inject/drivers/net/wan/n2.c
===================================================================
--- work-fault-inject.orig/drivers/net/wan/n2.c
+++ work-fault-inject/drivers/net/wan/n2.c
@@ -500,7 +500,7 @@ static int __init n2_init(void)
 #ifdef MODULE
 		printk(KERN_INFO "n2: no card initialized\n");
 #endif
-		return -ENOSYS;	/* no parameters specified, abort */
+		return -EINVAL;	/* no parameters specified, abort */
 	}
 
 	printk(KERN_INFO "%s\n", version);
@@ -538,11 +538,11 @@ static int __init n2_init(void)
 			n2_run(io, irq, ram, valid[0], valid[1]);
 
 		if (*hw == '\x0')
-			return first_card ? 0 : -ENOSYS;
+			return first_card ? 0 : -EINVAL;
 	}while(*hw++ == ':');
 
 	printk(KERN_ERR "n2: invalid hardware parameters\n");
-	return first_card ? 0 : -ENOSYS;
+	return first_card ? 0 : -EINVAL;
 }
 
 
