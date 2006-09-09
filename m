Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWIIPef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWIIPef (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWIIPef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:34:35 -0400
Received: from anyanka.rfc1149.net ([81.56.47.149]:34265 "EHLO
	mail2.rfc1149.net") by vger.kernel.org with ESMTP id S932268AbWIIPee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:34:34 -0400
Date: Sat, 9 Sep 2006 17:34:31 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: use ENOTTY instead of ENOIOCTLCMD in ioctl()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Samuel Tardieu <sam@rfc1149.net>
Organization: RFC 1149 (see http://www.rfc1149.net/)
Content-Transfer-Encoding: 8bit
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Message-Id: <2006-09-09-17-34-32+trackit+sam@rfc1149.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return ENOTTY instead of ENOIOCTLCMD in user-visible ioctl() results

The watchdog drivers used to return ENOIOCTLCMD for bad ioctl() commands.
ENOIOCTLCMD should not be visible by the user, so use ENOTTY instead.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>

diff -r 9cfff4a421bd drivers/char/watchdog/acquirewdt.c
--- a/drivers/char/watchdog/acquirewdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/acquirewdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -183,7 +183,7 @@ static int acq_ioctl(struct inode *inode
 	}
 
 	default:
-	  return -ENOIOCTLCMD;
+	  return -ENOTTY;
 	}
 }
 
diff -r 9cfff4a421bd drivers/char/watchdog/advantechwdt.c
--- a/drivers/char/watchdog/advantechwdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/advantechwdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -176,7 +176,7 @@ advwdt_ioctl(struct inode *inode, struct
 	}
 
 	default:
-	  return -ENOIOCTLCMD;
+	  return -ENOTTY;
 	}
 	return 0;
 }
