Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314358AbSD0SiD>; Sat, 27 Apr 2002 14:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314361AbSD0SiC>; Sat, 27 Apr 2002 14:38:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:274 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314358AbSD0SiC>; Sat, 27 Apr 2002 14:38:02 -0400
Subject: Re: [PATCH] Various suser() -> capable() chang
To: hoho@binbash.net (Colin Slater)
Date: Sat, 27 Apr 2002 19:56:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, davej@suse.de
In-Reply-To: <1019863708.8034.3092.camel@neptune> from "Colin Slater" at Apr 26, 2002 07:28:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E171XNI-0000Ji-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	case IDAPASSTHRU:
> -		if (!suser()) return -EPERM;
> +		if (!capable(CAP_SYS_ADMIN)) return -EPERM;

The cpqarray ones should be CAP_SYS_RAWIO

> diff -Nru a/drivers/scsi/cpqfcTSinit.c b/drivers/scsi/cpqfcTSinit.c
> --- a/drivers/scsi/cpqfcTSinit.c	Fri Apr 26 18:34:23 2002
> +++ b/drivers/scsi/cpqfcTSinit.c	Fri Apr 26 18:34:23 2002
> @@ -532,7 +532,7 @@
> =20
>  	// must be super user to send stuff directly to the
>  	// controller and/or physical drives...
> -	if( !suser() )
> +	if( !capable(CAP_SYS_ADMIN) )

Also RAWIO


Basically - stuff giving raw hardware access sohuld be CAP_SYS_RAWIO, the
others CAP_SYS_ADMIN is a good general case, but as you change then check
its appropriate
