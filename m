Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbTAXHHu>; Fri, 24 Jan 2003 02:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267578AbTAXHHu>; Fri, 24 Jan 2003 02:07:50 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:19722 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S267577AbTAXHHt>; Fri, 24 Jan 2003 02:07:49 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Fri, 24 Jan 2003 08:17:44 +0100
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-14518
Subject: 2.4.19: drivers/usb/wacom.c: Intuos tablet broken
Message-ID: <3E30F658.5317.108EE8@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
X-Content-Conformance: HerringScan-0.13/Sophos-3.65+2.10+2.03.098+06 January 2003+79052@20030124.071149Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-14518
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

Hello,

my apologies if that's old news, but I had reported the effect 
that my Intuos GD-1212 that worked with SuSE-8.0 (2.4.18) no 
longer worked with SuSE-8.1 (2.4.19). The bug was knows at SuSE 
as #22403, but they were unable to provide a solution so far.

Thus I did a diff to the kernel sources. It seems that the 
change in drivers/usb/wacom.c from RCS revision .122 to 1.23 
(made by vijtech@suse.cz) broke detection of move events in an 
obvious way (see lines 241 in 2.4.18 and lines 285 in 2.4.19):

wacom->x and wacom->y are no longer set in 2.4.19!

I'll attach my suggested fix (not tested).

Regards,
Ulrich Windl
P.S. I failed to get any programming info from Wacom, even if 
the documentation provided with the tablet said Wacom would 
support developers. If anybody here knows a source of 
information, please tell me...


--Message-Boundary-14518
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'wacom.diff'

--- wacom.c	2002-08-18 22:11:08.000000000 +0200
+++ wacom.c.new	2003-01-23 19:47:19.000000000 +0100
@@ -288,8 +288,8 @@
 	x = ((__u32)data[2] << 8) | data[3];
 	y = ((__u32)data[4] << 8) | data[5];
 	
-	input_report_abs(dev, ABS_X, wacom->x);
-	input_report_abs(dev, ABS_Y, wacom->y);
+	input_report_abs(dev, ABS_X, wacom->x = x);
+	input_report_abs(dev, ABS_Y, wacom->y = y);
 	input_report_abs(dev, ABS_DISTANCE, data[9] >> 4);
 	
 	if ((data[1] & 0xb8) == 0xa0) {						/* general pen packet */

--Message-Boundary-14518--