diff -r 9cfff4a421bd drivers/char/watchdog/alim1535_wdt.c
--- a/drivers/char/watchdog/alim1535_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/alim1535_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -236,7 +236,7 @@ static int ali_ioctl(struct inode *inode
 			return put_user(timeout, p);
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
diff -r 9cfff4a421bd drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/alim7101_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -277,7 +277,7 @@ static int fop_ioctl(struct inode *inode
 		case WDIOC_GETTIMEOUT:
 			return put_user(timeout, p);
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
diff -r 9cfff4a421bd drivers/char/watchdog/at91_wdt.c
--- a/drivers/char/watchdog/at91_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/at91_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -168,7 +168,7 @@ static int at91_wdt_ioctl(struct inode *
 			return 0;
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
diff -r 9cfff4a421bd drivers/char/watchdog/booke_wdt.c
--- a/drivers/char/watchdog/booke_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/booke_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -125,7 +125,7 @@ static int booke_wdt_ioctl (struct inode
 			return -EINVAL;
 		return 0;
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 
 	return 0;
diff -r 9cfff4a421bd drivers/char/watchdog/cpu5wdt.c
--- a/drivers/char/watchdog/cpu5wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/cpu5wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -183,7 +183,7 @@ static int cpu5wdt_ioctl(struct inode *i
 			}
 			break;
 		default:
-    			return -ENOIOCTLCMD;
+    			return -ENOTTY;
 	}
 	return 0;
 }
diff -r 9cfff4a421bd drivers/char/watchdog/ep93xx_wdt.c
--- a/drivers/char/watchdog/ep93xx_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/ep93xx_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -144,7 +144,7 @@ ep93xx_wdt_ioctl(struct inode *inode, st
 ep93xx_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 		 unsigned long arg)
 {
-	int ret = -ENOIOCTLCMD;
+	int ret = -ENOTTY;
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
diff -r 9cfff4a421bd drivers/char/watchdog/eurotechwdt.c
--- a/drivers/char/watchdog/eurotechwdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/eurotechwdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -240,7 +240,7 @@ static int eurwdt_ioctl(struct inode *in
 
 	switch(cmd) {
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	case WDIOC_GETSUPPORT:
 		return copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : 0;
diff -r 9cfff4a421bd drivers/char/watchdog/i6300esb.c
--- a/drivers/char/watchdog/i6300esb.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/i6300esb.c	Sat Sep 09 17:29:23 2006 +0200
@@ -315,7 +315,7 @@ static int esb_ioctl (struct inode *inod
                         return put_user(heartbeat, p);
 
                 default:
-                        return -ENOIOCTLCMD;
+                        return -ENOTTY;
         }
 }
 
diff -r 9cfff4a421bd drivers/char/watchdog/i8xx_tco.c
--- a/drivers/char/watchdog/i8xx_tco.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/i8xx_tco.c	Sat Sep 09 17:29:23 2006 +0200
@@ -356,7 +356,7 @@ static int i8xx_tco_ioctl (struct inode 
 		}
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
diff -r 9cfff4a421bd drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/ib700wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -199,7 +199,7 @@ ibwdt_ioctl(struct inode *inode, struct 
 	  break;
 
 	default:
-	  return -ENOIOCTLCMD;
+	  return -ENOTTY;
 	}
 	return 0;
 }
diff -r 9cfff4a421bd drivers/char/watchdog/ibmasr.c
--- a/drivers/char/watchdog/ibmasr.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/ibmasr.c	Sat Sep 09 17:29:23 2006 +0200
@@ -295,7 +295,7 @@ static int asr_ioctl(struct inode *inode
 		}
 	}
 
-	return -ENOIOCTLCMD;
+	return -ENOTTY;
 }
 
 static int asr_open(struct inode *inode, struct file *file)
diff -r 9cfff4a421bd drivers/char/watchdog/indydog.c
--- a/drivers/char/watchdog/indydog.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/indydog.c	Sat Sep 09 17:29:23 2006 +0200
@@ -112,7 +112,7 @@ static int indydog_ioctl(struct inode *i
 
 	switch (cmd) {
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			if (copy_to_user((struct watchdog_info *)arg,
 					 &ident, sizeof(ident)))
diff -r 9cfff4a421bd drivers/char/watchdog/ixp2000_wdt.c
--- a/drivers/char/watchdog/ixp2000_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/ixp2000_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -107,7 +107,7 @@ ixp2000_wdt_ioctl(struct inode *inode, s
 ixp2000_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 			unsigned long arg)
 {
-	int ret = -ENOIOCTLCMD;
+	int ret = -ENOTTY;
 	int time;
 
 	switch (cmd) {
diff -r 9cfff4a421bd drivers/char/watchdog/ixp4xx_wdt.c
--- a/drivers/char/watchdog/ixp4xx_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/ixp4xx_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -102,7 +102,7 @@ ixp4xx_wdt_ioctl(struct inode *inode, st
 ixp4xx_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 			unsigned long arg)
 {
-	int ret = -ENOIOCTLCMD;
+	int ret = -ENOTTY;
 	int time;
 
 	switch (cmd) {
diff -r 9cfff4a421bd drivers/char/watchdog/machzwd.c
--- a/drivers/char/watchdog/machzwd.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/machzwd.c	Sat Sep 09 17:29:23 2006 +0200
@@ -329,7 +329,7 @@ static int zf_ioctl(struct inode *inode,
 			break;
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 
 	return 0;
diff -r 9cfff4a421bd drivers/char/watchdog/mixcomwd.c
--- a/drivers/char/watchdog/mixcomwd.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/mixcomwd.c	Sat Sep 09 17:29:23 2006 +0200
@@ -185,7 +185,7 @@ static int mixcomwd_ioctl(struct inode *
 			mixcomwd_ping();
 			break;
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 	return 0;
 }
diff -r 9cfff4a421bd drivers/char/watchdog/mpc83xx_wdt.c
--- a/drivers/char/watchdog/mpc83xx_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/mpc83xx_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -125,7 +125,7 @@ static int mpc83xx_wdt_ioctl(struct inod
 	case WDIOC_GETTIMEOUT:
 		return put_user(timeout_sec, p);
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 }
 
diff -r 9cfff4a421bd drivers/char/watchdog/mpc8xx_wdt.c
--- a/drivers/char/watchdog/mpc8xx_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/mpc8xx_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -126,7 +126,7 @@ static int mpc8xx_wdt_ioctl(struct inode
 		break;
 
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 
 	return 0;
diff -r 9cfff4a421bd drivers/char/watchdog/mpcore_wdt.c
--- a/drivers/char/watchdog/mpcore_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/mpcore_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -221,7 +221,7 @@ static int mpcore_wdt_ioctl(struct inode
 	} uarg;
 
 	if (_IOC_DIR(cmd) && _IOC_SIZE(cmd) > sizeof(uarg))
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	if (_IOC_DIR(cmd) & _IOC_WRITE) {
 		ret = copy_from_user(&uarg, (void __user *)arg, _IOC_SIZE(cmd));
@@ -271,7 +271,7 @@ static int mpcore_wdt_ioctl(struct inode
 		break;
 
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 
 	if (ret == 0 && _IOC_DIR(cmd) & _IOC_READ) {
diff -r 9cfff4a421bd drivers/char/watchdog/mv64x60_wdt.c
--- a/drivers/char/watchdog/mv64x60_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/mv64x60_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -160,7 +160,7 @@ static int mv64x60_wdt_ioctl(struct inod
 		break;
 
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 
 	return 0;
diff -r 9cfff4a421bd drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/pcwd.c	Sat Sep 09 17:29:23 2006 +0200
@@ -572,7 +572,7 @@ static int pcwd_ioctl(struct inode *inod
 
 	switch(cmd) {
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	case WDIOC_GETSUPPORT:
 		if(copy_to_user(argp, &ident, sizeof(ident)))
diff -r 9cfff4a421bd drivers/char/watchdog/pcwd_pci.c
--- a/drivers/char/watchdog/pcwd_pci.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/pcwd_pci.c	Sat Sep 09 17:29:23 2006 +0200
@@ -541,7 +541,7 @@ static int pcipcwd_ioctl(struct inode *i
 		}
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
diff -r 9cfff4a421bd drivers/char/watchdog/pcwd_usb.c
--- a/drivers/char/watchdog/pcwd_usb.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/pcwd_usb.c	Sat Sep 09 17:29:23 2006 +0200
@@ -445,7 +445,7 @@ static int usb_pcwd_ioctl(struct inode *
 		}
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 }
 
diff -r 9cfff4a421bd drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/s3c2410_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -288,7 +288,7 @@ static int s3c2410wdt_ioctl(struct inode
 
 	switch (cmd) {
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &s3c2410_wdt_ident,
diff -r 9cfff4a421bd drivers/char/watchdog/sa1100_wdt.c
--- a/drivers/char/watchdog/sa1100_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/sa1100_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -90,7 +90,7 @@ static int sa1100dog_ioctl(struct inode 
 static int sa1100dog_ioctl(struct inode *inode, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
-	int ret = -ENOIOCTLCMD;
+	int ret = -ENOTTY;
 	int time;
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
diff -r 9cfff4a421bd drivers/char/watchdog/sbc60xxwdt.c
--- a/drivers/char/watchdog/sbc60xxwdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/sbc60xxwdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -235,7 +235,7 @@ static int fop_ioctl(struct inode *inode
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &ident, sizeof(ident))?-EFAULT:0;
 		case WDIOC_GETSTATUS:
diff -r 9cfff4a421bd drivers/char/watchdog/sbc_epx_c3.c
--- a/drivers/char/watchdog/sbc_epx_c3.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/sbc_epx_c3.c	Sat Sep 09 17:29:23 2006 +0200
@@ -141,7 +141,7 @@ static int epx_c3_ioctl(struct inode *in
 
 		return retval;
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 }
 
diff -r 9cfff4a421bd drivers/char/watchdog/sc1200wdt.c
--- a/drivers/char/watchdog/sc1200wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/sc1200wdt.c	Sat Sep 09 17:30:07 2006 +0200
@@ -180,7 +180,7 @@ static int sc1200wdt_ioctl(struct inode 
 
 	switch (cmd) {
 		default:
-			return -ENOIOCTLCMD;	/* Keep Pavel Machek amused ;) */
+			return -ENOTTY;
 
 		case WDIOC_GETSUPPORT:
 			if (copy_to_user(argp, &ident, sizeof ident))
diff -r 9cfff4a421bd drivers/char/watchdog/sc520_wdt.c
--- a/drivers/char/watchdog/sc520_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/sc520_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -290,7 +290,7 @@ static int fop_ioctl(struct inode *inode
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &ident, sizeof(ident))?-EFAULT:0;
 		case WDIOC_GETSTATUS:
diff -r 9cfff4a421bd drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/scx200_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -166,7 +166,7 @@ static int scx200_wdt_ioctl(struct inode
 
 	switch (cmd) {
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	case WDIOC_GETSUPPORT:
 		if(copy_to_user(argp, &ident, sizeof(ident)))
 			return -EFAULT;
diff -r 9cfff4a421bd drivers/char/watchdog/shwdt.c
--- a/drivers/char/watchdog/shwdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/shwdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -318,7 +318,7 @@ static int sh_wdt_ioctl(struct inode *in
 
 			return retval;
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 
 	return 0;
diff -r 9cfff4a421bd drivers/char/watchdog/softdog.c
--- a/drivers/char/watchdog/softdog.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/softdog.c	Sat Sep 09 17:29:23 2006 +0200
@@ -203,7 +203,7 @@ static int softdog_ioctl(struct inode *i
 	};
 	switch (cmd) {
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &ident,
 				sizeof(ident)) ? -EFAULT : 0;
diff -r 9cfff4a421bd drivers/char/watchdog/w83627hf_wdt.c
--- a/drivers/char/watchdog/w83627hf_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/w83627hf_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -223,7 +223,7 @@ wdt_ioctl(struct inode *inode, struct fi
 	}
 
 	default:
-	  return -ENOIOCTLCMD;
+	  return -ENOTTY;
 	}
 	return 0;
 }
diff -r 9cfff4a421bd drivers/char/watchdog/w83877f_wdt.c
--- a/drivers/char/watchdog/w83877f_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/w83877f_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -252,7 +252,7 @@ static int fop_ioctl(struct inode *inode
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &ident, sizeof(ident))?-EFAULT:0;
 		case WDIOC_GETSTATUS:
diff -r 9cfff4a421bd drivers/char/watchdog/w83977f_wdt.c
--- a/drivers/char/watchdog/w83977f_wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/w83977f_wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -393,7 +393,7 @@ static int wdt_ioctl(struct inode *inode
 	switch(cmd)
 	{
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	case WDIOC_GETSUPPORT:
 		return copy_to_user(uarg.ident, &ident, sizeof(ident)) ? -EFAULT : 0;
diff -r 9cfff4a421bd drivers/char/watchdog/wafer5823wdt.c
--- a/drivers/char/watchdog/wafer5823wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/wafer5823wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -174,7 +174,7 @@ static int wafwdt_ioctl(struct inode *in
 	}
 
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 	return 0;
 }
diff -r 9cfff4a421bd drivers/char/watchdog/wdrtas.c
--- a/drivers/char/watchdog/wdrtas.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/wdrtas.c	Sat Sep 09 17:29:23 2006 +0200
@@ -385,7 +385,7 @@ wdrtas_ioctl(struct inode *inode, struct
 		return put_user(wdrtas_interval, argp);
 
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 }
 
diff -r 9cfff4a421bd drivers/char/watchdog/wdt.c
--- a/drivers/char/watchdog/wdt.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/wdt.c	Sat Sep 09 17:29:23 2006 +0200
@@ -341,7 +341,7 @@ static int wdt_ioctl(struct inode *inode
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &ident, sizeof(ident))?-EFAULT:0;
 
diff -r 9cfff4a421bd drivers/char/watchdog/wdt285.c
--- a/drivers/char/watchdog/wdt285.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/wdt285.c	Sat Sep 09 17:29:23 2006 +0200
@@ -137,7 +137,7 @@ watchdog_ioctl(struct inode *inode, stru
 	       unsigned long arg)
 {
 	unsigned int new_margin;
-	int ret = -ENOIOCTLCMD;
+	int ret = -ENOTTY;
 
 	switch(cmd) {
 	case WDIOC_GETSUPPORT:
diff -r 9cfff4a421bd drivers/char/watchdog/wdt977.c
--- a/drivers/char/watchdog/wdt977.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/wdt977.c	Sat Sep 09 17:29:23 2006 +0200
@@ -361,7 +361,7 @@ static int wdt977_ioctl(struct inode *in
 	switch(cmd)
 	{
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	case WDIOC_GETSUPPORT:
 		return copy_to_user(uarg.ident, &ident,
diff -r 9cfff4a421bd drivers/char/watchdog/wdt_pci.c
--- a/drivers/char/watchdog/wdt_pci.c	Wed Sep 06 19:00:09 2006 +0000
+++ b/drivers/char/watchdog/wdt_pci.c	Sat Sep 09 17:29:23 2006 +0200
@@ -386,7 +386,7 @@ static int wdtpci_ioctl(struct inode *in
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user(argp, &ident, sizeof(ident))?-EFAULT:0;
 

