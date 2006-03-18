Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWCRVUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWCRVUk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 16:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWCRVUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 16:20:40 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:19545 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750985AbWCRVUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 16:20:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sd4ospA0VEB7P3xK5XpTpqDl6lkrXbPXt8bhjU1GQqe0hT2c+78iKf3ub4Qz1PoYGynomsZy4mzI3meEgfxDYMAUzj/gjDA23y73Yr3nPHItiAF95O9M2qzauWHbkNCsJLScfygF2bEZvKQb58o0s3Zh+UotxiRJ7fKAvll2+1I=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix potential NULL pointer deref in gen_init_cpio
Date: Sat, 18 Mar 2006 22:21:10 +0100
User-Agent: KMail/1.9.1
Cc: jgarzik@pobox.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603182221.10347.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix potential NULL pointer deref in gen_init_cpio.c spotted by 
coverity checker.
This fixes coverity bug #86

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 usr/gen_init_cpio.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc6-mm2-orig/usr/gen_init_cpio.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc6-mm2/usr/gen_init_cpio.c	2006-03-18 22:17:18.000000000 +0100
@@ -471,6 +471,7 @@ int main (int argc, char *argv[])
 				"ERROR: incorrect format, could not locate file type line %d: '%s'\n",
 				line_nr, line);
 			ec = -1;
+			break;
 		}
 
 		if ('\n' == *type) {
@@ -506,7 +507,8 @@ int main (int argc, char *argv[])
 				line_nr, line);
 		}
 	}
-	cpio_trailer();
+	if (ec == 0)
+		cpio_trailer();
 
 	exit(ec);
 }



