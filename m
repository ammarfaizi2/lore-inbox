Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270329AbTGPIUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270415AbTGPIUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:20:24 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:16617 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S270329AbTGPIUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:20:19 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 16 Jul 2003 10:44:48 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Greg KH <greg@kroah.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
Message-ID: <20030716084448.GC27600@bytesex.org>
References: <20030715143119.GB14133@bytesex.org> <20030715212714.GB5458@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715212714.GB5458@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   * some usb webcam drivers (usbvideo.ko, stv680.ko, se401.ko 
> >     and ov511.ko) use the video_proc_entry() to add additional
> >     procfs files.  These drivers must be converted to sysfs too
> >     because video_proc_entry() doesn't exist any more.
> 
> I'd be glad to do this work once your change makes it into the core.  Is
> there any need for these drivers to export anything through sysfs now
> instead of /proc?  From what I remember, it only looked like debugging
> and other general info stuff.

IIRC some tuning / debugging / info stuff, the drivers should work just
fine without.  Temporarely disableling that wouldn't be a big issue
IMHO.

> So dev should point to the dev of the video class device?

Exactly.  videodev.o will put that into class_device->dev which in turn
will produce these symlinks:

eskarina kraxel /sys/class/video4linux/video0# ll device
lrwxrwxrwx    1 root     root           53 Jul 15 17:20 device -> ../../../devices/pci0000:00/0000:00:06.0/0000:02:07.0/

> > Comments?
> 
> You _have_ to set up a release function for your class device.  You
> can't just kfree it like I think you are doing, otherwise any users of
> the sysfs files will oops the kernel after the video class device is
> gone.

class_device_unregister() is called from video_unregister_device() which
looks fine to me.  Or do you talk about something else?

> Other than that, how about exporting the dev_t value for the video
> device?  Then you automatically get udev support, and I don't have to go
> add it to this code later :)

Do you have a pointer to sample code for that?

  Gerd

-- 
sigfault
