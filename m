Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUDTOUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUDTOUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 10:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUDTOUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 10:20:30 -0400
Received: from zasran.com ([198.144.206.234]:43142 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S263085AbUDTOO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 10:14:58 -0400
Message-ID: <40853060.2060508@bigfoot.com>
Date: Tue, 20 Apr 2004 07:14:56 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: logitech mouseMan wheel doesn't work with 2.6.5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   it looks that after update to 2.6.5 kernel (debian source package but 
I guess it would be the same with stock 2.6.5) the mouse wheel and side 
button on Logitech Cordless MouseMan Wheel mouse do not work.

Here's the most basic/simple situation/symptoms:

   I stop X, read bytes from /dev/psaux (c program, using open and 
read). for each mouse action there are few bytes read, usually number 
(depends on action), 8 (almost all the time, at least for clicks)), few 
zeros. I don't have exact log but here's what it looked like:

   left click:    some number, 8, 0, 0
   middle click:    some number, 8, 0, 0
   right click:    some number, 8, 0, 0
   side button:    middle click number, 8, 0, 0
   wheel clockwise:        8, 0, 0
   wheel counterclockwise:    8, 0, 0

   exact numbers don't matter (I think), the point is that it is not 
possible to tell side button click from middle click and the wheel 
rotation sends same info no matter in which direction the wheel is 
rotated, it seems to miss the first byte that in case of other buttons 
tells what's going on.

   BTW X windows is confused in the same way (I guess because that's 
what it gets from kernel driver - using xev I found that it thinks the 
sidebutton is button 2 and that turning the wheel is not an event at all).

   any ideas how to make kernel understand the mouse better? or is this 
a kernel bug? I've read that kernel now interprets the mouse protocol - 
but there doesn't seem to be a way to indicate to kernel which protocol 
to use...

   system:

   debian unstable
   kernel-source-2.6.5
   logitech cordless mouseMan wheel
   mouse connected via /dev/psaux

   mouse related kernel config:

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
CONFIG_INPUT_MOUSEDEV_PSAUX_ENABLE=y
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set
...
#
# Input Device Drivers
#
...
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y


   the mouse used to work with 2.2 and 2.4 kernels.

   TIA

     erik
