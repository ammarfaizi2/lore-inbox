Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSEMOJz>; Mon, 13 May 2002 10:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313731AbSEMOJy>; Mon, 13 May 2002 10:09:54 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:55022 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S313767AbSEMOJx>; Mon, 13 May 2002 10:09:53 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <qwwu1pw4rkp.fsf@decibel.fi.muni.cz> 
To: Petr Konecny <pekon@informatics.muni.cz>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, hpa@zytor.com,
        Corey Minyard <cminyard@mvista.com>, paulus@samba.org
Subject: Re: zisofs data corruption in 2.4.19-pre7-ac2 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 May 2002 15:09:25 +0100
Message-ID: <11532.1021298965@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pekon@informatics.muni.cz said:
> I think I discovered an obscure bug in zisofs in 2.4.19-pre7-ac2. It
> manifests thus: 

> $ cat /mnt/cdimage/7x14.pbm 
> cat: data: Input/output error
> and the following (single) line gets logged:
> zisofs: zisofs_inflate returned 3, inode = 47342, index = 0, fpage = 0,
>   xpage = 0, avail_in = 0, avail_out = 1890, ai = 2024, ao = 4096 

OK, apply this and both ppp_deflate and zisofs should be happy. 

--- lib/zlib_inflate/inflate.c.orig	Mon May 13 14:40:26 2002
+++ lib/zlib_inflate/inflate.c	Mon May 13 14:40:46 2002
@@ -110,7 +110,7 @@
 
 #undef NEEDBYTE
 #undef NEXTBYTE
-#define NEEDBYTE {if(z->avail_in==0)goto empty;r=f;}
+#define NEEDBYTE {if(z->avail_in==0)goto empty;r=trv;}
 #define NEXTBYTE (z->avail_in--,z->total_in++,*z->next_in++)
 
 int ZEXPORT zlib_inflate(z, f)


--
dwmw2


