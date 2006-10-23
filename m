Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWJWT0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWJWT0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWJWT0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:26:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:27564 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965091AbWJWT0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:26:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=UGK7JT3Rag3VD0PMwKRspA40YZQaEbbT8LY47QpiUDejsqDypdNX+ieNmieej735hEEsb9Ef7m+9KBJgI9af4A+IHSqha6a5fFukztONCgvRhdG4bk4fFPuQOpRMN/AyV6d409+/ivXLgtBWhqYXZ0T+AhHuSPPEjtm6/24T4S4=
Message-ID: <727e50150610231226p42b95cc4j686b31332c1d1c6e@mail.gmail.com>
Date: Mon, 23 Oct 2006 15:26:14 -0400
From: "Aaron Cohen" <aaron@assonance.org>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Ordering hotplug scripts vs. udev device node creation
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 05df3c6ab8b19149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I sent this email to the linux kernel mailing list a couple of days
ago so the first couple of paragraphs may seem familiary to someone
who reads both lists.  I just found the hotplug list though, and have
some new details added.)

I'm trying to modify the gpsd hotplug script to work better with my
udev setup.  My USB serial devices are added to /dev/tts/USBx by udev
and the default script assumes they are /dev/ttyUSBx.

In any event, my hotplug script uses udevinfo to figure out the device
file to use.  The problem seems to be though that my hotplug script is
getting run before udev has actually created the device node.  Is
there some ordering mechanism I'm missing that would help me out here?

I am now using udev rules exclusively rather than old-style hotplug
rules.  I've created a file in /etc/udev/rules.d called 51-gpsd.rules
which contains:

KERNEL=="ttyUSB[0-9]*", RUN+="/lib/udev/gpsd"

/lib/udev/gpsd is my script that runs udevinfo to figure out the /dev/
file to use and communicates this to gpsd through a control socket.

Adding a USB device seems to work correctly (more or less, my script
is invoked a few too many times but I think I can figure out how to
adjust my rule) using this.  I'm having trouble now with removal
though.  By the time my script runs the device file has been removed
by udev and I can't look it up through udevinfo any longer.  I need to
know what the name of the device file was so I can tell gpsd to stop
monitoring it.

Any ideas?

Thanks,
Aaron
