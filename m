Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157066AbQGPOWk>; Sun, 16 Jul 2000 10:22:40 -0400
Received: by vger.rutgers.edu id <S157055AbQGPOWa>; Sun, 16 Jul 2000 10:22:30 -0400
Received: from p27-cordelia-gui.tch.enablis.net ([212.250.233.27]:2179 "EHLO caramon.arm.linux.org.uk") by vger.rutgers.edu with ESMTP id <S157035AbQGPOWT>; Sun, 16 Jul 2000 10:22:19 -0400
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200007161435.PAA01571@raistlin.arm.linux.org.uk>
Subject: Patch: allow ifconfig of devices with only unix domain sockets
To: linux-kernel@vger.rutgers.edu
Date: Sun, 16 Jul 2000 15:35:44 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

The following patch is required to allow ifconfig to "up" the IrDA FIR
network interfaces on kernels configured with IrDA and unix domain
sockets.

Without this patch, it is impossible to use FIR IrDA on such kernels.

diff -urN linux-orig/net/unix/af_unix.c linux/net/unix/af_unix.c
--- linux-orig/net/unix/af_unix.c	Sun Jul  9 10:49:59 2000
+++ linux/net/unix/af_unix.c	Sun Jul  9 10:46:47 2000
@@ -1670,7 +1670,7 @@
 		}
 
 		default:
-			err = -EINVAL;
+			err = dev_ioctl(cmd, (void *)arg);
 			break;
 	}
 	return err;


   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | |   http://www.arm.linux.org.uk/~rmk/aboutme.html    /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
