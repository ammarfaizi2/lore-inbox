Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131650AbQJ2M4S>; Sun, 29 Oct 2000 07:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131663AbQJ2Mz7>; Sun, 29 Oct 2000 07:55:59 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:19028
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131650AbQJ2Mzy>; Sun, 29 Oct 2000 07:55:54 -0500
Date: Sun, 29 Oct 2000 14:48:22 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: Compile error in drivers/ide/osb4.c in 240-t10p6
Message-ID: <20001029144822.B622@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<ugh> Forgot to cc linux-kernel

Hi.

I get the following error when trying to compile 2.4.0-test10pre6
without procfs support:

drivers/ide/osb4.c: In function `pci_init_osb4':
drivers/ide/osb4.c:264: `osb4_revision' undeclared (first use in this function)
drivers/ide/osb4.c:264: (Each undeclared identifier is reported only once
drivers/ide/osb4.c:264: for each function it appears in.)
make: *** [drivers/ide/osb4.o] Error 1

The variable, osb4_revision, is inside a #ifdef CONFIG_PROC_FS block but
I was not able to discern if the line where it is referred should be
#ifdef'ed also. The following patch moves the variable declaration out-
side the #ifdef block, as a blind guess...


--- linux-240-t10p6-clean/drivers/ide/osb4.c	Sun Oct 29 09:51:10 2000
+++ linux/drivers/ide/osb4.c	Sun Oct 29 13:55:23 2000
@@ -56,11 +56,12 @@
 
 #define DISPLAY_OSB4_TIMINGS
 
+static byte osb4_revision = 0;
+
 #if defined(DISPLAY_OSB4_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
-static byte osb4_revision = 0;
 static struct pci_dev *bmide_dev;
 
 static int osb4_get_info(char *, char **, off_t, int, int);

-- 
        Rasmus(rasmus@jaquet.dk)

There are two major products that come out of Berkeley: LSD and UNIX. We 
don't believe this to be a coincidence. -- Jeremy S. Anderson 

----- End forwarded message -----

-- 
        Rasmus(rasmus@jaquet.dk)

First snow, then silence.
This thousand dollar screen dies
so beautifully.           --- Error messages in haiku
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
