Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUJBN6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUJBN6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 09:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUJBN6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 09:58:23 -0400
Received: from i-r-genius.demon.co.uk ([80.177.6.225]:7362 "EHLO
	i-r-genius.com") by vger.kernel.org with ESMTP id S266175AbUJBN6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 09:58:20 -0400
From: "Tony Howat" <tony@i-r-genius.com>
To: linux-kernel@vger.kernel.org
Subject: Reading ati_remote keypresses in userland
Date: Sat, 2 Oct 2004 14:58:19 +0100
Message-Id: <20041002135118.M79981@i-r-genius.com>
X-Mailer: Open WebMail 2.30 20040131
X-OriginatingIP: 192.168.1.1 (tony)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an ati_ remote, and the ati_remote module loaded, the 2.2.0 version 
with kernel version 2.6.5-1. It works in that I can see data 
on /dev/input/mice when I use the mouse type controls on the remote. However 
I need to use the keyboardish buttons to control my application. 

Having read round it seemed the /dev/input/event devices would be the key. I 
put together some code to find the right event device and dump the output 
from a linux journal article : 

The device on /dev/input/event0 says its name is PS/2 Generic Mouse 
The device on /dev/input/event1 says its name is AT Translated Set 2 
keyboard 
The device on /dev/input/event2 says its name is X10 Wireless Technology Inc 
USB Receiver 
evdev driver version is 1.0.0 

...but there's no output turning up when I read from the file descriptor. 
However, running the module in debug mode does give meaningful output to 
/var/log/messages : 

Sep 28 18:27:44 marmot last message repeated 10 times 
Sep 28 18:27:50 marmot kernel: ati_remote 1-2:1.0: channel 0x0f; data d4,0f; 
index 16; keycode 4 
Sep 28 18:27:51 marmot last message repeated 10 times 
Sep 28 18:27:52 marmot kernel: ati_remote 1-2:1.0: channel 0x0f; data dc,17; 
index 23; keycode 11 
Sep 28 18:27:54 marmot last message repeated 14 times 
Sep 28 18:28:19 marmot kernel: ati_remote 1-2:1.0: channel 0x0f; data c8,03; 
index 33; keycode 148 

I'm a bit confused. Which device should I be looking at for these 
keypresses? Am I missing something? 

My test code is at http://www.i-r-genius.com/remoteend.c

Could anyone confirm exactly which device these keypresses should turn up on 
and the method for reading them?

Thanks for any help. 

The aim of this project is to provide a simple control for music player 
daemon (http://www.musicpd.org/) without the need for X. I will, of course, 
release the code when done. 

--
Tony

