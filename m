Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSFEH52>; Wed, 5 Jun 2002 03:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSFEH51>; Wed, 5 Jun 2002 03:57:27 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:19935 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S313558AbSFEH50>; Wed, 5 Jun 2002 03:57:26 -0400
Date: Wed, 5 Jun 2002 09:52:56 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: kladit@t-online.de (Klaus Dittrich)
Cc: linux-kernel@vger.kernel.org
Subject: Re: xosview
Message-Id: <20020605095256.0a12ed29.kristian.peters@korseby.net>
In-Reply-To: <200206050607.g556721s005527@df1tlpc.local.here>
X-Mailer: Sylpheed version 0.7.1claws7 (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.19-pre10
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kladit@t-online.de (Klaus Dittrich) wrote:
> Since 2.4.18p8 xosview does not work anymore.

That's a known problem. xosview tries to access /proc/stat that has a wierd format and a buffer goes beyond 1024 in xosview. I was also effected on this problem. It's been fixed in the next version of 2.4.19 (probably -rc1). In the meantime you can apply this patch:

diff -ur linux-2.4.19-pre9.org/fs/proc/proc_misc.c linux-2.4.19-pre9/fs/proc/proc_misc.c
--- linux-2.4.19-pre9.org/fs/proc/proc_misc.c	Wed May 29 01:26:17 2002
+++ linux-2.4.19-pre9/fs/proc/proc_misc.c	Thu May 30 03:09:07 2002
@@ -322,7 +322,7 @@
 #if !defined(CONFIG_ARCH_S390)
 	for (i = 0 ; i < NR_IRQS ; i++)
 		proc_sprintf(page, &off, &len,
-			     " %u", kstat_irqs(i) + 1000000000);
+			     " %u", kstat_irqs(i));
 #endif
 
 	proc_sprintf(page, &off, &len, "\ndisk_io: ");


*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
