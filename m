Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbSIZT0e>; Thu, 26 Sep 2002 15:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbSIZT0e>; Thu, 26 Sep 2002 15:26:34 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:21963 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261460AbSIZT0d>; Thu, 26 Sep 2002 15:26:33 -0400
Date: Thu, 26 Sep 2002 12:32:08 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pci and
 usb
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Message-id: <3D9360B8.20200@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20020925212955.GA32487@kroah.com> <3D9250CD.7090409@pacbell.net>
 <20020926002554.GB518@kroah.com> <3D92749F.9050504@pacbell.net>
 <20020926042715.GB1790@kroah.com> <3D933278.9010905@pacbell.net>
 <20020926184345.GC6250@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>Well, that's a driver unload issue, which I think everyone agrees on the
>>>fact that it's not ok to do automatic driver unload when a device is
>>>removed, because of this very problem.
>>
>>I think it _could_ be fine to do such rmmods, if all the module
>>remove races were removed ... and (for this issue) if the primitve
>>were actually "remove if the driver is not (a) in active use, or
>>(b) bound to any device".  Today we have races and (a) ... but it's
>>the lack of (b) that prevents hotplug from even trying to rmmod,
>>on the optimistic assumption there are no races.
> 
> 
> But how do we accomplish (b) for devices that we can't remove from the
> system?  Like 99.9% of the pci systems?
> 
> I agree it would be "nice", but probably never realistic :)

There would be two modes for 'rmmod'.  One is the "remove if the
kernel can tell it can't be used" (as described above), suitable
for automation.  The other gives the rude end-user failure modes:
"remove this module if it's not in active use", which is all we
have today ... a mode suitable only for developers or sysadmins.

Userland needs to make the policy choice, then tell the kernel
whether to ignore any unopened (but bound) devices.

Highly realistic, IMO.  It's just a question of ensuring some data
the kernel already holds (N devices are bound to this driver, even
if none are currently opened) is considered by rmmod.  I almost put
together a patch for it at one time.  There seems to be a change
in maintainer under way, maybe it'd be worth revisiting this.

- Dave


