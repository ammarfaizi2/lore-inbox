Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284186AbSAGRs6>; Mon, 7 Jan 2002 12:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284191AbSAGRss>; Mon, 7 Jan 2002 12:48:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42249 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284186AbSAGRsq>; Mon, 7 Jan 2002 12:48:46 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: lseek() on an iso9660 file
Date: 7 Jan 2002 09:48:35 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1cn1j$sev$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.3.95.1020107091316.18091A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1020107091316.18091A-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> Using Linux 2.4.1 I discovered a problem with lseek on CDROM files
> (iso9660). I just installed 2.4.17 and found the same problem.
> 
> The problem:
> 
> (1) A portion of the file, existing on a CDROM,  is read and its the
>     contents are written to an output file on writable media.
> 
> (2) The current input file-position is obtained using
>     pos = lseek(fd, 0, SEEK_CUR); The value returned is exactly
>     the expected value.
> 
> (3) The rest of the CDROM file is read and written to the output file.
> 
> (4) The file-position of the CDROM file is then set back to the saved
>     position using lseek(fd, pos, SEEK_SET); The value returned is
>     exactly the expected value.
> 
> (5) The CDROM file is then read and its contents are observed to be
>     scrambled in some strange manner in which word-length groups of
>     bytes from near the end of the file are interleaved with the
>     correct bytes. Basically, the file ends up being about twice
>     as long as the original, with every-other two-byte interval
>     being filled with bytes from near the end of the file.
> 

a) How long is the file?
b) What is the offset?
c) What particular iso9660 options (RockRidge, Joliet, zisofs...)
   does your disk use?
d) Mount options?

This seems to be a rather serious bug, so I'd like to get to the
bottom with it.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
