Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274426AbRJTUmP>; Sat, 20 Oct 2001 16:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274434AbRJTUmF>; Sat, 20 Oct 2001 16:42:05 -0400
Received: from fep3-orange.clear.net.nz ([203.97.32.3]:32943 "EHLO
	fep3-orange.clear.net.nz") by vger.kernel.org with ESMTP
	id <S274426AbRJTUl4>; Sat, 20 Oct 2001 16:41:56 -0400
Date: Sun, 21 Oct 2001 09:43:36 +1300 (NZDT)
From: John Duthie <spudgun@clear.net.nz>
X-X-Sender: <spudgun@potato.wibble.prv>
To: Anders Eriksson <aer-list@mailandnews.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IEEE1284_PH_DIR_UNKNOWN undeclared in 2.4.12
In-Reply-To: <200110150555.f9F5tt725407@milou.dyndns.org>
Message-ID: <Pine.LNX.4.33.0110210933060.289-100000@potato.wibble.prv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001, Anders Eriksson wrote:

I had the same thing
disabled ieee in the printer config , and it worked
had every lp option built in ...

the 2.4.12 patch conntains this
- ----------------->8
+++ linux/drivers/parport/ieee1284_ops.c        Wed Oct
10 23:19:30 2001
@@ -359,6 +359,10 @@
                DPRINTK (KERN_DEBUG "%s: ECP direction: reverse\n",
                         port->name);
                port->ieee1284.phase = IEEE1284_PH_REV_IDLE;
+       } else {
+               DPRINTK (KERN_DEBUG "%s: ECP direction: failed to
reverse\n",
+                        port->name);
+               port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
        }

        return retval;
@@ -386,7 +390,13 @@
                DPRINTK (KERN_DEBUG "%s: ECP direction: forward\n",
                         port->name);
                port->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
+       } else {
+               DPRINTK (KERN_DEBUG
+                        "%s: ECP direction: failed to switch forward\n",
+                        port->name);
+               port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
        }
+
- -------------------------->8

Did Linus forget to add all of a patch again ?


my guess is in
include/linux/parport.h
this need a line added

/* IEEE1284 phases */
enum ieee1284_phase {
        IEEE1284_PH_FWD_DATA,
        IEEE1284_PH_FWD_IDLE,
        IEEE1284_PH_TERMINATE,
        IEEE1284_PH_NEGOTIATION,
        IEEE1284_PH_HBUSY_DNA,

-> Date: Mon, 15 Oct 2001 07:55:55 +0200
-> From: Anders Eriksson <aer-list@mailandnews.com>
-> To: linux-kernel@vger.kernel.org
-> Subject: IEEE1284_PH_DIR_UNKNOWN undeclared in 2.4.12
->
->
-> Just downloaded 2.4.12, and the compile barfs as follows, any
-> suggestions? The thing is nowhere in the source.
->
-> /Anders
->
->
-> gcc -D__KERNEL__ -I/home/ander/tmp/linux-milou-12/include -Wall
-> -Wstrict-prototy
-> pes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-> -fno-common -pi
-> pe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS
-> -include /hom
-> e/ander/tmp/linux-milou-12/include/linux/modversions.h   -c -o
-> ieee1284_ops.o ie
-> ee1284_ops.c
-> ieee1284_ops.c: In function `ecp_forward_to_reverse':
-> ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use
-> in this func
-> tion)
-> ieee1284_ops.c:365: (Each undeclared identifier is reported only once
-> ieee1284_ops.c:365: for each function it appears in.)
-> ieee1284_ops.c: In function `ecp_reverse_to_forward':
-> ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use
-> in this func
-> tion)
-> make[2]: *** [ieee1284_ops.o] Error 1
-> make[2]: Leaving directory `/home/ander/tmp/linux-milou-12/drivers/par
-> port'
->
->
-> $ find . -type f | xargs grep IEEE1284_PH_DIR_UNKNOW
-> N
-> ./drivers/parport/ieee1284_ops.c:               port->ieee1284.phase
-> = IEEE1284_PH_DIR_UNK
-> NOWN;
-> ./drivers/parport/ieee1284_ops.c:               port->ieee1284.phase
-> = IEEE1284_PH_DIR_UNK
-> NOWN;
->
->
-> -
-> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
-> the body of a message to majordomo@vger.kernel.org
-> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-> Please read the FAQ at  http://www.tux.org/lkml/
->

-- 
John Duthie
E-Mail:   <spudgun@mail.earthlight.co.nz>
Phone:    +64  9 825 0325
Cell:     +64 25 273 4832
Web:      http://www.earthlight.co.nz/users/spudgun/
 When you choke a smurf, what color does it turn?
(Hi! I'm a .signature virus! Copy me into your ~/.signature, please!)


