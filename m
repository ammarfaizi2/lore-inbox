Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281780AbRKSFgy>; Mon, 19 Nov 2001 00:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281889AbRKSFgn>; Mon, 19 Nov 2001 00:36:43 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:55838 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S281780AbRKSFg3>; Mon, 19 Nov 2001 00:36:29 -0500
Message-ID: <3BF89B8D.BDE2DB1F@mindspring.com>
Date: Sun, 18 Nov 2001 21:41:33 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 cpia driver IS broke
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier this week I reported cpia driver not finidng the /dev/video0 as
a bug.  I did a little research and at first I thought it was RH 7.2 or
the linux kernel, but it is not RH it is the linux kernel.  The cpia
driver in 2.4.14 is broke! (at least on my system)

This is the driver for the webcam II parallel port module.

(From 2.4.13) The output of the file /proc/cpia/video0 should show the
following:

 cat /proc/cpia/video0 |head
read-only
-----------------------
V4L Driver version:       0.7.4
CPIA Version:             1.20 (1.0)
CPIA PnP-ID:              0553:0002:0100
VP-Version:               1.0 0100
system_state:             0x02
grab_state:               0x00
stream_state:             0x00
fatal_error:              0x00
Current Directory = ~

but it does not, in fact in 2.4.14 it shows CPIA Version:  0.00 and
everything else is 0 as well.

I have reverted back to 2.4.13 but would like to let the maintainers
know.  If you look at the 2.4.14 patch the code for the cpia driver has
changed.  I am not sure if it is the cpia driver itselef or the video
subsystem (v4l/v4l2).  If anyone knows how to contact the maintainers
and let them know that this code is not working great.

zcat /public/untarred/patch-2.4.14.gz |grep cpia |head
diff -u --recursive --new-file v2.4.13/linux/drivers/media/video/cpia.c
linux/drivers/media/video/cpia.c
--- v2.4.13/linux/drivers/media/video/cpia.c Tue Oct  9 17:06:51 2001
+++ linux/drivers/media/video/cpia.c Thu Oct 25 13:53:47 2001
- proc_cpia_create();
- request_module("cpia_pp");
- request_module("cpia_usb");

oh I am not on the list
thanks
Joe

