Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131067AbQKYM61>; Sat, 25 Nov 2000 07:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130915AbQKYM6R>; Sat, 25 Nov 2000 07:58:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42761 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129183AbQKYM6A>;
        Sat, 25 Nov 2000 07:58:00 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011251227.eAPCRPe19247@flint.arm.linux.org.uk>
Subject: Re: 2.4.0-test11 (pre1, final) OOPS during boot/modprobe
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 25 Nov 2000 12:27:24 +0000 (GMT)
Cc: ssd@nevets.oau.org (Steven S. Dick), linux-kernel@vger.kernel.org
In-Reply-To: <6809.975153913@ocs3.ocs-net> from "Keith Owens" at Nov 25, 2000 11:05:13 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> On Sat, 25 Nov 2000 06:10:54 -0500 (EST), 
> ssd@nevets.oau.org (Steven S. Dick) wrote:
> >2.4.0-test11-pre1 seems to have broken something.
> >I have no problems with test10, but test11-pre1 gives three oops
> >messages during boot.  test11-final gives the exact same OOPS messages...
> 
> Which modutils?  And if it is not 2.3.21, upgrade.

Steven probably wants to apply this patch to test11:

--- orig/kernel/module.c	Wed Nov 22 14:08:23 2000
+++ linux/kernel/module.c	Sat Nov 25 10:40:26 2000
@@ -480,7 +480,9 @@
 
 	/* Ok, that's about all the sanity we can stomach; copy the rest.  */
 
-	if (copy_from_user(mod+1, mod_user+1, mod->size-sizeof(*mod))) {
+	if (copy_from_user((char *)mod+mod_user_size,
+			   (char *)mod_user+mod_user_size,
+			   mod->size-mod_user_size)) {
 		error = -EFAULT;
 		goto err3;
 	}

   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
