Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311139AbSCHV1G>; Fri, 8 Mar 2002 16:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311133AbSCHV04>; Fri, 8 Mar 2002 16:26:56 -0500
Received: from [62.47.19.142] ([62.47.19.142]:12163 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S311139AbSCHV0r>;
	Fri, 8 Mar 2002 16:26:47 -0500
Message-ID: <3C89273D.28BC97DB@webit.com>
Date: Fri, 08 Mar 2002 22:03:57 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Carl-Johan Kjellander <carljohan@kjellander.com>
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The camera attached to the UHCI-controller running usb-uhci works just 
> fine,out the three attached to the OHCI-controllers running usb-ohci don't. 
> After a random amount of frames being read from a camera the read()-call 
> blocks indefinitely until the device is closed. Next time the v4l-device is 
> opened the program can again read frames from the camera but read() always 
> blocks after some time.

I can't help, but I have the exact same problem here. Closing the
application (eg. camstream) and re-opening it makes it work again for a
while.

As Carl-Johan said, this happens with or without the pwcx module, so
that's not the problem.

I think it's an ohci problem.

Furthermore, the usb driver(s) behave strangely on
connecting/disconnecting the camera. Sometimes this works flawlessly,
sometimes I get a lot of USB timeout ("usb_control/bulk_msg: timeout")
and/or "USBDEVFS_CONTROL failed dev x rqt 128 rq 6 len 490 ret -110"
messages in the syslog. (Kernel is 2.4.16 and 2.4.18 - no difference)
After a couple of times disconnecting and reconnecting the camera it's
being detected. Since 2.4.18, the camera's LED sometimes is on,
sometimes off - seems quite random.

Even closing the cam application (xawtv, camstream) after the camera
stopped working never results in any error messages in the log, I only
read "pwc: Closing video device: xxx frames received, dumped 0 frames, 0
frames with errors"

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com                  *** http://www.webit.com/tw
