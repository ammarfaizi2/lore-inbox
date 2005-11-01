Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbVKAIPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVKAIPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVKAIPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:15:42 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:2972 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964983AbVKAIPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:15:36 -0500
Message-ID: <43672406.7010709@m1k.net>
Date: Tue, 01 Nov 2005 03:15:02 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 23/37] dvb: Updated documentation for FusionHDTV Lite cards
Content-Type: multipart/mixed;
 boundary="------------040706020601010904030707"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040706020601010904030707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------040706020601010904030707
Content-Type: text/x-patch;
 name="2393.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2393.patch"

- Updated documentation for FusionHDTV Lite cards. We must differentiate
  the bt8xx based "Lite" cards from the cx2388x based "Gold" cards.

- Provide location of CARDLIST.bttv Documentation, rather than
  instructing users to look at bttv.h

- Include card decimal id numbers. These are valid for module arguments,
  and might be easier for some people to remember, rather than hex.

  Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 Documentation/dvb/bt8xx.txt |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

--- linux-2.6.14-git3.orig/Documentation/dvb/bt8xx.txt
+++ linux-2.6.14-git3/Documentation/dvb/bt8xx.txt
@@ -1,5 +1,5 @@
-How to get the Nebula, PCTV and Twinhan DST cards working
-=========================================================
+How to get the Nebula, PCTV, FusionHDTV Lite and Twinhan DST cards working
+==========================================================================
 
 This class of cards has a bt878a as the PCI interface, and
 require the bttv driver.
@@ -26,11 +26,12 @@
 
 In general you need to load the bttv driver, which will handle the gpio and
 i2c communication for us, plus the common dvb-bt8xx device driver.
-The frontends for Nebula (nxt6000), Pinnacle PCTV (cx24110) and
-TwinHan (dst) are loaded automatically by the dvb-bt8xx device driver.
+The frontends for Nebula (nxt6000), Pinnacle PCTV (cx24110), TwinHan (dst),
+FusionHDTV DVB-T Lite (mt352) and FusionHDTV5 Lite (lgdt330x) are loaded
+automatically by the dvb-bt8xx device driver.
 
-3a) Nebula / Pinnacle PCTV
---------------------------
+3a) Nebula / Pinnacle PCTV / FusionHDTV Lite
+---------------------------------------------
 
    $ modprobe bttv (normally bttv is being loaded automatically by kmod)
    $ modprobe dvb-bt8xx
@@ -67,8 +68,8 @@
 dst_addons takes values 0 and 0x20. A value of 0 means it is a FTA card.
 0x20 means it has a Conditional Access slot.
 
-The autodected values are determined bythe cards 'response
-string' which you can see in your logs e.g.
+The autodetected values are determined by the cards 'response string'
+which you can see in your logs e.g.
 
 dst_get_device_id: Recognise [DSTMCI]
 
@@ -84,25 +85,29 @@
 the bttv module with the card id. This would help to solve any module loading
 problems that you might face.
 
-for example, if you happen to have a Twinhan and clones alongwith a FusionHDTV5
-card
+For example, if you have a Twinhan and Clones card along with a FusionHDTV5 Lite
 
 	$ modprobe bttv card=0x71 card=0x87
 
 Here the order of the card id is important and should be the same as that of the
 physical order of the cards. Here card=0x71 represents the Twinhan and clones
-and card=0x87 represents Fusion HDTV5.
+and card=0x87 represents Fusion HDTV5 Lite. These arguments can also be
+specified in decimal, rather than hex:
+
+	$ modprobe bttv card=113 card=135
 
 Some examples of card-id's
 
-Pinnacle Sat		0x5e
-Nebula Digi TV		0x68
-PC HDTV			0x70
-Twinhan			0x71
-Fusion HDTV5		0x87
+Pinnacle Sat		0x5e  (94)
+Nebula Digi TV		0x68  (104)
+PC HDTV			0x70  (112)
+Twinhan			0x71  (113)
+FusionHDTV DVB-T Lite	0x80  (128)
+FusionHDTV5 Lite	0x87  (135)
+
+For a full list of card-id's, see the V4L Documentation within the kernel
+source:  linux/Documentation/video4linux/CARDLIST.bttv
 
-For a full list of card-id's, you can see the exported card-id's from
-bttv-cards.c in linux-2.6.x/drivers/media/video/bttv.h
 If you have problems with this please do ask on the mailing list.
 
 --



--------------040706020601010904030707--
