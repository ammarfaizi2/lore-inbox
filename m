Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWDMMeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWDMMeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 08:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWDMMeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 08:34:03 -0400
Received: from wproxy.gmail.com ([64.233.184.235]:56288 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964903AbWDMMeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 08:34:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bFS1lCrOlkhuShMA06GTw7MSK/dq+5cCA2VyUvLRdQSX5cVV6qeCHxIitB+x8ELbkTWEh0T9cImCLpWbtn9gdmfJF7ipzr8rdA0+YkC2v526ad1tJLnGWEZihjTORsMYUi1HyVyeQ/KCFILTN3vOmNsaRwKmL5toQf8KvX+k2ME=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][resend] Fix potential NULL pointer deref in gen_init_cpio
Date: Thu, 13 Apr 2006 14:34:36 +0200
User-Agent: KMail/1.9.1
Cc: jgarzik@pobox.com, jeff@garzik.org, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604131434.36405.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This patch was already send before on Mar 18, this is a resend)

Fix potential NULL pointer deref in gen_init_cpio.c spotted by
coverity checker.
This fixes coverity bug #86

Without this patch we risk dereferencing a NULL `type' in the 
"if ('\n' == *type) {" line.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 usr/gen_init_cpio.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc1-git7-orig/usr/gen_init_cpio.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc1-git7/usr/gen_init_cpio.c	2006-04-13 14:27:51.000000000 +0200
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


