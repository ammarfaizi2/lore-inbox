Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276370AbRJGOLk>; Sun, 7 Oct 2001 10:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276377AbRJGOLa>; Sun, 7 Oct 2001 10:11:30 -0400
Received: from ns.caldera.de ([212.34.180.1]:61853 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S276370AbRJGOLR>;
	Sun, 7 Oct 2001 10:11:17 -0400
Date: Sun, 7 Oct 2001 16:11:04 +0200
Message-Id: <200110071411.f97EB4o26001@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: <pcg@goof.com ( Marc A. Lehmann )>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zisofs doesn't compile in 2.4.10-ac7
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20011007154324.A4991@schmorp.de>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011007154324.A4991@schmorp.de> you wrote:
> In file included from uncompress.c:21:
> /localvol/usr/src/linux-2.4/include/linux/zlib_fs.h:34:19: zconf.h: No such file or directory
>
> but the only zconf.h file is in /opt/include (and shouldn't be used anyways).
>
> (just another datapoint on why linux should be tested on distributions
> that do NOT put everything into /usr/include ;)

It should be tested with the following patch instead:

--- linux/Makefile~	Wed Oct  3 15:31:07 2001
+++ linux/Makefile	Sun Oct  7 17:04:39 2001
@@ -94,7 +94,8 @@
 # standard CFLAGS
 #
 
-CPPFLAGS := -D__KERNEL__ -I$(HPATH)
+GCCINC := $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/\1include/gp')
+CPPFLAGS := -D__KERNEL__ -nostdinc -I$(HPATH) -I$(GCCINC)
 
 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
 	  -fomit-frame-pointer -fno-strict-aliasing -fno-common


