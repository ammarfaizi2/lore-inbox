Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSEDKPp>; Sat, 4 May 2002 06:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312316AbSEDKPo>; Sat, 4 May 2002 06:15:44 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7858 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312254AbSEDKPo>;
	Sat, 4 May 2002 06:15:44 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 4 May 2002 12:15:18 +0200 (MEST)
Message-Id: <UTC200205041015.g44AFIV16086.aeb@smtp.cwi.nl>
To: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org,
        tomita@cinet.co.jp
Subject: Re: [PATCH] 2.5.13 IDE PIO mode Fix
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I found this bug in 2.5.10 first. And caused ext2 FS corruption.
    We are porting Linux to PC-9801 architecture (made by NEC Japan).
    It has PIO ONLY IDE I/F. So please check PIO mode too.
    # Our porting status - 2.2.x/2.4.x done and updating. 2.5.x partial.

    diff -urN linux-2.5.10/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
    --- linux-2.5.10/drivers/ide/ide-taskfile.c    Wed Apr 24 16:15:19 2002
    +++ linux/drivers/ide/ide-taskfile.c  Fri Apr 26 15:44:42 2002
    @@ -202,7 +202,7 @@
                            ata_write_slow(drive, buffer, wcount);
                    else
     #endif
    -                       ata_write_16(drive, buffer, wcount<<1);
    +                       ata_write_16(drive, buffer, wcount);
            }
     }

Excellent!
It was introduced in 2.5.9 and still exists in 2.5.13,
and caused superblock corruption for me. This fixes it.

Andries
