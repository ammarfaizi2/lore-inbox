Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUFBUak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUFBUak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUFBU3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:29:11 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:52143 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264096AbUFBU0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:26:19 -0400
Subject: [Linux 2.6.4] EagleTec (rev 1.13) USB external harddisk support ->
	patch to unusual_devs.h
From: Tobias Weisserth <tobias@weisserth.org>
Reply-To: tobias@weisserth.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040602182131.GA13193@kroah.com>
References: <1086086759.10599.14.camel@coruscant.weisserth.net>
	 <20040602165723.GI7829@kroah.com>
	 <1086200163.8709.8.camel@coruscant.weisserth.net>
	 <20040602182131.GA13193@kroah.com>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1086207977.8707.38.camel@coruscant.weisserth.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 02 Jun 2004 22:26:18 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, 2004-06-02 at 20:21, Greg KH wrote:
...
> I did that in the response I wrote above.  Look in the Documentation
> directory of the kernel source for the SubmittingPatches file...

Stupid me. I didn't know until then that there is so much documentation
already included with the kernel sources...

> Good luck,

Well, I hope I did this right.

This is the patch:

######################################

--- drivers/usb/storage/unusual_devs.h.orig	2004-06-02
21:53:18.292064768 +0200
+++ drivers/usb/storage/unusual_devs.h	2004-06-02 22:00:39.486992944
+0200
@@ -409,6 +409,17 @@ UNUSUAL_DEV(  0x05e3, 0x0702, 0x0000, 0x
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_INQUIRY ),
 
+/* Reported by Tobias Weisserth <tobias@weisserth.org>
+ * Some EagleTec devices don't work with the other entry for EagleTec. 
+ * EagleTec devices with revision 1.13 like the "Pocket Boy" need a
slight adjustment.
+ * That is the only reason this entry is needed.
+*/
+UNUSUAL_DEV(  0x05e3, 0x0702, 0x0113, 0x0113,
+                "EagleTec",
+                "External Hard Disk",
+                US_SC_DEVICE, US_PR_DEVICE, NULL,
+                US_FL_FIX_INQUIRY ),
+
 /* Reported by Hanno Boeck <hanno@gmx.de>
  * Taken from the Lycoris Kernel */
 UNUSUAL_DEV(  0x0636, 0x0003, 0x0000, 0x9999,

######################################

I hope there is no problem with the line wrapping and I did this
right... first timer :-/

The patch applies to version 2.6.4 from www.kernel.org. It also works
with Con Kolivas' sources version 2.6.4. I guess if all the symbols that
are being used in the unit entry haven't disappeared from later kernel
versions then it can be applied to later (or earlier) versions as well.

The device I'm using wouldn't work without this modification. It didn't
show up in /dev but I could read the Vendor ID in "usbview" and this led
me to a very old entry in Red Hat bugzilla:
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=80328

Seeing that there already was an entry in
drivers/usb/storage/unusual_devs.h for EagleTec I only changed the bit
for the firmware version and it seems to work just fine.

Testing: I have successfully mounted a fat32 drive and read, deleted and
written (modified) files after applying my changes to the kernel.

Since this device seems to be very popular in Germany due a recent
catalogue offer from www.pearl.de for less than 10¤ I guess a great deal
of users would benefit from the addition. The "Pocket Boy" I own is a
USB 1.1 device. There is a similar device from the same vendor with USB
2.0 that is also called "Pocket Boy". I don't have one though so I don't
know what kind of chipset it is depending on.

I hope this information is conforming to submitting standards. Please
feel free to correct me on any mistakes I made.

regards,
Tobias Weisserth

