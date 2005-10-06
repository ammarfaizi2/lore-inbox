Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVJFMAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVJFMAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 08:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVJFMAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 08:00:19 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:4958 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750803AbVJFMAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 08:00:18 -0400
Message-ID: <434511CE.5080004@tls.msk.ru>
Date: Thu, 06 Oct 2005 16:00:14 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [PATCH] nesting class_device in sysfs to solve world peace
References: <20050928233114.GA27227@suse.de> <200509300032.50408.dtor_core@ameritech.net> <20051006000951.GA4411@suse.de> <200510060129.28066.dtor_core@ameritech.net>
In-Reply-To: <200510060129.28066.dtor_core@ameritech.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Wednesday 05 October 2005 19:09, Greg KH wrote:
> 
>>On Fri, Sep 30, 2005 at 12:32:49AM -0500, Dmitry Torokhov wrote:
>>
>>>On Wednesday 28 September 2005 18:31, Greg KH wrote:
>>>
>>>>Alright, here's a patch that will add the ability to nest struct
>>>>class_device structures in sysfs.  This should give everyone the ability
>>>>to model what they need to in the class directory (input, video, etc.).
>>>
>>>I still do not believe it is the solution we want:
>>>
>>>1. It does not allow installing separate hotplug handlers for devices
>>>   and their sub-devices. This will cause hotplug handlers to resort to
>>>   having some flags or otherwise detect the king of class device hotplug
>>>   hanlder is being called for and change behavior accordingly - YUCK!
>>
>>Huh?  I don't understand your complaint here.  Why would we ever want to
>>have separate hotplug handlers for the same class?  If you do want that,
>>then create separate classes.
>>
> 
> 
> Yes. I do want separate [sub]classes. I just want them grouped together
> under some <subsystem> name. And I want separate hotplug handlers because
> actions that are needed for these objects are different. When a new
> input_dev appears you want to match its capabilities with one or more
> input handlers and load appropriate handler module if it has not been
> loaded yet. When a new input interface device appears you want to create
> a new device node for it. The handlers should be diffrent if you want
> clean implementation, do you see?

How about using current classes, but name them to have common prefix,
eg input_dev, input_interface etc class names - this way, if a program
wants to enumerare all input <whatever>, it enumerates /sys/class,
finds all directories matching input*, and looks inside...

Maybe not that elegant, but may work.

/mjt
