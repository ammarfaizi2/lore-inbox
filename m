Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130376AbQK3G2n>; Thu, 30 Nov 2000 01:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130875AbQK3G2e>; Thu, 30 Nov 2000 01:28:34 -0500
Received: from rvrplc-004.por.or.bbnow.net ([24.219.13.61]:62221 "HELO
        kroah.com") by vger.kernel.org with SMTP id <S130376AbQK3G20>;
        Thu, 30 Nov 2000 01:28:26 -0500
Date: Wed, 29 Nov 2000 21:54:50 -0800
From: Greg KH <greg@kroah.com>
To: Rick Haines <rick@kuroyi.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb-devel@sourceforge.net
Subject: Re: [linux-usb-devel] Re: test12-pre3 (broke my usb)
Message-ID: <20001129215450.A19398@kroah.com>
In-Reply-To: <Pine.LNX.4.10.10011282248530.6275-100000@penguin.transmeta.com> <20001129183834.A443@sasami.kuroyi.net> <3A259FA2.1A46298E@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A259FA2.1A46298E@linux.com>; from david@linux.com on Wed, Nov 29, 2000 at 04:30:26PM -0800
X-Operating-System: Linux 2.2.14-12 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Nov 29 17:12:14 sasami kernel: usb_control/bulk_msg: timeout
> > Nov 29 17:12:14 sasami kernel: usb.c: USB device not accepting new address=6 (error=-110)

This message is now showing up for a lot of people.
I think we need to change the source to have it say what is really
happening:


diff -Naur -X dontdiff linux-2.4.0-test11/drivers/usb/usb.c linux-2.4.0-test11-greg/drivers/usb/usb.c
--- linux-2.4.0-test11/drivers/usb/usb.c	Fri Nov 24 16:19:36 2000
+++ linux-2.4.0-test11-greg/drivers/usb/usb.c	Wed Nov 29 21:55:38 2000
@@ -2008,7 +2008,8 @@
 
 	err = usb_set_address(dev);
 	if (err < 0) {
-		err("USB device not accepting new address=%d (error=%d)",
+		err("USB device not accepting new address=%d (error=%d), "
+		    "host controller probably not getting any interrupts",
 			dev->devnum, err);
 		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
 		dev->devnum = -1;



greg k-h

-- 
greg@(kroah|wirex).com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
