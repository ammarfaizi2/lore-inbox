Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTIYQkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbTIYQkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:40:16 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:3810 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261384AbTIYQkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:40:13 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 25 Sep 2003 18:43:50 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: Pauline Middelink <middelink@polyware.nl>, linux-kernel@vger.kernel.org
Subject: Re: zr36120 2.6.x port (was: Re: [Mjpeg-users] DC30+ can't capture size greater than 224x168)
Message-ID: <20030925164350.GA9663@bytesex.org>
References: <BAY7-F62oStVwgTlLlJ0001924a@hotmail.com> <1064478814.2220.326.camel@shrek.bitfreak.net> <20030925084932.GA22441@polyware.nl> <1064484678.2227.465.camel@shrek.bitfreak.net> <20030925102635.GA25634@polyware.nl> <1064505583.2228.716.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064505583.2228.716.camel@shrek.bitfreak.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * implement a zoran_vdev_release() function to free memory after it's no
> longer in use (this is a hack imo, but it's the suggested way of doing
> it... There was an article somewhere about it and it's also been
> discussed on the v4l mailinglist... Can't find a link, though)

If you just kfree() there you don't need your own bur can simply use
video_device_release() ...

> Things left to do (for you ;) ): v4l2 (sounds like a good thing, though
> it'll take some time), multiple opens (if you want), and (IIRC, Gerd?)
> videodev + vbidev fops should be the same. This wasn't the case in
> 2.4.x, but it's the case in 2.6.x, I think.

That's a v4l vs. v4l2 API thing.  The v4l2 API allows applications to
switch a device handle into vbi mode via S_FMT, thus you don't need
separate devices any more.  For v4l1 backward comparibility this is
still needed through.  For v4l2 drivers /dev/video and /dev/vbi almost
the same, /dev/vbi has just some other default settings after opening
the device.

  Gerd

