Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287530AbSAEFgo>; Sat, 5 Jan 2002 00:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287526AbSAEFge>; Sat, 5 Jan 2002 00:36:34 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:63946 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287522AbSAEFgV>; Sat, 5 Jan 2002 00:36:21 -0500
Date: Fri, 4 Jan 2002 21:36:10 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: miquel@df.uba.ar, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: linux-2.5.2-pre8/drivers/char/rio header compilation fixes
Message-ID: <20020104213610.A23808@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	In my previous post of compilation fixes for
drivers/char, I accidentally omitted .h files.  The omitted files
were linux/include/linux/tpqic02.h, which I posted a few minutes
ago, and some header files in drvers/char/rio/, which I have
attached to this message.

	A few notes about these changes:

	1. Yes, I really meant to change minor to MINOR in rio.h.  It
	   is not an accidentally reversed patch.
	2. I also worked around the compiler warnings about concatentation
	   of __FUNCTION__ with string constants.
	3. As with the other compilation fixes that I have posted over
	   the past couple of days, I only know that these changes
	   make the code compile.  They are untested.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rio.hdiffs"

--- linux-2.5.2-pre8/drivers/char/rio/linux_compat.h	Wed Jul  4 14:41:33 2001
+++ linux/drivers/char/rio/linux_compat.h	Fri Jan  4 21:25:30 2002
@@ -60,9 +60,6 @@
 
 #define getpid()    (current->pid)
 
-#define major(dev) MAJOR(dev)
-#define minor(dev) MINOR(dev)
-
 #define QSIZE SERIAL_XMIT_SIZE
 
 #define pseterr(errno) return (- errno)
--- linux-2.5.2-pre8/drivers/char/rio/rio.h	Wed Aug 15 01:22:15 2001
+++ linux/drivers/char/rio/rio.h	Fri Jan  4 21:25:30 2002
@@ -205,10 +205,10 @@
 #define	RIO_MODEMOFFSET		0x200	/* doesn't mean anything */
 #define	RIO_MODEM_MASK		0x1FF
 #define	RIO_MODEM_BIT		0x200
-#define	RIO_UNMODEM(DEV)	(minor(DEV) & RIO_MODEM_MASK)
-#define	RIO_ISMODEM(DEV)	(minor(DEV) & RIO_MODEM_BIT)
-#define RIO_PORT(DEV,FIRST_MAJ)	( (major(DEV) - FIRST_MAJ) * PORTS_PER_HOST) \
-					+ minor(DEV)
+#define	RIO_UNMODEM(DEV)	(MINOR(DEV) & RIO_MODEM_MASK)
+#define	RIO_ISMODEM(DEV)	(MINOR(DEV) & RIO_MODEM_BIT)
+#define RIO_PORT(DEV,FIRST_MAJ)	( (MAJOR(DEV) - FIRST_MAJ) * PORTS_PER_HOST) \
+					+ MINOR(DEV)
 
 #define	splrio	spltty
 
--- linux-2.5.2-pre8/drivers/char/rio/rio_linux.h	Wed Jul  4 14:41:33 2001
+++ linux/drivers/char/rio/rio_linux.h	Fri Jan  4 21:25:30 2002
@@ -178,10 +178,9 @@
 
 #ifdef DEBUG
 #define rio_dprintk(f, str...) do { if (rio_debug & f) printk (str);} while (0)
-#define func_enter() rio_dprintk (RIO_DEBUG_FLOW, "rio: enter " __FUNCTION__ "\n")
-#define func_exit()  rio_dprintk (RIO_DEBUG_FLOW, "rio: exit  " __FUNCTION__ "\n")
-#define func_enter2() rio_dprintk (RIO_DEBUG_FLOW, "rio: enter " __FUNCTION__ \
-                                   "(port %d)\n", port->line)
+#define func_enter() rio_dprintk (RIO_DEBUG_FLOW, "rio: enter %s\n", __FUNCTION__)
+#define func_exit()  rio_dprintk (RIO_DEBUG_FLOW, "rio: exit  %s\n", __FUNCTION__)
+#define func_enter2() rio_dprintk (RIO_DEBUG_FLOW, "rio: enter %s (port %d)\n",__FUNCTION__, port->line)
 #else
 #define rio_dprintk(f, str...) /* nothing */
 #define func_enter()

--LQksG6bCIzRHxTLp--
