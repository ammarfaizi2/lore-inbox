Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135865AbRDTLPY>; Fri, 20 Apr 2001 07:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135862AbRDTLPP>; Fri, 20 Apr 2001 07:15:15 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:34323 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S135863AbRDTLPL>;
	Fri, 20 Apr 2001 07:15:11 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15072.6787.66773.470992@argo.ozlabs.ibm.com.au>
Date: Fri, 20 Apr 2001 21:16:19 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, buhr@stat.wisc.edu
Subject: Re: [PATCH] PPP update against 2.4.4-pre5
In-Reply-To: <15071.59798.751500.870953@argo.ozlabs.ibm.com.au>
In-Reply-To: <15071.59798.751500.870953@argo.ozlabs.ibm.com.au>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown-paper bag time...

The patch I sent earlier didn't include the accompanying changes to
if_ppp.h and ppp_channel.h.  Here they are.

Paul.

diff -urN linux/include/linux/if_ppp.h pmac/include/linux/if_ppp.h
--- linux/include/linux/if_ppp.h	Tue Mar 28 04:28:55 2000
+++ pmac/include/linux/if_ppp.h	Mon Mar  5 12:16:15 2001
@@ -1,4 +1,4 @@
-/*	$Id: if_ppp.h,v 1.19 1999/03/31 06:07:57 paulus Exp $	*/
+/*	$Id: if_ppp.h,v 1.21 2000/03/27 06:03:36 paulus Exp $	*/
 
 /*
  * if_ppp.h - Point-to-Point Protocol definitions.
@@ -21,7 +21,7 @@
  */
 
 /*
- *  ==FILEVERSION 20000324==
+ *  ==FILEVERSION 20000724==
  *
  *  NOTE TO MAINTAINERS:
  *     If you modify this file at all, please set the above date.
@@ -130,6 +130,8 @@
 #define PPPIOCSCOMPRESS	_IOW('t', 77, struct ppp_option_data)
 #define PPPIOCGNPMODE	_IOWR('t', 76, struct npioctl) /* get NP mode */
 #define PPPIOCSNPMODE	_IOW('t', 75, struct npioctl)  /* set NP mode */
+#define PPPIOCSPASS	_IOW('t', 71, struct sock_fprog) /* set pass filter */
+#define PPPIOCSACTIVE	_IOW('t', 70, struct sock_fprog) /* set active filt */
 #define PPPIOCGDEBUG	_IOR('t', 65, int)	/* Read debug level */
 #define PPPIOCSDEBUG	_IOW('t', 64, int)	/* Set debug level */
 #define PPPIOCGIDLE	_IOR('t', 63, struct ppp_idle) /* get idle time */
diff -urN linux/include/linux/ppp_channel.h pmac/include/linux/ppp_channel.h
--- linux/include/linux/ppp_channel.h	Mon Apr  2 02:20:35 2001
+++ pmac/include/linux/ppp_channel.h	Thu Apr 19 19:16:39 2001
@@ -22,7 +22,6 @@
 #include <linux/list.h>
 #include <linux/skbuff.h>
 #include <linux/poll.h>
-#include <asm/atomic.h>
 
 struct ppp_channel;
 
@@ -32,7 +31,6 @@
 	int	(*start_xmit)(struct ppp_channel *, struct sk_buff *);
 	/* Handle an ioctl call that has come in via /dev/ppp. */
 	int	(*ioctl)(struct ppp_channel *, unsigned int, unsigned long);
-	
 };
 
 struct ppp_channel {
@@ -78,16 +76,6 @@
  * in the start_xmit and ioctl routines for the channel by the time
  * that ppp_unregister_channel returns.
  */
-
-/* The following are temporary compatibility stuff */
-ssize_t ppp_channel_read(struct ppp_channel *chan, struct file *file,
-			 char *buf, size_t count);
-ssize_t ppp_channel_write(struct ppp_channel *chan, const char *buf,
-			  size_t count);
-unsigned int ppp_channel_poll(struct ppp_channel *chan, struct file *file,
-			      poll_table *wait);
-int ppp_channel_ioctl(struct ppp_channel *chan, unsigned int cmd,
-		      unsigned long arg);
 
 #endif /* __KERNEL__ */
 #endif
