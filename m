Return-Path: <linux-kernel-owner+w=401wt.eu-S1754725AbWL0UOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbWL0UOa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 15:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754724AbWL0UOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 15:14:30 -0500
Received: from rrcs-71-40-84-210.sw.biz.rr.com ([71.40.84.210]:39843 "EHLO
	hamlet.sw.biz.rr.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754709AbWL0UO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 15:14:29 -0500
X-Greylist: delayed 1408 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Dec 2006 15:14:29 EST
To: linux-kernel@vger.kernel.org
Subject: The Input Layer and the Serial Port 
Cc: loye.young@iycc.net
Message-Id: <20061227195433.872F03FC063@hamlet.sw.biz.rr.com>
Date: Wed, 27 Dec 2006 13:54:33 -0600 (CST)
From: loyeyoung@iycc.net (Loye Young)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To the King of Penguins and the Wise Architects of the Kernel:

Greetings and Smooth Compiling to All,

I, a humble pilgrim in the Land of Tux, have spent over a year seeking a simple answer to what seems to me a simple question: How do I expose my RS232 barcode scanner to the input layer so that the scanned information shows up in applications? Basically, I need the scanner to act like another keyboard. Scan a code, see the numbers. 

This can't be difficult. I must be overlooking something. Every cash register in America has a barcode scanner. Surely SOME of them must run Linux or Unix. Someone out there knows something I don't. The lowly serial port is still very much a fact of life in industry. I believe I recall reading the judgment of The King of Penguins himself that the kernel must continue support for serial ports generally, and barcode scanners in particular, but I can't find the edict now so maybe my memory is playing tricks on me.

Reading ASCII characters coming in the serial port should be as easy as selling donuts to cops. I have learned, however, that when it comes to the Mysteries of the Kernel, simple answers are sometimes hard to find.

+I have studied the writings of the Weekly Pundit, Little Redstone, and the One-With-Two-Last-Names. http://lwn.net/Kernel/LDD3.
+I have consulted the Oracles of Mepis. http://www.mepis.org/node/9104.
+I have wandered in the Valley of X. http://lists.freedesktop.org/archives/xorg/2006-December/020579.html.
+I have read under the Scribe of the Text Terminal How-To. http://www.linux.com/howtos/Text-Terminal-HOWTO.shtml
+I have been to the Source. /usr/src/linux-source-2.6.17/drivers/input/*.
+I have searched the chronicles of the children of Debra and Ian. http://lists.debian.org/search.html

Alas and alack, knowledge of the secret still eludes me, and I am not alone. What follows is a partial list of what I have found.

Apparently, the input layer has been cussed and discussed for several years now. See, e.g., http://linuxconsole.sourceforge.net/input/input.html (2000), http://kerneltrap.org/node/2947 (2004), http://kerneltrap.org/node/2199 (2004), http://www.frogmouth.net/hid-doco/linux-hid.html (??). I have found no final announcement of "The Way Things Are" or "The Way Things Ought To Be," however. The USB bus admittedly provides a much more robust technical platform upon which to build new devices, and it is well documented and integrated into the input layer. http://www.usb.org/developers/hidpage/.

Vojtech Pavlik has written a plethora of input device drivers for the serial port, and much of the input layer itself. His work on the joystick included inputattach. Although the man page says it is to "attach a serial line to a joystick device," inputattach also configures a variety of serial character devices. Unfortunately, inputattach has options for specific brands of devices (re-mapping various keys and functions), but doesn't have a generic character input device option that I can tell. When I read the source code, I see that generic keycodes are in the code, but each option changes the generic list in some way. (Is it mere coincidence that VP is from a land that limits the use of vowels? Does the path to understanding input run through Prague? Is Alan Cox really the alter ego of the evil leader of the underground gnomes? Mysteries too great for me.)

"Do you pine for the days when men were men and wrote their own device drivers?"

I wish that I knew how to program in C, and that I knew how to recompile the kernel. If I did, I could probably write the "trivial keyboard driver" that has been suggested. http://lists.freedesktop.org/archives/xorg/2006-December/020596.html. I'd probably even make a patch to inputattach or some other userspace program to bring barcode scanners to Linux. I might even would write a generic driver specifically for barcodes. But C is Greek to me. Besides, it is a language so holy that it cannot be spoken.

I may be quacking up the wrong tree. (Do penguins quack? Squawk? Yet another mystery . . .) The kernel's serial driver seems to work just fine. If I issue from the command line "cat /dev/ttyS0" and then scan something, I get my numbers. (I did have to wander around in the dark for many months until I found that stty must throttle the port speed down to 9600.) However, seeing the number in the console doesn't help me much. I need the information in applications.

If the input layer recognized the data coming in through the serial port as data from an input device (or if I could somehow tell it to do so), and if it showed up as an event under /dev/input/, I could use evdev to send the information through the X server as an InputDevice. But I don't know how to tell evdev what to do, and I can't find documentation that tells me how.

There is much written about the big fracas over the CueCat scanner, which was a serial barcode scanner, but the related drivers around are special to it. (The CueCat scanner even has its own documented device name "/dev/scanners/cuecat" and "major/minor number 10/199". http://public.www.planetmirror.com/pub/linux/docs/device-list/?fl=l) There is an old driver "linbar" from 1999, but it only works for a console and it doesn't do anything in 2.6. Most of the links to it are dead.

I must emphasize that I in no way intend any criticism towards anyone. My problem is trivial in the grand scheme of things, and I am extremely grateful to those who have built the Shining Kernel on the Hill. (World domination being a worthy cause, sharks with lasers notwithstanding.)

Oh great King of the Land of Tux! Have mercy on me, your most unlearned and unworthy user!

May Tux Live Forever,

Loye Young
Laredo, Texas

PS - [solemn look on face, right hand on Bible, left hand raised, typing with nose] I certify, under penalty of exile from the Land of Tux, that I have read, marked, and inwardly digested the mailing list FAQ. http://www.tux.org/lkml/.
rial driver seems to work just fine. If I issue from the command line "cat /dev/ttyS0" and then scan something, I get my numbers. (I did have to wander around in the dark for many months until I found that stty must throttle the port speed down to 9600.) However, seeing the number in the console doesn't help me much. I need the information in applications.

If the input layer recognized the data coming in through the serial port as data from an input device (or if I could somehow tell it to do so), and if it showed up as an event under /dev/input/, I could use evdev to send the information through the X server as an InputDevice. But I don't know how to tell evdev what to do, and I can't find documentation that tells me how.

There is much written about the big fracas over the CueCat scanner, which was a serial barcode scanner, but the related drivers around are special to it. (The CueCat scanner even has its own documented device name "/dev/scanners/cuecat" and "major/minor number 10/199". http://public.www.planetmirror.com/pub/linux/docs/device-list/?fl=l) There is an old driver "linbar" from 1999, but it only works for a console and it doesn't do anything in 2.6. Most of the links to it are dead.

I must emphasize that I in no way intend any criticism towards anyone. My problem is trivial in the grand scheme of things, and I am extremely grateful to those who have built the Shining Kernel on the Hill. (World domination being a worthy cause, sharks with lasers notwithstanding.)

Oh great King of the Land of Tux! Have mercy on me, your most unlearned and unworthy user!

May Tux Live Forever,

Loye Young
Laredo, Texas

PS - [solemn look on face, right hand on Bible, left hand raised, typing with nose] I certify, under penalty of exile from the Land of Tux, that I have read, marked, and inwardly digested the mailing list FAQ. http://www.tux.org/lkml/.

