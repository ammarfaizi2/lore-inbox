Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262956AbSJBDz0>; Tue, 1 Oct 2002 23:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262958AbSJBDz0>; Tue, 1 Oct 2002 23:55:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19139 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262956AbSJBDzZ>;
	Tue, 1 Oct 2002 23:55:25 -0400
Date: Tue, 01 Oct 2002 20:53:50 -0700 (PDT)
Message-Id: <20021001.205350.70210581.davem@redhat.com>
To: viro@math.psu.edu
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: 2.5.39 + evms 1.2.0 burn test
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0210012349280.9782-100000@weyl.math.psu.edu>
References: <20021001.203131.48516382.davem@redhat.com>
	<Pine.GSO.4.21.0210012349280.9782-100000@weyl.math.psu.edu>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alexander Viro <viro@math.psu.edu>
   Date: Tue, 1 Oct 2002 23:53:40 -0400 (EDT)
   
   On Tue, 1 Oct 2002, David S. Miller wrote:
   
   > sed 's/usb_kbd_free_buffers/usb_kbd_free_mem/' <usbkbd.c >usbkbd_fixed.c
   
   's/usb_kbd_free_buffers/usb_kbd_free_mem/g', surely?
   
My version works here. :-)

? sed 's/usb_kbd_free_buffers/usb_kbd_free_mem/' <usbkbd.c >usbkbd_fixed.c
? diff -u usbkbd.c usbkbd_fixed.c
--- usbkbd.c    Tue Oct  1 14:49:22 2002
+++ usbkbd_fixed.c      Tue Oct  1 20:56:21 2002
@@ -280,7 +280,7 @@

        if (!(buf = kmalloc(63, GFP_KERNEL))) {
                usb_free_urb(kbd->irq);
-               usb_kbd_free_buffers(dev, kbd);
+               usb_kbd_free_mem(dev, kbd);
                kfree(kbd);
                return -ENOMEM;
        }
@@ -321,7 +321,7 @@
        if (kbd) {
                usb_unlink_urb(kbd->irq);
                input_unregister_device(&kbd->dev);
-               usb_kbd_free_buffers(interface_to_usbdev(intf), kbd);
+               usb_kbd_free_mem(interface_to_usbdev(intf), kbd);
                kfree(kbd);
        }
 }
? 
