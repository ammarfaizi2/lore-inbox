Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315586AbSECHqi>; Fri, 3 May 2002 03:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315587AbSECHqh>; Fri, 3 May 2002 03:46:37 -0400
Received: from gate.perex.cz ([194.212.165.105]:63750 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S315586AbSECHqf>;
	Fri, 3 May 2002 03:46:35 -0400
Date: Fri, 3 May 2002 09:46:25 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: A Guy Called Tyketto <tyketto@wizard.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.13 sound compile error
In-Reply-To: <20020503065634.GA1984@wizard.com>
Message-ID: <Pine.LNX.4.33.0205030942550.513-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, A Guy Called Tyketto wrote:

> 
>         Got this, while running make modules:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.10/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE 
> -DMODVERSIONS -include /usr/src/linux-2.5.10/include/linux/modversions.h  
> -DKBUILD_BASENAME=isadma  -c -o isadma.o isadma.c
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.10/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE 
> -DMODVERSIONS -include /usr/src/linux-2.5.10/include/linux/modversions.h  
> -DKBUILD_BASENAME=memory  -c -o memory.o memory.c
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.10/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE 
> -DMODVERSIONS -include /usr/src/linux-2.5.10/include/linux/modversions.h  
> -DKBUILD_BASENAME=info  -c -o info.o info.c
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.10/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE 
> -DMODVERSIONS -include /usr/src/linux-2.5.10/include/linux/modversions.h  
> -DKBUILD_BASENAME=control  -c -o control.o control.c
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.10/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE 
> -DMODVERSIONS -include /usr/src/linux-2.5.10/include/linux/modversions.h  
> -DKBUILD_BASENAME=misc  -c -o misc.o misc.c
> misc.c: In function `snd_printd_Rf40b198a':
> misc.c:93: `file' undeclared (first use in this function)
> misc.c:93: (Each undeclared identifier is reported only once
> misc.c:93: for each function it appears in.)
> misc.c:93: `line' undeclared (first use in this function)
> make[2]: *** [misc.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.5.10/sound/core'
> make[1]: *** [_modsubdir_core] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.10/sound'
> make: *** [_mod_sound] Error 2

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



						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

