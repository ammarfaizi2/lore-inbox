Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUDEILH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 04:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUDEILH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 04:11:07 -0400
Received: from mail1.kontent.de ([81.88.34.36]:6793 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262238AbUDEIKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 04:10:51 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Robert White" <rwhite@casabyte.com>,
       "'Pete Zaitcev'" <zaitcev@redhat.com>
Subject: Re: [linux-usb-devel] [PATCH] (linux 2.4.25) hangup on disconnect for usbserial module
Date: Mon, 5 Apr 2004 10:10:46 +0200
User-Agent: KMail/1.5.1
Cc: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA9BOg2suQOk2BJuklNeZkhAEAAAAA@casabyte.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA9BOg2suQOk2BJuklNeZkhAEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404051010.47141.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 5. April 2004 07:49 schrieb Robert White:
> Pasting the whole program is impractical, so here is the psudocode
>
> Open /dev/usb/ttyUSB0
> Build Poll structure with events = POLLIN for this descriptor
> Call poll(&structure,1,-1)
>
> (Without the patch) If you pull the usb cable out of the computer, the
> program above will never return from the poll.  I was quite surprised,
> especially since this didn't match the behavior of the ACM device that we
> alternately use in our box.  The hang is semi-terminal too, as nothing can
> reattach to the file descriptor from below.

This is clearly unacceptable behavior.

[..]
> The hangup semantic with all its ramifications (sighup if the device is a
> controlling terminal etc.) is "good for me", and matches other kinds of
> (USB and non-USB) devices, but I have no opinion on particular apps.  I
> considered adding an IOCTL and flag to control this but decided against for
> the following reasons:

Unless you want to go for reattaching, which I wouldn't consider a good idea,
I see no other choice.
I did a quick look at the drivers and the other driver hanging there is usb-midi.
I haven't checked the serial drivers not using generic_disconnect() though.

	Regards
		Oliver

