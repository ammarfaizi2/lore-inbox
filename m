Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUFBWAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUFBWAW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 18:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUFBWAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 18:00:22 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:11937 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262438AbUFBWAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 18:00:10 -0400
Subject: Re: [Linux 2.6.4] EagleTec (rev 1.13) USB external harddisk
	support -> patch to unusual_devs.h
From: Tobias Weisserth <tobias@weisserth.org>
Reply-To: tobias@weisserth.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040602203307.GA19749@kroah.com>
References: <1086086759.10599.14.camel@coruscant.weisserth.net>
	 <20040602165723.GI7829@kroah.com>
	 <1086200163.8709.8.camel@coruscant.weisserth.net>
	 <20040602182131.GA13193@kroah.com>
	 <1086207977.8707.38.camel@coruscant.weisserth.net>
	 <20040602203307.GA19749@kroah.com>
Content-Type: text/plain
Message-Id: <1086213609.8710.79.camel@coruscant.weisserth.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 03 Jun 2004 00:00:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, 2004-06-02 at 22:33, Greg KH wrote:
...
> The patch got line-wrapped :(

Darn Evolution.

OK. Let's try again:

############################

--- drivers/usb/storage/unusual_devs.h.orig	2004-06-02
21:53:18.292064768 +0200
+++ drivers/usb/storage/unusual_devs.h	2004-06-02 22:00:39.486992944
+0200
@@ -409,6 +409,17 @@ UNUSUAL_DEV(  0x05e3, 0x0702, 0x0000, 0x
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_INQUIRY ),
 
+/* Reported by Tobias Weisserth <tobias@weisserth.org>
+ * Some EagleTec devices don't work with the other 
+ * entry for EagleTec. EagleTec devices with
+ * revision 1.13 like the "Pocket Boy" 
+ * need a slight adjustment.
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

########################

> Care to try it again?

Sure. But the first line seems to be wrapped already on my screen :-(

This time I inserted the content directly from the text file and not the
clipboard. I don't know whether this makes a difference though.
Evolution doesn't have an option to set the number of characters per
line or I'm just too stupid to find it :-(

In case this gets screwed too, might I consider sending it along as a
text attachment?

> > The patch applies to version 2.6.4 from www.kernel.org. It also works
> > with Con Kolivas' sources version 2.6.4. I guess if all the symbols that
> > are being used in the unit entry haven't disappeared from later kernel
> > versions then it can be applied to later (or earlier) versions as well.
> 
> You might want to see if the patch is still needed on 2.6.6 as that is
> the latest kernel.  I need a diff against that kernel version.

Now I have a problem. 2.6.6 won't run with the same .config as 2.6.4
after running "make oldconfig" on my system for some reason. I haven't
found out yet why. It boots but when it comes to the part where it goes
through the IDE devices it stops with some kind of driveSeekError and
panics.

I've taken a look into drivers/usb/storage/unusual_devs.h from 2.6.6 and
I noticed that the EagleTec entry from 2.6.4 has disappeared completely.

There's this though:

UNUSUAL_DEV(  0x05e3, 0x0702, 0x0000, 0xffff,
                "Genesys Logic",
                "USB to IDE Disk",
                US_SC_DEVICE, US_PR_DEVICE, NULL,
                US_FL_FIX_INQUIRY ),

It uses the same vendor ID and is completely identical to the original
EagleTec entry in 2.6.4 and might just work by changing "0x0000,
0xffff," to "0x0113, 0x0113,". I can't confirm though without a working
2.6.6 kernel but it *should* work like this since if the Genesys Logic
entry is still inside unusual_devs.h for the reason the comment states,
the same *should* apply to my EagleTec device with the same vendor ID as
the original EagleTec entry is just a duplicate of this one, including
the comment.

I can make these changes to 2.6.6 for now and create a diff output, run
make to see whether it compiles but I can't test it. Does this help?

I'll try to sort out my 2.6.6 issues on Monday as I have an exam on
Friday and one on Monday. After those my mind is free for solving kernel
issues :-/

kind regards,
Tobias Weisserth

