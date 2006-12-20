Return-Path: <linux-kernel-owner+w=401wt.eu-S965024AbWLTVRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWLTVRI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWLTVRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:17:08 -0500
Received: from lx1.pxnet.com ([195.227.45.3]:35725 "EHLO lx1.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965024AbWLTVRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:17:06 -0500
Date: Wed, 20 Dec 2006 22:15:16 +0100
From: Tilman Schmidt <tilman@imap.cc>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: [Patch] consolidate line discipline number definitions (v2)
Message-ID: <20061220220318.tilman@imap.cc>
References: <45834391.2050100@imap.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The line discipline numbers N_* are currently defined for each
architecture individually, but (except for a seeming mistake)
identically, in asm/termios.h. There is no obvious reason why
these numbers should be architecture specific, nor any apparent
relationship with the termios structure. The total number of
these, NR_LDISCS, is defined in linux/tty.h anyway.
So I propose the following patch which moves the definitions
of the individual line disciplines to linux/tty.h too.

Three of these numbers (N_MASC, N_PROFIBUS_FDL, and N_SMSBLOCK)
are unused in the current kernel, but the patch still keeps the
complete set in case there are plans to use them yet.

Thanks
Tilman


From: Tilman Schmidt <tilman@imap.cc>

Move line discipline number definitions from architecture specific
asm/termios.h files to linux/tty.h.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 asm-alpha/termios.h   |   18 ------------------
 asm-arm/termios.h     |   18 ------------------
 asm-arm26/termios.h   |   18 ------------------
 asm-avr32/termios.h   |   18 ------------------
 asm-cris/termios.h    |   18 ------------------
 asm-frv/termios.h     |   18 ------------------
 asm-h8300/termios.h   |   18 ------------------
 asm-i386/termios.h    |   18 ------------------
 asm-ia64/termios.h    |   18 ------------------
 asm-m32r/termios.h    |   18 ------------------
 asm-m68k/termios.h    |   18 ------------------
 asm-mips/termios.h    |   18 ------------------
 asm-parisc/termios.h  |   18 ------------------
 asm-powerpc/termios.h |   18 ------------------
 asm-s390/termios.h    |   18 ------------------
 asm-sh/termios.h      |   18 ------------------
 asm-sh64/termios.h    |   18 ------------------
 asm-sparc/termios.h   |   18 ------------------
 asm-sparc64/termios.h |   18 ------------------
 asm-v850/termios.h    |   18 ------------------
 asm-x86_64/termios.h  |   18 ------------------
 asm-xtensa/termios.h  |   19 -------------------
 linux/tty.h           |   22 +++++++++++++++++++++-
 23 files changed, 21 insertions(+), 398 deletions(-)

diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-alpha/termios.h linux-2.6.19/include/asm-alpha/termios.h
--- linux-2.6.19-orig/include/asm-alpha/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-alpha/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -66,24 +66,6 @@ struct termio {
 #define _VEOL2	6
 #define _VSWTC	7
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 /*	eof=^D		eol=\0		eol2=\0		erase=del
 	werase=^W	kill=^U		reprint=^R	sxtc=\0
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-arm/termios.h linux-2.6.19/include/asm-arm/termios.h
--- linux-2.6.19-orig/include/asm-arm/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-arm/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -49,24 +49,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 
 /*
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-arm26/termios.h linux-2.6.19/include/asm-arm26/termios.h
--- linux-2.6.19-orig/include/asm-arm26/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-arm26/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -49,24 +49,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 
 /*
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-avr32/termios.h linux-2.6.19/include/asm-avr32/termios.h
--- linux-2.6.19-orig/include/asm-avr32/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-avr32/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -46,24 +46,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 /*	intr=^C		quit=^\		erase=del	kill=^U
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-cris/termios.h linux-2.6.19/include/asm-cris/termios.h
--- linux-2.6.19-orig/include/asm-cris/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-cris/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -40,24 +40,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_BT		15	/* bluetooth */
-
 #ifdef __KERNEL__
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-frv/termios.h linux-2.6.19/include/asm-frv/termios.h
--- linux-2.6.19-orig/include/asm-frv/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-frv/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -51,24 +51,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #include <asm-generic/termios.h>
 
 #endif /* _ASM_TERMIOS_H */
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-h8300/termios.h linux-2.6.19/include/asm-h8300/termios.h
--- linux-2.6.19-orig/include/asm-h8300/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-h8300/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -49,24 +49,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 
 /*
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-i386/termios.h linux-2.6.19/include/asm-i386/termios.h
--- linux-2.6.19-orig/include/asm-i386/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-i386/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -39,24 +39,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 #include <linux/module.h>
 
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-ia64/termios.h linux-2.6.19/include/asm-ia64/termios.h
--- linux-2.6.19-orig/include/asm-ia64/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-ia64/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -46,24 +46,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS msgs */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 # ifdef __KERNEL__
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-m32r/termios.h linux-2.6.19/include/asm-m32r/termios.h
--- linux-2.6.19-orig/include/asm-m32r/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-m32r/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -41,24 +41,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 #include <linux/module.h>
 
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-m68k/termios.h linux-2.6.19/include/asm-m68k/termios.h
--- linux-2.6.19-orig/include/asm-m68k/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-m68k/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -49,24 +49,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 
 /*
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-mips/termios.h linux-2.6.19/include/asm-mips/termios.h
--- linux-2.6.19-orig/include/asm-mips/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-mips/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -87,24 +87,6 @@ struct termio {
 #define TIOCM_OUT2	0x4000
 #define TIOCM_LOOP	0x8000
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6		/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved fo Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15	/* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 
 #include <linux/string.h>
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-parisc/termios.h linux-2.6.19/include/asm-parisc/termios.h
--- linux-2.6.19-orig/include/asm-parisc/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-parisc/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -39,24 +39,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-powerpc/termios.h linux-2.6.19/include/asm-powerpc/termios.h
--- linux-2.6.19-orig/include/asm-powerpc/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-powerpc/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -71,24 +71,6 @@ struct termio {
 #define _VEOL2	8
 #define _VSWTC	9
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://www.cs.uit.no/~dagb/irda/irda.html */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 /*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  */
 #define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025" 
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-s390/termios.h linux-2.6.19/include/asm-s390/termios.h
--- linux-2.6.19-orig/include/asm-s390/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-s390/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -47,24 +47,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-sh/termios.h linux-2.6.19/include/asm-sh/termios.h
--- linux-2.6.19-orig/include/asm-sh/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-sh/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -39,24 +39,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-sh64/termios.h linux-2.6.19/include/asm-sh64/termios.h
--- linux-2.6.19-orig/include/asm-sh64/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-sh64/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -50,24 +50,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://www.cs.uit.no/~dagb/irda/irda.html */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15	/* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-sparc/termios.h linux-2.6.19/include/asm-sparc/termios.h
--- linux-2.6.19-orig/include/asm-sparc/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-sparc/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -45,24 +45,6 @@ struct winsize {
 	unsigned short ws_ypixel;
 };
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 #include <linux/module.h>
 
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-sparc64/termios.h linux-2.6.19/include/asm-sparc64/termios.h
--- linux-2.6.19-orig/include/asm-sparc64/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-sparc64/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -45,24 +45,6 @@ struct winsize {
 	unsigned short ws_ypixel;
 };
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 #include <linux/module.h>
 
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-v850/termios.h linux-2.6.19/include/asm-v850/termios.h
--- linux-2.6.19-orig/include/asm-v850/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-v850/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -39,24 +39,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-x86_64/termios.h linux-2.6.19/include/asm-x86_64/termios.h
--- linux-2.6.19-orig/include/asm-x86_64/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-x86_64/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -39,24 +39,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14	/* synchronous PPP */
-#define N_HCI		15  /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/asm-xtensa/termios.h linux-2.6.19/include/asm-xtensa/termios.h
--- linux-2.6.19-orig/include/asm-xtensa/termios.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-xtensa/termios.h	2006-12-17 20:48:17.000000000 +0100
@@ -52,25 +52,6 @@ struct termio {
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
-/* Line disciplines */
-
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-#define N_HCI		15      /* Bluetooth HCI UART */
-
 #ifdef __KERNEL__
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
diff -rupX /home/ts/dont-diff linux-2.6.19-orig/include/linux/tty.h linux-2.6.19/include/linux/tty.h
--- linux-2.6.19-orig/include/linux/tty.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/linux/tty.h	2006-12-17 21:00:38.000000000 +0100
@@ -24,7 +24,27 @@
 #define NR_PTYS	CONFIG_LEGACY_PTY_COUNT   /* Number of legacy ptys */
 #define NR_UNIX98_PTY_DEFAULT	4096      /* Default maximum for Unix98 ptys */
 #define NR_UNIX98_PTY_MAX	(1 << MINORBITS) /* Absolute limit */
-#define NR_LDISCS		16
+#define NR_LDISCS		17
+
+/* line disciplines */
+#define N_TTY		0
+#define N_SLIP		1
+#define N_MOUSE		2
+#define N_PPP		3
+#define N_STRIP		4
+#define N_AX25		5
+#define N_X25		6	/* X.25 async */
+#define N_6PACK		7
+#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
+#define N_R3964		9	/* Reserved for Simatic R3964 module */
+#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
+#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
+#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data */
+				/* cards about SMS messages */
+#define N_HDLC		13	/* synchronous HDLC */
+#define N_SYNC_PPP	14	/* synchronous PPP */
+#define N_HCI		15	/* Bluetooth HCI UART */
+#define N_GIGASET_M101	16	/* Siemens Gigaset M101 serial DECT adapter */
 
 /*
  * This character is the same as _POSIX_VDISABLE: it cannot be used as
