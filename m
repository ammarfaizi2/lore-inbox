Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275864AbSIUCuU>; Fri, 20 Sep 2002 22:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275866AbSIUCuU>; Fri, 20 Sep 2002 22:50:20 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:46319 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S275864AbSIUCuT>; Fri, 20 Sep 2002 22:50:19 -0400
Date: Fri, 20 Sep 2002 19:55:22 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
To: Greg KH <greg@kroah.com>
Cc: Brad Hards <bhards@bigpond.net.au>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Message-id: <3D8BDF9A.305@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200207180950.42312.duncan.sands@wanadoo.fr>
 <E17rwAI-0000vM-00@starship> <20020919164924.GB15956@kroah.com>
 <200209200656.23956.bhards@bigpond.net.au> <20020919230643.GD18000@kroah.com>
 <3D8B884A.7030205@pacbell.net> <20020920231112.GC24813@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Sep 20, 2002 at 01:42:50PM -0700, David Brownell wrote:
> 
>>Actually it does more than that ... it tells you what minor numbers
>>are assigned to the drivers _currently loaded_ which means that it's
>>not really useful the instant someone plugs in another device.
> 
> 
> Wait, I'm confused, which one is "it"?  The old /proc/bus/usb/drivers
> file, or the new driverfs stuff?

The old file.


>>You can't use it to allocate numbers or tell what /dev/file/name matches
>>a given device ... so what is its value, other than providing a limited
>>minor number counterpart to /proc/devices?  (Which, confusingly, doesn't
>>list devices but major numbers.)
> 
> 
> I'm working on adding the minor number info to the usb driverfs code
> right now, so that info will be available. 

How about a facility to create the character (or block?) special file
node right there in the driverfs directory?  Optional of course.

The deal being that we really don't want to care at all about major
or minor numbers.  If you only add minor, major remains an issue.
If you add both, then the problem is where to find the darn device
special file.  If you add the device (special) file ... then it's easy
for device drivers to migrate!  'devlabel' or somesuch could manage
symlinks to "user friendly names" using class level hotplug events,
and smarter apps would start to scan driverfs directly.

- Dave




