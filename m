Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280615AbRKSSxh>; Mon, 19 Nov 2001 13:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280608AbRKSSx2>; Mon, 19 Nov 2001 13:53:28 -0500
Received: from systemy5.systemy.it ([194.20.140.51]:62717 "EHLO
	morgana.systemy.it") by vger.kernel.org with ESMTP
	id <S280597AbRKSSxS>; Mon, 19 Nov 2001 13:53:18 -0500
Date: Mon, 19 Nov 2001 19:53:04 +0100
From: Rodolfo Giometti <giometti@linux.it>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, m.barella@ascensit.com
Subject: [PATCH] Eurotech WDT driver not fully patched
Message-ID: <20011119195304.D31720@morgana.systemy.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Programmi e soluzioni GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I notice you add my (little) driver into main kernel tree (see file
linux/drivers/char/eurotechwdt.c) and I'm very happy for this!  :^)

But you forgot to patch some files so, currently, is not possible
compiling and using it! :'(

Please, use the following patch to put everything ok.

Thanks,
Rodolfo

-- 

     \\\\
     (o o)
--oOO-(_)-OOo------------------------------------------------------------
Rodolfo Giometti (ZtW)               e-mail:    giometti@linux.it
                                                giometti@ascensit.com
Programmi e soluzioni GNU                       giometti@oltrelinux.com
*  Linux Device Drivers              home page: giometti.oltrelinux.com
*  Embedded Systems                  phone:     +39 329 7028903

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.4.14-eurotechwdt-1.0.0"

diff -urN --exclude-from=patch-exclude linux-2.4.10/drivers/char/Config.in lp4_wd/drivers/char/Config.in
--- linux-2.4.10/drivers/char/Config.in	Sun Sep 23 18:52:38 2001
+++ lp4_wd/drivers/char/Config.in	Tue Oct  9 23:00:46 2001
@@ -166,6 +166,7 @@
       fi
    fi
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
+   tristate '  Eurotech CPU-1220/1410 Watchdog Timer' CONFIG_EUROTECH_WDT
 fi
 endmenu
 
diff -urN --exclude-from=patch-exclude linux-2.4.10/drivers/char/Makefile lp4_wd/drivers/char/Makefile
--- linux-2.4.10/drivers/char/Makefile	Sun Sep  9 19:43:02 2001
+++ lp4_wd/drivers/char/Makefile	Tue Oct  9 23:00:43 2001
@@ -230,6 +230,7 @@
 obj-$(CONFIG_977_WATCHDOG) += wdt977.o
 obj-$(CONFIG_I810_TCO) += i810-tco.o
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
+obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_SH_WDT) += shwdt.o
 
 
diff -urN --exclude-from=patch-exclude linux-2.4.10/include/linux/watchdog.h lp4_wd/include/linux/watchdog.h
--- linux-2.4.10/include/linux/watchdog.h	Thu Oct  4 13:50:34 2001
+++ lp4_wd/include/linux/watchdog.h	Wed Oct 10 11:40:15 2001
@@ -25,6 +25,7 @@
 #define	WDIOC_GETTEMP		_IOR(WATCHDOG_IOCTL_BASE, 3, int)
 #define	WDIOC_SETOPTIONS	_IOR(WATCHDOG_IOCTL_BASE, 4, int)
 #define	WDIOC_KEEPALIVE		_IOR(WATCHDOG_IOCTL_BASE, 5, int)
+#define WDIOC_SETTIMEOUT        _IOW(WATCHDOG_IOCTL_BASE, 6, int)
 
 #define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
 #define	WDIOS_UNKNOWN		-1	/* Unknown status error */

--G4iJoqBmSsgzjUCe--
