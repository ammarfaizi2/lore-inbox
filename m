Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276634AbRJHAoi>; Sun, 7 Oct 2001 20:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276721AbRJHAo2>; Sun, 7 Oct 2001 20:44:28 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:61705 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S276634AbRJHAoT>;
	Sun, 7 Oct 2001 20:44:19 -0400
Date: Mon, 8 Oct 2001 02:44:40 +0200
From: Jan Niehusmann <jan@gondor.com>
To: mdharm-usb@one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: usb-storage and casio qv-4000 digital camera
Message-ID: <20011008024440.A1242@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(this is against linux-2.4.10-ac8, but should apply to kernels
with similar usb drivers, too)

The casio qv-4000 digital cameras needs the same workarounds
in usb-storage as older casio cameras, but has a different
serial number. Therefore the attached patch is needed to make
the camera work - otherwise, I get a lot of 
"usb_control/bulk_msg: timeout" messages and the device doesn't work.

I think these are the corresponding lines in /proc/bus/usb/devices:

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=07cf ProdID=1001 Rev=10.00
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=05 Prot=00 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=  1ms

As the patch enables the workaround for a fairly huge range of revision
numbers, it may be better to have two distinct lines with smaller
ranges instead of one bug range - I leave this decision to people
who know more about USB than I do ;-)

Jan


--- linux-2.4.10-ac8-usb/drivers/usb/storage/unusual_devs.h.orig	Sun Oct  7 20:29:27 2001
+++ linux-2.4.10-ac8-usb/drivers/usb/storage/unusual_devs.h	Mon Oct  8 01:51:34 2001
@@ -394,7 +394,7 @@
  * - They don't like the INQUIRY command. So we must handle this command
  *   of the SCSI layer ourselves.
  */
-UNUSUAL_DEV( 0x07cf, 0x1001, 0x9009, 0x9009,
+UNUSUAL_DEV( 0x07cf, 0x1001, 0x1000, 0x9009,
                 "Casio",
                 "QV DigitalCamera",
                 US_SC_8070, US_PR_CB, NULL,
