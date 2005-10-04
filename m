Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVJDHEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVJDHEA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 03:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVJDHEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 03:04:00 -0400
Received: from tumsa.unibanka.lv ([193.178.151.91]:17322 "EHLO fax.unibanka.lv")
	by vger.kernel.org with ESMTP id S932446AbVJDHD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 03:03:59 -0400
From: Aivils Stoss <aivils@unibanka.lv>
To: linux-kernel@vger.kernel.org
Subject: faketty - another input module for TTY emulation
Date: Tue, 4 Oct 2005 10:06:35 +0300
User-Agent: KMail/1.7.2
Cc: linuxconsole-dev@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041006.37147.aivils@unibanka.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,All!

Current X server uses TTY mostly to get character on
keyboard key press. I was decide to merge evdev.c,
keyboard.c, vt_ioctl.c and create simple handler, which
is capable send character from keyboard to X server.

Input layer allow us register unlimited count of
handlers. All these handlers recieve events from input
device drivers and send output to device files or
kernel subsytems. faketty register new input handler
named ftty and send characters from keyboard to
device files /dev/input/fttyXX. fttyXX device files
is created for X server. All unnecessary features
are deleted:
No VT switch,
No text mode,
No terminal-io or VT ioctl's.
ftty ioctl's will work for keyboard rate and beeper.
Files /dev/input/fttyXX will be created for each
keyboard or speaker device. On fttyXX open keyboard
disconnected from normal text console and send keypress
events to fttyXX opener application only. So each
keyboard is separate now.

faketty is designed for peoples which will run multiple
X servers, each for another user, at same time on one linux box.
You can cheat X very simple:
modprobe faketty
rm -f /dev/tty50
ln -s /dev/input/ftty0 /dev/tty50
startx -- vt50
Now X uses keyboard via ftty. If multiple keyboards are
pluged in, just choose right fttyXX file. Take a look into
/proc/bus/input/devices.

http://www.ltn.lv/~aivils/files/faketty-0.04.tar.bz2

Of course You can reach same result if X server does not
touch /dev/ttyXX at all, but uses his own evdev drivers.
Current X allways uses TTY.

Aivils Stoss
