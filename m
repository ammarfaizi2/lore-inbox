Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271745AbTGRJyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271575AbTGRJsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:48:11 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:43674 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S271583AbTGRJfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:35:15 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jul 2003 11:59:21 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Greg KH <greg@kroah.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
Message-ID: <20030718095920.GA32558@bytesex.org>
References: <20030715143119.GB14133@bytesex.org> <20030715212714.GB5458@kroah.com> <20030716084448.GC27600@bytesex.org> <20030716161924.GA7406@kroah.com> <20030716202018.GC26510@bytesex.org> <20030716210800.GE2279@kroah.com> <20030717120121.GA15061@bytesex.org> <20030717145749.GA5067@kroah.com> <20030717163715.GA19258@bytesex.org> <20030717214907.GA3255@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717214907.GA3255@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 02:49:07PM -0700, Greg KH wrote:
> On Thu, Jul 17, 2003 at 06:37:15PM +0200, Gerd Knorr wrote:
> > 
> > Version (1) can be done without breaking the build, with a hack along 
> > the lines "if (no release callback) printk(KERN_WARN please fix your
> > driver)", so the drivers can be fixed step-by-step afterwards.
> 
> That sounds like a nice way to start.
> 
> > Fixing the drivers might be non-trivial through.  Some drivers are
> > hot-pluggable (usb cams), some drivers register more than one v4l device
> > (bttv wants up to three).  Those drivers can't just call kfree() in the
> > ->release callback because there might be other references, some open
> > file handle for a unplugged usb cam, another not-yet unregistered
> > v4l device, whatever.  Probably they must implement some reference
> > counting scheme to get that right.  The very simple ones (in
> > drivers/media/radio for example) likely just need the kfree() moved
> > from the ->remove function into the new ->release() callback.
> 
> I don't think it will be that bad for them.  Just have them change the
> v4l device from being a structure included in their structure, into a
> pointer, and then create it before registering, and free it in the
> release() callback.
> 
> That being said, I haven't actually looked at the code to verify that
> this is all that is needed :)
> 
> > Version (2) needs every v4l driver touched to make it compile again.
> > Not sure how hard it is to fixup them.  I'd guess it is pretty straigt
> > forward to do the conversion, it's just alot of work.  I also could do
> > a number of other cleanups along the way.  Maybe I trap into some hidden
> > pitfalls through, havn't looked at all the drivers in detail yet.
> 
> Breaking the build is a very good thing to do at times, to ensure that
> stuff gets fixed properly.  Users might go for a while without realizing
> that there really is a problem in their driver.
> 
> But in the end, it's up to you...
> 
> thanks,
> 
> greg k-h

-- 
sigfault
