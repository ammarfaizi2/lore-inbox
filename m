Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265757AbSKAVWZ>; Fri, 1 Nov 2002 16:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265758AbSKAVWZ>; Fri, 1 Nov 2002 16:22:25 -0500
Received: from ns.suse.de ([213.95.15.193]:6921 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265757AbSKAVWX>;
	Fri, 1 Nov 2002 16:22:23 -0500
Date: Fri, 1 Nov 2002 22:28:52 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Greg KH <greg@kroah.com>
Subject: linux-2.4 cset 1.736.3.2 breaks USB hubs , deadlock
Message-ID: <20021101222852.A5717@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
User-Agent: Lotus Notes Linux/PPC Pre-Release 5.0.1  October 21, 2002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What shoud this patch fix?

It locks up my iBook when attaching an Apple USB keyboard. Other people
reported similar hangs.
Please revert it or find a better solution for 2.4.20.




----- Forwarded message from Olaf Hering <olaf@suse.de> -----

Date: Tue, 15 Oct 2002 06:05:51 +0200
Subject: Incoming changes to linux-2.4 cset 1.736.3.2  mandarine.suse.de:/olaf/sources/tree/linux-2.4 
From: Olaf Hering <olaf@suse.de>
To: olh@suse.de

old status OK
ChangeSet
  1.736.3.2 02/10/11 11:02:13 acme@conectiva.com.br +1 -0
  [PATCH] hid-input: fix find_next_zero_bit usage
  
    It was swapping the parameters, using the bitfield size for the
    offset and the offset for the bitfield size. With this the mouse
    buttons in my wireless USB keyboard finally works 8) 2.4 has the
    same problem.

  drivers/usb/hid-input.c
    1.3 02/10/09 18:26:11 acme@conectiva.com.br[greg] +1 -1
    hid-input: fix find_next_zero_bit usage

.........................................................................
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.736.3.1 -> 1.736.3.2
#	drivers/usb/hid-input.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/11	acme@conectiva.com.br	1.736.3.2
# [PATCH] hid-input: fix find_next_zero_bit usage
# 
#   It was swapping the parameters, using the bitfield size for the
#   offset and the offset for the bitfield size. With this the mouse
#   buttons in my wireless USB keyboard finally works 8) 2.4 has the
#   same problem.
# --------------------------------------------
#
diff -Nru a/drivers/usb/hid-input.c b/drivers/usb/hid-input.c
--- a/drivers/usb/hid-input.c	Tue Oct 15 06:05:50 2002
+++ b/drivers/usb/hid-input.c	Tue Oct 15 06:05:50 2002
@@ -271,7 +271,7 @@
 	set_bit(usage->type, input->evbit);
 
 	while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
-		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
+		usage->code = find_next_zero_bit(bit, usage->code, max + 1);
 	}
 
 	if (usage->code > max) return;
.........................................................................

----- End forwarded message -----

-- 
 $ man Notes

BUGS
       You need http://www.sauerstoff-laden.de/ soon...
