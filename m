Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135441AbRAJNbc>; Wed, 10 Jan 2001 08:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135510AbRAJNbW>; Wed, 10 Jan 2001 08:31:22 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:45585 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S135441AbRAJNbE>; Wed, 10 Jan 2001 08:31:04 -0500
Message-ID: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De>
Date: Wed, 10 Jan 2001 14:31:03 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac4 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

As I just found out, Linux 2.4.1-pre1 breaks several things on
my system that worked perfectly in 2.4.0-final and the entire
2.4.0-ac tree.

XFree 4.2.0 now fails to detect monitor timings and therefore
removes all modelines and bails out. The relevant diff of the
X logfile follows. Note the "nan" bits.

< (II) NV(0): Gamma: 1.80
---
> (II) NV(0): Gamma: nan
385,386c385,386
< (II) NV(0): redX: 0.625 redY: 0.340   greenX: 0.285 greenY: 0.600
< (II) NV(0): blueX: 0.150 blueY: 0.065   whiteX: 0.283 whiteY: 0.298
---
> (II) NV(0): redX: 0.625 redY: nan   greenX: 0.285 greenY: 0.600
> (II) NV(0): blueX: 0.150 blueY: nan   whiteX: 0.283 whiteY: 0.298
424c424
< (II) NV(0): Clock range:  12.00 to 350.00 MHz
---
> (II) NV(0): Clock range:    nan to    nan MHz


Moreover, with 2.4.1-pre1 the "w" command behaves in mysterious ways:

Normal output is something like:

USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU  WHAT
root     tty1     -                 2:23pm  4:41   0.03s  0.03s  -bash  

With 2.4.1-pre1 things look like:

USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU  WHAT
root     tty1     -                 2:21pm   ?     0.2147483648s  0.01s  w

I'm not sure I need it so precise :-)

Since the 2.4.1-pre1 patch is rather small, it shouldn't be too hard
to hunt down the part that causes these oddities.

Regards,
Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
