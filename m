Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292908AbSBZBaP>; Mon, 25 Feb 2002 20:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSBZB2A>; Mon, 25 Feb 2002 20:28:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21253 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292604AbSBZB1s>; Mon, 25 Feb 2002 20:27:48 -0500
Message-Id: <200202260127.RAA01938@cesium.transmeta.com>
From: "H. Peter Anvin" <hpa@zytor.com>
To: quinlan@transmeta.com
Subject: Re: [PATCH] cramfs big-endian kernel patch
Newsgroups: linux.dev.kernel
In-Reply-To: <15482.53400.786310.950430@sodium.transmeta.com>
Organization: Transmeta Corporation, Santa Clara CA
Date: Mon, 25 Feb 2002 17:25:30 -0800
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <15482.53400.786310.950430@sodium.transmeta.com> of
linux.dev.kernel, you write:
> 
> +Currently, cramfs can be read only by kernels with PAGE_CACHE_SIZE ==
> +4096.  This is a bug, but it hasn't been decided what the best fix is.
> +For the moment if you have larger pages you can just change the
> +#define in mkcramfs.c, so long as you don't mind the filesystem
> +becoming unreadable to future kernels.
>  

For the binary format to be compatible, there is only one solution: if
PAGE_CACHE_SIZE > 4096, you decompress more than one cramfs chunk into
the same page.

If the binary format can change, then you could implement the same
solution used in zisofs.

FWIW, currently on Linux I believe:

	4096 <= PAGE_CACHE_SIZE <= 32768

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
