Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbRFKCOw>; Sun, 10 Jun 2001 22:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263344AbRFKCOm>; Sun, 10 Jun 2001 22:14:42 -0400
Received: from paloma15.e0k.nbg-hannover.de ([62.159.219.15]:58086 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261385AbRFKCO2>; Sun, 10 Jun 2001 22:14:28 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrew Morton <andrewm@uow.edu.au>
Subject: Re: [patch] truncate_inode_pages
Date: Mon, 11 Jun 2001 04:22:45 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010611021437Z261385-17720+2631@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Daniel Phillips wrote:
> > 
> > This is easy, just set the list head to the page about to be truncated.
>
> Works for me.
>
> --- linux-2.4.5/mm/filemap.c    Mon May 28 13:31:49 2001
> +++ linux-akpm/mm/filemap.c     Sun Jun 10 11:29:19 2001
> @@ -235,12 +235,13 @@

[snip]

Works for me 12 times faster on my Athlon 550 and ReiserFS.

System:

Athlon 550 (old one, 0.25 µm)
MSI MS-6167 Rev 1.0B (Irongate C4)
320 MB SDRAM PC100-2-2-2
AHA-2940UW
IBM DDYS-T18350N 18 GB (UW/U160)
Kernel 2.4.5-ac12
Glibc-2.2 (SuSE 7.1)

SunWave1>cat /proc/version
Linux version 2.4.5-ac12 (root@SunWave1) (gcc version 2.95.2 19991024 
(release)) #1 Sat Jun 9 17:41:07 CEST 2001
 
SunWave1>time ./ftruncate
0.430u 54.790s 1:00.09 91.8%    0+0k 0+0io 32887pf+0w
 
With the mm/filemap.c fix:
 
SunWave1>cat /proc/version
Linux version 2.4.5-ac12 (root@SunWave1) (gcc version 2.95.2 19991024 
(release)) #1 Sun Jun 10 22:49:07 CEST 2001
 
SunWave1>time ./ftruncate
0.220u 1.670s 0:05.13 36.8%     0+0k 0+0io 32852pf+0w

Thanks,
	Dieter
