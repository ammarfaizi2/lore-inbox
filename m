Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318225AbSIBEoI>; Mon, 2 Sep 2002 00:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSIBEoI>; Mon, 2 Sep 2002 00:44:08 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:31247 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S318225AbSIBEoH>;
	Mon, 2 Sep 2002 00:44:07 -0400
Date: Mon, 2 Sep 2002 00:02:36 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@primetime>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>, Fabio Massimo Di Nitto <fabbione@fabbione.net>
Subject: [PATCH] 2.5.33 : sound/oss/v_midi.h
Message-ID: <Pine.LNX.4.33.0209012354020.29715-100000@primetime>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch looks viable for the below compile error. It 
seems that save_flags()/restore_flags() was replaced 
with spin_lock_irqsave()/spin_unlock_irqrestore() without a check to 
see if the vmidi_devc struct had a lock member. Now it does. :) Please 
review.

Regards,
Frank

--- sound/oss/v_midi.h.old	Sat Aug 10 21:41:30 2002
+++ sound/oss/v_midi.h	Sun Sep  1 23:52:50 2002
@@ -1,8 +1,11 @@
+#include <asm/spinlock.h>
+
 typedef struct vmidi_devc {
 	   int dev;
 
 	/* State variables */
  	   int opened;
+	   spinlock_t lock;
 
 	
 	/* MIDI fields */

Fabio Massimo Di Nitto wrote:
>   gcc -Wp,-MD,./.v_midi.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -nostdinc -iwithprefix include -DMODULE -include
> /usr/src/linux-2.5.33/include/linux/modversions.h
> -DKBUILD_BASENAME=v_midi   -c -o v_midi.o v_midi.c
> v_midi.c: In function `v_midi_open':
> v_midi.c:55: structure has no member named `lock'
> v_midi.c:58: structure has no member named `lock'
> v_midi.c:62: structure has no member named `lock'
> v_midi.c: In function `v_midi_close':
> v_midi.c:83: structure has no member named `lock'
> v_midi.c:87: structure has no member named `lock'
> v_midi.c: In function `attach_v_midi':
> v_midi.c:223: structure has no member named `lock'
> v_midi.c:244: structure has no member named `lock'
> make[2]: *** [v_midi.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.5.33/sound/oss'
> make[1]: *** [oss] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.33/sound'
> make: *** [sound] Error 2
> 
> Regards
> Fabio
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


