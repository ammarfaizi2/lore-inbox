Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSEBTOK>; Thu, 2 May 2002 15:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315368AbSEBTOJ>; Thu, 2 May 2002 15:14:09 -0400
Received: from [195.63.194.11] ([195.63.194.11]:63503 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315370AbSEBTOH>; Thu, 2 May 2002 15:14:07 -0400
Message-ID: <3CD1814B.9000503@evision-ventures.com>
Date: Thu, 02 May 2002 20:11:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12: hpt34x.c:259: too few arguments to function `ide_dmaproc'
In-Reply-To: <Pine.NEB.4.44.0205022054460.21679-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Adrian Bunk napisa?:
> Just FYI:
> 
> The ide_dmaproc changes in 2.5.12 broke the compilation of hpt34x.c (I
> tried 2.5.12-dj1 but this shouldn't make a difference):
> 
> <--  snip  -->
> 
> ...
> gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.12/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
> -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
> /usr/lib/gcc-lib/i386-linux/2.95.4
> /include -DKBUILD_BASENAME=hpt34x  -c -o hpt34x.o hpt34x.c
> hpt34x.c: In function `config_drive_xfer_rate':
> hpt34x.c:259: too few arguments to function `ide_dmaproc'
> hpt34x.c:281: too few arguments to function `ide_dmaproc'
> hpt34x.c:304: structure has no member named `dmaproc'
> hpt34x.c:305: warning: control reaches end of non-void function
> hpt34x.c: In function `hpt34x_dmaproc':
> hpt34x.c:350: too few arguments to function `ide_dmaproc'
> hpt34x.c: In function `ide_init_hpt34x':
> hpt34x.c:426: structure has no member named `dmaproc'
> make[3]: *** [hpt34x.o] Error 1
> make[3]: Leaving directory

Just adding a trailing struct request *rq parameter
to hpt34x_dmaproc() and passing it there to ide_dmaproc
as well as changing dmaproc to udma at line 426 will do.


