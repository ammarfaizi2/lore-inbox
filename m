Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264006AbUDQSQq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 14:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264013AbUDQSQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 14:16:46 -0400
Received: from relay1.eltel.net ([195.209.236.38]:58767 "EHLO relay1.eltel.net")
	by vger.kernel.org with ESMTP id S264006AbUDQSQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 14:16:42 -0400
Date: Sat, 17 Apr 2004 22:16:38 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: linux-kernel@vger.kernel.org
Subject: drivers/input/tsdev.c patch
Message-Id: <20040417221638.5d035e04.zap@homelink.ru>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've tried to use the tsdev.c driver to emulate the old-style Compaq
touchscreen protocol on a newer kernel (I'm working on kernel 2.6.3-hh2,
handhelds.org' branch). But I've observed that the driver is half-complete,
contains some very bad bugs and lacks features to make it useable.

To avoid clobbering this high-volume list, I've posted my patch at
http://zap.eltrast.ru/data/tsdev.diff (~12K). Here's what it tries to achieve:

- Not only emulates the protocol of the old /dev/h3600_ts device (via
/dev/input/ts[0-7]), but also creates an additional device node
/dev/input/tsraw[0-7] which emulates the protocol of the old h3600_tsraw
device. Some old applications needs one, some another, some both.

- Support the ioctls for setting the calibration parameters. The default
calibration matrix is computed from the xres,yres parameters (the old
behaviour), however this is not enough for a good translation from touchscreen
space to screen space.

- Fixed a old bug in tsdev that made the driver basically unusable for any
serious work. The bug was that if old coordinates were X1,Y1 and new
coordinates are X2,Y2, the driver would output to user space a series of
three events with coordinates: X1,Y1 X2,Y1 X2,Y2. This happened not only
with coordinates, but with pressure too. Thus the output of the device was
pretty much unusable. I doubt someone was able to use the old tsdev device
successfuly, if someone did, tell me how.

--
Greetings,
   Andrew

P.S. Please cc: to me while replying since I'm not subscribed to this list due
to its high volume. If a discussion would start on this topic, I'll subscribe
but I don't think so due to limited useability of the old driver.
