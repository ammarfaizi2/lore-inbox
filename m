Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292589AbSCIHS6>; Sat, 9 Mar 2002 02:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292473AbSCIHRY>; Sat, 9 Mar 2002 02:17:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292475AbSCIHPG>;
	Sat, 9 Mar 2002 02:15:06 -0500
Date: Sat, 9 Mar 2002 03:46:18 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
X-X-Sender: mpc@pc24.sr.bham.ac.uk
To: Thomas Winischhofer <tw@webit.com>
cc: linux-kernel@vger.kernel.org,
        Carl-Johan Kjellander <carljohan@kjellander.com>
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
In-Reply-To: <3C89273D.28BC97DB@webit.com>
Message-ID: <Pine.LNX.4.44.0203090344130.8477-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as a FYI, I had similar trouble using usb-uhci (440BX chipset) to 
a 680K using pwc/pwcx.  I had to add a bunch of error recovery (close 
/ open device, ignore open() failing and retry, etc).

I get a group of EMC messages logged , then the reset seems to take 
quite a while.

(2.4.19-pre2-ac2, but have seem this will many recent 2.4.x kernels)

Mark

On Fri, 8 Mar 2002, Thomas Winischhofer wrote:

> > The camera attached to the UHCI-controller running usb-uhci works just 
> > fine,out the three attached to the OHCI-controllers running usb-ohci don't. 
> > After a random amount of frames being read from a camera the read()-call 
> > blocks indefinitely until the device is closed. Next time the v4l-device is 
> > opened the program can again read frames from the camera but read() always 
> > blocks after some time.
> 
> I can't help, but I have the exact same problem here. Closing the
> application (eg. camstream) and re-opening it makes it work again for a
> while.
> 
> As Carl-Johan said, this happens with or without the pwcx module, so
> that's not the problem.
> 
> I think it's an ohci problem.
> 
> Furthermore, the usb driver(s) behave strangely on
> connecting/disconnecting the camera. Sometimes this works flawlessly,
> sometimes I get a lot of USB timeout ("usb_control/bulk_msg: timeout")
> and/or "USBDEVFS_CONTROL failed dev x rqt 128 rq 6 len 490 ret -110"
> messages in the syslog. (Kernel is 2.4.16 and 2.4.18 - no difference)
> After a couple of times disconnecting and reconnecting the camera it's
> being detected. Since 2.4.18, the camera's LED sometimes is on,
> sometimes off - seems quite random.
> 
> Even closing the cam application (xawtv, camstream) after the camera
> stopped working never results in any error messages in the log, I only
> read "pwc: Closing video device: xxx frames received, dumped 0 frames, 0
> frames with errors"
> 
> Thomas
> 
> 

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+

