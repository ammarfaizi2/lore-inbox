Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276018AbRJKLFI>; Thu, 11 Oct 2001 07:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276052AbRJKLEv>; Thu, 11 Oct 2001 07:04:51 -0400
Received: from [64.40.52.10] ([64.40.52.10]:45185 "HELO fortytwo.homeip.net")
	by vger.kernel.org with SMTP id <S276018AbRJKLEa>;
	Thu, 11 Oct 2001 07:04:30 -0400
Message-ID: <3BC57C9D.8070601@users.sourceforge.net>
Date: Thu, 11 Oct 2001 04:03:57 -0700
From: Colin Bayer <vogon_jeltz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.12 compile fails in ieee1284_ops.c
Content-Type: multipart/mixed;
 boundary="------------040706030000010208010602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040706030000010208010602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I just d/l'ed the late-night bug-fix release, and was expecting a normal 
compile, when this wrench was thrown into the works:

ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in 
this function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in 
this function)
make[3]: *** [ieee1284_ops.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/parport'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/parport'
make[1]: *** [_subdir_parport] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

Yes, I'm using RedHat (7.1), and yes, their compilers suck, but this one 
hasn't given me problems with kernel compiles in the past.  I propose 
somewhat of a one-liner patch to fix this (it's attached).

--------------040706030000010208010602
Content-Type: text/plain;
 name="1284_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1284_patch.diff"

--- linux/drivers/parport/ieee1284_ops.c	Thu Oct 11 03:42:35 2001
+++ linux-patched/drivers/parport/ieee1284_ops.c	Thu Oct 11 04:01:10 2001
@@ -362,7 +362,7 @@
 	} else {
 		DPRINTK (KERN_DEBUG "%s: ECP direction: failed to reverse\n",
 			 port->name);
-		port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 	}
 
 	return retval;
@@ -394,7 +394,7 @@
 		DPRINTK (KERN_DEBUG
 			 "%s: ECP direction: failed to switch forward\n",
 			 port->name);
-		port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 	}
 
 

--------------040706030000010208010602--

