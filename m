Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292273AbSBTUCU>; Wed, 20 Feb 2002 15:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292255AbSBTUCP>; Wed, 20 Feb 2002 15:02:15 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:8642 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S292273AbSBTUAp>; Wed, 20 Feb 2002 15:00:45 -0500
Message-Id: <200202201913.MAA13519@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5 -- filesystems.c:30: In function `sys_nfsservctl': dereferencing pointer to incomplete type
Date: Wed, 20 Feb 2002 12:59:18 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <1014228802.6910.29.camel@turbulence.megapathdsl.net>
In-Reply-To: <1014228802.6910.29.camel@turbulence.megapathdsl.net>
Cc: Dave Jones <davej@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 February 2002 11:13 am, Miles Lane wrote:
> This has been reported by someone else, but the .config
> information was not included in the report.  Hopefully,
> this will help.

[Config info snipped]

>
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon
> -DKBUILD_BASENAME=filesystems  -DEXPORT_SYMTAB -c filesystems.c
> filesystems.c: In function `sys_nfsservctl':
> filesystems.c:30: dereferencing pointer to incomplete type

You could try this small patch.  The 2.5.5-pre1 version of filesystems.c
used #if defined (CONFIG_NFSD_MODULE) around most of this code, 
so perhaps this will be correct.

Steven

--- linux-2.5.5/fs/filesystems.c.orig	Wed Feb 20 07:52:36 2002
+++ linux-2.5.5/fs/filesystems.c	Wed Feb 20 12:35:42 2002
@@ -22,7 +22,7 @@
 {
 	int ret = -ENOSYS;
 	
-#if defined(CONFIG_MODULES)
+#if defined(CONFIG_NFSD_MODULE)
 	lock_kernel();
 
 	if (nfsd_linkage ||


