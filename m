Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277705AbRJKAgr>; Wed, 10 Oct 2001 20:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277811AbRJKAgh>; Wed, 10 Oct 2001 20:36:37 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:20997 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S277705AbRJKAgb>;
	Wed, 10 Oct 2001 20:36:31 -0400
Date: Thu, 11 Oct 2001 02:36:47 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Harald Schreiber <harald@harald-schreiber.de>
Cc: mdharm-usb@one-eyed-alien.net, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] USB Support for recent Casio Digital Still Cameras, linux-2.4.11
Message-ID: <20011011023647.A14615@gondor.com>
In-Reply-To: <m3elobqblf.fsf@harald-schreiber.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3elobqblf.fsf@harald-schreiber.de>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 02:11:56AM +0200, Harald Schreiber wrote:
> Recent Casio QV digital still cameras (for example the QV 4000)
> show up as 
> VendorID: 0x07cf  ProductID: 0x1001  Revision: 10.00
> 
> So the following patch is necessary to make these devices working
> with the USB storage driver. The patch is against linux-2.4.11,
> but it should work with any kernel since 2.4.8-pre3.

Confirmed. I sent the same patch (without the comments) to linux-kernel
three days ago.

BTW, perhaps it would be better to patch the thing the following way,
because I don't know what's in the revision number range between
1000 and 9009, perhaps there are other devices which don't like the
workaround?


--- linux-2.4.9-ac10/drivers/usb/storage/unusual_devs.h	Sat Sep  8 18:18:51 2001
+++ linux-2.4.10-ac11/drivers/usb/storage/unusual_devs.h	Thu Oct 11 02:11:29 2001
@@ -394,6 +394,12 @@
  * - They don't like the INQUIRY command. So we must handle this command
  *   of the SCSI layer ourselves.
  */
+UNUSUAL_DEV( 0x07cf, 0x1001, 0x1000, 0x1000,
+                "Casio",
+                "QV DigitalCamera",
+                US_SC_8070, US_PR_CB, NULL,
+                US_FL_FIX_INQUIRY ),
+
 UNUSUAL_DEV( 0x07cf, 0x1001, 0x9009, 0x9009,
                 "Casio",
                 "QV DigitalCamera",

> --------------------------------------------------------------------
> Dipl.-Math. Harald Schreiber, Nizzaallee 26, D-52072 Aachen, Germany
> Phone/Fax: +49-241-9108015/6       mailto:harald@harald-schreiber.de
> --------------------------------------------------------------------

Interesting, twice the same patch, and then from nearly the same location
in the world. (Roermonder Str. 112a - distance several 100m )

Jan

