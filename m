Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbTBHLP2>; Sat, 8 Feb 2003 06:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbTBHLP2>; Sat, 8 Feb 2003 06:15:28 -0500
Received: from [81.2.122.30] ([81.2.122.30]:3332 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266983AbTBHLP1>;
	Sat, 8 Feb 2003 06:15:27 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302081125.h18BPYbn000265@darkstar.example.net>
Subject: Re: [PATCH] 2.5.59 : sound/oss/vidc.c (CORRECTED)
To: apodtele@mccammon.ucsd.edu (Alexei Podtelezhnikov)
Date: Sat, 8 Feb 2003 11:25:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
In-Reply-To: <Pine.LNX.4.44.0302071641420.18936-100000@chemcca61.ucsd.edu> from "Alexei Podtelezhnikov" at Feb 07, 2003 04:45:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> John Bradford (john@grabjohn.com) wrote:
> 
> > 36 < hwrate < 3332
>        ^^^^^^  should be 'newsize'
> 
> Yeap, and the following couple of lines:
> 
>                 /* 36 < newsize 3332; rounding it off 
>                  * to the nearest power of 2, no less than 256 
>                  */
>                 for (new2size = 384; new2size < newsize; new2size <<= 1);
>                 new2size -= new2size / 3;
> 
> safely replace the whole following block:
> 
>                 if (newsize < 208)
>                         newsize = 208;
>                 if (newsize > 4096)
>                         newsize = 4096;
>                 for (new2size = 128; new2size < newsize; new2size <<= 1);
>                         if (new2size - newsize > newsize - (new2size >> 1))
>                                 new2size >>= 1;
>                 if (new2size > 4096) {
>                         printk(KERN_ERR "VIDC: error: dma buffer (%d) %d > 4K\n",
>                                 newsize, new2size);
>                         new2size = 4096;
>                 }
> 
> Would somebody test this?

The only change I'd make would be:

-                 /* 36 < newsize 3332; rounding it off 
+                 /* 36 <= newsize <= 3332; rounding it off 

John
