Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276018AbRJPMBa>; Tue, 16 Oct 2001 08:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276050AbRJPMBU>; Tue, 16 Oct 2001 08:01:20 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:57360 "EHLO
	smtp.alcove-fr") by vger.kernel.org with ESMTP id <S276018AbRJPMBR>;
	Tue, 16 Oct 2001 08:01:17 -0400
Date: Tue, 16 Oct 2001 14:01:32 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.13-pre3: problems and patches
Message-ID: <20011016140132.E11952@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <3BCC0BFE.2DF7AE95@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3BCC0BFE.2DF7AE95@eyal.emu.id.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2001 at 08:29:18PM +1000, Eyal Lebedinsky wrote:

> To build a full pre3 one also needs other patches off the list
> 	sonypi
> 	cpqfcTSinit
> These may not be the "proper" patches but they do the job for now.
[...]
> --- linux/drivers/char/sonypi.c.orig	Fri Oct 12 20:50:58 2001
> +++ linux/drivers/char/sonypi.c	Fri Oct 12 20:51:18 2001
> @@ -43,6 +43,7 @@
>  
>  #include "sonypi.h"
>  #include <linux/sonypi.h>
> +extern int is_sony_vaio_laptop; /* set in DMI table parse routines */
>  
>  static struct sonypi_device sonypi_device;
>  static int minor = -1;


No, the proper patch for this particular problem is:

--- linux-2.4.13-pre3/include/asm-i386/system.h.orig	Tue Oct 16 13:59:11 2001
+++ linux-2.4.13-pre3/include/asm-i386/system.h	Tue Oct 16 13:59:37 2001
@@ -349,4 +349,6 @@
 void disable_hlt(void);
 void enable_hlt(void);
 
+extern int is_sony_vaio_laptop;
+
 #endif

Linus, please apply.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
