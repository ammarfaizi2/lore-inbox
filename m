Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266007AbUBCQyZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 11:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUBCQyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 11:54:24 -0500
Received: from [218.22.21.1] ([218.22.21.1]:51325 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S266007AbUBCQyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 11:54:17 -0500
Message-ID: <00d601c3ea74$f964bae0$4cda96d3@ccr.corp.intel.com>
From: "Yang, Chen" <chyang@clusterfs.com>
To: "Adrian Bunk" <bunk@fs.tum.de>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>, <braam@clusterfs.com>,
       <intermezzo-devel@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
References: <20040130195153.GP3004@fs.tum.de>
Subject: Re: [2.4 patch] fix a compile warning in InterMezzo file.c (fwd)
Date: Wed, 4 Feb 2004 00:22:51 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     Below patch applies to 2.4.25-pre8. Thanks.

diff -urN linux-2.4.24/fs/intermezzo.orig/dir.c
linux-2.4.24/fs/intermezzo/dir.c
--- linux-2.4.24/fs/intermezzo.orig/dir.c 2002-11-29 07:53:15.000000000
+0800
+++ linux-2.4.24/fs/intermezzo/dir.c 2004-02-03 23:58:18.000000000 +0800
@@ -1378,13 +1378,9 @@
                 return rc;
         }

-        case TCGETS:
-                EXIT;
-                return -EINVAL;
-
         default:
                 EXIT;
-                return -EINVAL;
+                return -ENOTTY;

         }
         EXIT;
diff -urN linux-2.4.24/fs/intermezzo.orig/file.c
linux-2.4.24/fs/intermezzo/file.c
--- linux-2.4.24/fs/intermezzo.orig/file.c 2002-11-29 07:53:15.000000000
+0800
+++ linux-2.4.24/fs/intermezzo/file.c 2004-02-04 00:12:50.000000000 +0800
@@ -61,7 +61,7 @@

 static int presto_open_upcall(int minor, struct dentry *de)
 {
-        int rc;
+        int rc=0;
         char *path, *buffer;
         struct presto_file_set *fset;
         int pathlen;


--
    Yang, Chen
----- Original Message ----- 
From: "Adrian Bunk" <bunk@fs.tum.de>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>; <braam@clusterfs.com>;
<intermezzo-devel@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, January 31, 2004 3:51 AM
Subject: [2.4 patch] fix a compile warning in InterMezzo file.c (fwd)


> The patch forwarded below still applies and compiles against
> 2.4.25-pre8.
>
> Please apply
> Adrian
>
>
> ----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----
>
> Date: Fri, 5 Sep 2003 11:20:50 +0200
> From: Adrian Bunk <bunk@fs.tum.de>
> To: braam@clusterfs.com,
>     intermezzo-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org,
>     trivial@rustcorp.com.au
> Subject: [2.4 patch] fix a compile warning in InterMezzo file.c
>
> I got the following warning in 2.4.23-pre3:
>
> <--  snip  -->
>
> ...
> gcc-2.95 -D__KERNEL__
> -I/home/bunk/linux/kernel-2.4/linux-2.4.23-pre3-full/inclu
> de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwit
hprefix
> include -DKBUILD_BASENAME=file  -c -o file.o file.c
> file.c: In function `presto_open_upcall':
> file.c:64: warning: `rc' might be used uninitialized in this function
> ...
>
> <--  snip  -->
>
> The patch below (already included in 2.6) fixes this warning.
>
> Please apply
> Adrian
>
> --- linux-2.4.23-pre3-full/fs/intermezzo/file.c.old 2003-09-05
09:42:49.000000000 +0200
> +++ linux-2.4.23-pre3-full/fs/intermezzo/file.c 2003-09-05
11:16:37.000000000 +0200
> @@ -61,7 +61,7 @@
>
>  static int presto_open_upcall(int minor, struct dentry *de)
>  {
> -        int rc;
> +        int rc = 0;
>          char *path, *buffer;
>          struct presto_file_set *fset;
>          int pathlen;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> ----- End forwarded message -----
>

