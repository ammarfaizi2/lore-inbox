Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317444AbSFIINA>; Sun, 9 Jun 2002 04:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317572AbSFIIM7>; Sun, 9 Jun 2002 04:12:59 -0400
Received: from emory.viawest.net ([216.87.64.6]:9657 "EHLO emory.viawest.net")
	by vger.kernel.org with ESMTP id <S317444AbSFIIM4>;
	Sun, 9 Jun 2002 04:12:56 -0400
Date: Sun, 9 Jun 2002 01:12:23 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21 -- sound/core/misc.c:93: `file' undeclared in function `snd_printd'
Message-ID: <20020609081223.GA2861@wizard.com>
In-Reply-To: <1023607742.5775.7.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 1:06am  up  4:27,  2 users,  load average: 0.45, 0.12, 0.04
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 12:29:02AM -0700, Miles Lane wrote:
>   gcc -Wp,-MD,.misc.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=misc   -c -o misc.o misc.c
> misc.c: In function `snd_printd':
> misc.c:93: `file' undeclared (first use in this function)
> misc.c:93: (Each undeclared identifier is reported only once
> misc.c:93: for each function it appears in.)
> misc.c:93: `line' undeclared (first use in this function)
> make[2]: *** [misc.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/sound/core'
> 

        Known problem since 2.5.13. Jaroslav's patch below fixes this.

                                                        BL.

This patch fixes the problem:

--- misc.c	29 Apr 2002 15:57:08 -0000	1.13
+++ misc.c	3 May 2002 07:42:33 -0000	1.14
@@ -96,10 +96,10 @@
 	if (format[0] == '<' && format[1] >= '0' && format[1] <= '9' && format[2] == '>') {
 		char tmp[] = "<0>";
 		tmp[1] = format[1];
-		printk("%sALSA %s:%d: ", tmp, file, line);
+		printk("%sALSA: ", tmp);
 		format += 3;
 	} else {
-		printk(KERN_DEBUG "ALSA %s:%d: ", file, line);
+		printk(KERN_DEBUG "ALSA: ");
 	}
 	va_start(args, format);
 	vsnprintf(tmpbuf, sizeof(tmpbuf)-1, format, args);


-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

