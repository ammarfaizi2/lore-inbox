Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbSLIXgm>; Mon, 9 Dec 2002 18:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbSLIXgm>; Mon, 9 Dec 2002 18:36:42 -0500
Received: from hermes.domdv.de ([193.102.202.1]:49166 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S266330AbSLIXgl>;
	Mon, 9 Dec 2002 18:36:41 -0500
Message-ID: <3DF52C26.2020708@domdv.de>
Date: Tue, 10 Dec 2002 00:49:58 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Kim <john@larvalstage.com>
CC: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] 2.4.20 compile fix for drivers/scsi/t128.c
References: <Pine.LNX.4.50L0.0212091638400.24225-100000@quinn.larvalstage.com>
In-Reply-To: <Pine.LNX.4.50L0.0212091638400.24225-100000@quinn.larvalstage.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did already submit this, it's in the AC tree and via Alan in Marcelo's 
BK tree:

http://linux.bkbits.net:8080/linux-2.4/diffs/drivers/scsi/t128.c@1.4?nav=index.html|ChangeSet@-7d|cset@1.757.28.37

John Kim wrote:
> Patch below fixes following compile breakage:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=athlon    -nostdinc -iwithprefix
> include -DKBUILD_BASENAME=t128  -c -o t128.o t128.c
> t128.c:148: signatures causes a section type conflict
> NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
> NCR5380.c:402: warning: `NCR5380_print' defined but not used
> make[3]: *** [t128.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.4.20/drivers/scsi'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.4.20/drivers/scsi'
> make[1]: *** [_subdir_scsi] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.20/drivers'
> make: *** [_dir_drivers] Error 2
> 
> 
> 
> diff -Naur linux-2.4.20/drivers/scsi/t128.c linux-2.4.20-new/drivers/scsi/t128.c
> --- linux-2.4.20/drivers/scsi/t128.c	2001-12-21 12:41:55.000000000 -0500
> +++ linux-2.4.20-new/drivers/scsi/t128.c	2002-12-09 12:52:21.000000000 -0500
> @@ -142,7 +142,7 @@
>  
>  #define NO_BASES (sizeof (bases) / sizeof (struct base))
>  
> -static const struct signature {
> +static struct signature {
>  	const char *string;
>  	int offset;
>  } signatures[] __initdata = {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

