Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287657AbSASWmU>; Sat, 19 Jan 2002 17:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287699AbSASWmL>; Sat, 19 Jan 2002 17:42:11 -0500
Received: from CPE00606767ED59.cpe.net.cable.rogers.com ([24.112.39.102]:31238
	"EHLO cpe00606767ed59.cpe.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S287657AbSASWmD>; Sat, 19 Jan 2002 17:42:03 -0500
Date: Sat, 19 Jan 2002 17:41:43 -0500 (EST)
From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Reply-To: hugh@mimosa.com
To: Rob Radez <rob@osinvestor.com>
cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] Andre's IDE Patch (1/7)
In-Reply-To: <Pine.LNX.4.33.0201191457490.14950-100000@pita.lan>
Message-ID: <Pine.LNX.4.44.0201191731320.12447-100000@redshift.mimosa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: Rob Radez <rob@osinvestor.com>

| This is the first of seven patches against 2.4.18-pre4, beginning the breakup
| of Andre Hedrick's IDE patch into smaller chunks.

I'm glad you are doing this, although I am ignorant of the politics.

I have an HPT366 that I have never used due to fear of drivers not in
the mainstream.

| diff -ruN linux-2.4.18-pre3/drivers/ide/ide-cd.h linux-2.4.18-pre3-ide-rr/drivers/ide/ide-cd.h
| --- linux-2.4.18-pre3/drivers/ide/ide-cd.h	Thu Nov 22 14:46:58 2001
| +++ linux-2.4.18-pre3-ide-rr/drivers/ide/ide-cd.h	Mon Jan 14 18:29:06 2002
| @@ -38,7 +38,9 @@
|  /************************************************************************/
| 
|  #define SECTOR_BITS 		9
| +#ifndef SECTOR_SIZE
|  #define SECTOR_SIZE		(1 << SECTOR_BITS)
| +#endif
|  #define SECTORS_PER_FRAME	(CD_FRAMESIZE >> SECTOR_BITS)
|  #define SECTOR_BUFFER_SIZE	(CD_FRAMESIZE * 32)
|  #define SECTORS_BUFFER		(SECTOR_BUFFER_SIZE >> SECTOR_BITS)

Being a chicken, I wonder if this would be better as:

   #define SECTOR_BITS 		9
  +#ifdef SECTOR_SIZE
  +#if SECTOR_SIZE != (1 << SECTOR_BITS)
  +#error SECTOR_SIZE != (1 << SECTOR_BITS)
  +#else
   #define SECTOR_SIZE		(1 << SECTOR_BITS)
  +#endif
   #define SECTORS_PER_FRAME	(CD_FRAMESIZE >> SECTOR_BITS)
   #define SECTOR_BUFFER_SIZE	(CD_FRAMESIZE * 32)
   #define SECTORS_BUFFER		(SECTOR_BUFFER_SIZE >> SECTOR_BITS)

Hugh Redelmeier
hugh@mimosa.com  voice: +1 416 482-8253

