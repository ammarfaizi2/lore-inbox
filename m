Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUFEROf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUFEROf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 13:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUFEROf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 13:14:35 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:11698 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261723AbUFEROa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 13:14:30 -0400
Subject: Re: [Linux 2.6.4] EagleTec (rev 1.13) USB external harddisk
	support -> patch to unusual_devs.h
From: Tobias Weisserth <tobias@weisserth.org>
Reply-To: tobias@weisserth.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040602225906.GA23819@kroah.com>
References: <1086086759.10599.14.camel@coruscant.weisserth.net>
	 <20040602165723.GI7829@kroah.com>
	 <1086200163.8709.8.camel@coruscant.weisserth.net>
	 <20040602182131.GA13193@kroah.com>
	 <1086207977.8707.38.camel@coruscant.weisserth.net>
	 <20040602203307.GA19749@kroah.com>
	 <1086213609.8710.79.camel@coruscant.weisserth.net>
	 <20040602225906.GA23819@kroah.com>
Content-Type: multipart/mixed; boundary="=-JIlRsR8Y7RUHiSR/xBlp"
Message-Id: <1086455663.7588.6.camel@coruscant.weisserth.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 05 Jun 2004 19:14:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JIlRsR8Y7RUHiSR/xBlp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 2004-06-03 at 00:59, Greg KH wrote:
...
> Nope, sorry.  Don't cut and paste.  Try attaching as a text attachment,
> or doing something with your editor to read from your patch file into
> the body of the email.

I tried the latter. Doesn't seem to work.

I attached the patches.

Those are a patch for the 2.6.6 kernel and the 2.6.4 kernel.

When I was going through all my kernel branches in /usr/src I noticed
that the Gentoo development branch already had a suitable entry for the
firmware version of my device:

/* Reported by Henning Schild <henning@wh9.tu-dresden.de> */
UNUSUAL_DEV(  0x05e3, 0x0702, 0x0113, 0x0113,
                "EagleTec",
                "External Hard Disk",
                US_SC_DEVICE, US_PR_DEVICE, NULL,
                US_FL_FIX_INQUIRY ),

More information on these sources:

http://packages.gentoo.org/ebuilds/?gentoo-dev-sources-2.6.5-r1

I found it in no other branch besides this.

So if you include my patch then you might consider putting his name
there too. I discovered his entry after I figured out by myself how to
make EagleTec revision 1.13 work, but I don't know whether he did it
before me.

regards,
Tobias

--=-JIlRsR8Y7RUHiSR/xBlp
Content-Disposition: attachment; filename=patch-EagleTec113-2.6.4
Content-Type: text/plain; name=patch-EagleTec113-2.6.4; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

--- drivers/usb/storage/unusual_devs.h.orig	2004-06-02 21:53:18.000000000 +0200
+++ drivers/usb/storage/unusual_devs.h	2004-06-05 19:04:10.880021976 +0200
@@ -409,6 +409,20 @@ UNUSUAL_DEV(  0x05e3, 0x0702, 0x0000, 0x
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_INQUIRY ),
 
+/* Reported by Tobias Weisserth <tobias@weisserth.org>
+ * Like the SIIG unit above, this unit needs an INQUIRY to ask for exactly
+ * 36 bytes of data.  No more, no less. That is the only reason this entry
+ * is needed.
+ *
+ * This entry is an exact copy of the above entry with a different
+ * firmware revision (1.13).
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

--=-JIlRsR8Y7RUHiSR/xBlp
Content-Disposition: attachment; filename=patch-EagleTec113-2.6.6
Content-Type: text/plain; name=patch-EagleTec113-2.6.6; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

--- drivers/usb/storage/unusual_devs.h.orig	2004-06-05 18:59:00.932141216 +0200
+++ drivers/usb/storage/unusual_devs.h	2004-06-05 19:01:22.818571200 +0200
@@ -417,6 +417,20 @@ UNUSUAL_DEV(  0x05e3, 0x0702, 0x0000, 0x
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_INQUIRY ),
 
+/* Reported by Tobias Weisserth <tobias@weisserth.org>
+ * Like the SIIG unit above, this unit needs an INQUIRY to ask for exactly
+ * 36 bytes of data.  No more, no less. That is the only reason this entry
+ * is needed.
+ *
+ * This entry is an exact copy of the above entry with a different
+ * firmware revision (1.13).
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

--=-JIlRsR8Y7RUHiSR/xBlp--

