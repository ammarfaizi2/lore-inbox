Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277585AbRJLIez>; Fri, 12 Oct 2001 04:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277588AbRJLIes>; Fri, 12 Oct 2001 04:34:48 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:56328 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S277585AbRJLIed>;
	Fri, 12 Oct 2001 04:34:33 -0400
Date: Fri, 12 Oct 2001 10:34:33 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13-pre1: sonypi.c compile error
Message-ID: <20011012103433.A2137@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <3BC62542.CDEAAE@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3BC62542.CDEAAE@eyal.emu.id.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 09:03:30AM +1000, Eyal Lebedinsky wrote:

> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h  
> -DEXPORT_SYMTAB -c sonypi.c
> sonypi.c: In function `sonypi_init_module':
> sonypi.c:702: `is_sony_vaio_laptop_R7462d5e4' undeclared (first use in
> this function)

Just add a
	extern int is_sony_vaio_laptop; /* set in DMI table parse routines */
line somewhere at the beginning of the file drivers/char/sonypi.c

Looks like the driver sync between Linus and Alan was incomplete
this time (Linus took the sonypi driver changes but not the dmi_scan
routine changes).

I won't submit a patch to Linus for now, I'm pretty sure that
Alan will take care of this for -pre2.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
