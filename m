Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129258AbRBGGi6>; Wed, 7 Feb 2001 01:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbRBGGis>; Wed, 7 Feb 2001 01:38:48 -0500
Received: from mail11.jump.net ([206.196.91.11]:12511 "EHLO mail11.jump.net")
	by vger.kernel.org with ESMTP id <S129258AbRBGGim>;
	Wed, 7 Feb 2001 01:38:42 -0500
Message-ID: <3A80ED7C.F3A92D5@sgi.com>
Date: Wed, 07 Feb 2001 00:38:52 -0600
From: Eric Sandeen <sandeen@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-XFS i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] updates for KLSI usb->ethernet
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, against 2.4.1-ac4, does the following for the KLSI
USB->ethernet adapter:

(patch at http://lager.dyndns.org/kaweth/KLSI-2.4.1-ac4.patch.bz2)

o Fixes firmware downloading.  If firmware is already loaded
  and an attempt is made to download it again, the device
  will hang.  This will happen on a warm boot. Driver now 
  checks the bcdDevice value, which changes after firmware 
  is loaded.  It does this via usb_get_device_descriptor() 
  to avoid caching.  If device already has firmware, it will 
  skip the download.

o Reports bcdDevice revision in debugging messages

o Updates firmware revision, fresh from KLSI

o Actually _uses_ interrupt parameter passed to
  kaweth_trigger_firmware()

o added function prototype for 
  kaweth_internal_control_msg() to avoid warning

o spells "receive" correctly.  :)

There is another way to handle the firmware download check - there is a
chunk of firmware which can be downloaded that causes the device to
disconnect, wait, then reconnect to the USB bus.  When it reappears, it
has the new bcdDevice value in the descriptor.

This might be a better way to go, so that the device descriptor doesn't
silently change.  I've also seen some errors when I try to re-read the
device descriptor with usb_get_device_descriptor(), for some reason.

Any thoughts on what would be more correct, 

a) device descriptor silently changes
b) device magically disconnects/reconnects on its own

Both seem a bit odd, but take your pick.  :)

-Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
