Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSCLXIa>; Tue, 12 Mar 2002 18:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSCLXIU>; Tue, 12 Mar 2002 18:08:20 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:52749 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287862AbSCLXIH>;
	Tue, 12 Mar 2002 18:08:07 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15502.31292.521114.650008@argo.ozlabs.ibm.com>
Date: Wed, 13 Mar 2002 08:59:24 +1100 (EST)
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, mostrows@speakeasy.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <200203112255.XAA02708@webserver.ithnet.com>
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
	<200203112255.XAA02708@webserver.ithnet.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski writes:

> gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre3/include -Wall           
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer           
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2   
> -march=i686 -DMODULE  -DKBUILD_BASENAME=pppoe  -c -o pppoe.o pppoe.c  
> pppoe.c: In function `pppoe_flush_dev':                               
> pppoe.c:282: `PPPOX_ZOMBIE' undeclared (first use in this function)   

Blast, I missed the patch to include/linux/if_pppox.h.  Here it is.
Marcelo, could you include this in the next -pre?

Paul.

diff -urN linux-2.4.19-pre3/include/linux/if_pppox.h pmac/include/linux/if_pppox.h
--- linux-2.4.19-pre3/include/linux/if_pppox.h	Sat Jul 21 09:51:58 2001
+++ pmac/include/linux/if_pppox.h	Fri Mar  8 12:39:32 2002
@@ -126,13 +126,14 @@
 extern int pppox_channel_ioctl(struct ppp_channel *pc, unsigned int cmd,
 			       unsigned long arg);
 
-/* PPPoE socket states */
+/* PPPoX socket states */
 enum {
     PPPOX_NONE		= 0,  /* initial state */
     PPPOX_CONNECTED	= 1,  /* connection established ==TCP_ESTABLISHED */
     PPPOX_BOUND		= 2,  /* bound to ppp device */
     PPPOX_RELAY		= 4,  /* forwarding is enabled */
-    PPPOX_DEAD		= 8
+    PPPOX_ZOMBIE	= 8,  /* dead, but still bound to ppp device */
+    PPPOX_DEAD		= 16  /* dead, useless, please clean me up!*/
 };
 
 extern struct ppp_channel_ops pppoe_chan_ops;
