Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278179AbRJLWUK>; Fri, 12 Oct 2001 18:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278182AbRJLWUB>; Fri, 12 Oct 2001 18:20:01 -0400
Received: from ausxc07.us.dell.com ([143.166.99.215]:38808 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S278179AbRJLWTx>; Fri, 12 Oct 2001 18:19:53 -0400
Message-ID: <71714C04806CD51193520090272892178BD70B@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: jgarzik@mandrakesoft.com
Cc: vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org
Subject: RE: crc32 cleanups
Date: Fri, 12 Oct 2001 17:20:18 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was pondering whether it was ok to unconditionally include the
> lib/crc32.c code, regardless of need.  I am leaning towards 
> "no," which
> implies Makefile and Config.in rules which must be updated for each
> driver that uses crc32.

OK, I'm taking this approach.

> * if ether_crc is always == ether_crc_be, then create a 
> #define instead of patching driver code

Done.

> * no need to inline ether_crc_be, stick it in lib/crc32.c also

Done.

> * using a ref-counting init_crc32 and cleanup_crc32
> (linux/lib/Makefile)
> obj-$(CONFIG_TULIP) += crc32.o
> obj-$(CONFIG_NATSEMI) += crc32.o
> obj-$(CONFIG_DMFE) += crc32.o
> obj-$(CONFIG_ANOTHERDRIVER) += crc32.o

Done.  init_crc32() needs to be called from all drivers which call crc32()
or ether_crc_le().  I think I've got them added, but will verify and report
back after the weekend.  For the curious, I've got one big patch with crc32,
GPT, efivars, and uuid stuff (separates pretty easily into multiple patches,
but for review now, it's just one).
http://domsch.com/linux/patches/big-crc32-20011012.patch

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!
