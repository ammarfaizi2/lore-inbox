Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272610AbRHaFmk>; Fri, 31 Aug 2001 01:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272609AbRHaFm3>; Fri, 31 Aug 2001 01:42:29 -0400
Received: from mail309.mail.bellsouth.net ([205.152.58.169]:50098 "EHLO
	imf09bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S272608AbRHaFmS>; Fri, 31 Aug 2001 01:42:18 -0400
Message-ID: <3B8F23C5.E03148E1@bellsouth.net>
Date: Fri, 31 Aug 2001 01:42:29 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: elenstev@mesatop.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: [Better Patch]: incorrect e2fsprog data from ver_linux script
In-Reply-To: <3B8EF06D.24BAB4AF@bellsouth.net> <200108310325.f7V3Pge00680@thor.mesatop.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good find Steven.  Now I see the difference between
1.22 and 1.23.  This patch is better than the last patch.
Linus and Alan, please use this instead.
1.22 was "header then usage", while 
1.23 is "usage then header".

home1:# ./tune2fs 2>&1  |grep tune2fs
tune2fs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
Usage: ./tune2fs [-c max-mounts-count] [-e errors-behavior] [-g group]

home1:# /sbin/tune2fs 2>&1  |grep tune2fs
Usage: /sbin/tune2fs [-c max-mounts-count] [-e errors-behavior] [-g group]
tune2fs 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09

home1:# ./tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk 'NR==1 {print "e2fsprogs             ", $2}'
e2fsprogs              1.22
home1:# /sbin/tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk 'NR==1 {print "e2fsprogs             ", $2}'
e2fsprogs              1.23
--------PATCH--------------
--- linux/scripts/ver_linux.orig      Fri Aug 31 01:15:22 2001
+++ linux/scripts/ver_linux   Fri Aug 31 01:17:47 2001
@@ -26,7 +26,7 @@

 insmod -V  2>&1 | awk 'NR==1 {print "modutils              ",$NF}'

-tune2fs 2>&1 | grep tune2fs | sed 's/,//' |  awk \
+tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'

 reiserfsck 2>&1 | grep reiserfsprogs | awk \
----------END PATCH-------

Steven Cole wrote:
>
> So, this patch breaks the ver_linux script for 1.22, and 1.21 (I checked
> this too).  If someone wants to fix this right, please jump in.
> 
> Steven
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net

