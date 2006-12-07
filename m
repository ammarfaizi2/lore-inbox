Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937975AbWLGPUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937975AbWLGPUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937977AbWLGPUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:20:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35422 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937975AbWLGPUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:20:30 -0500
Date: Thu, 7 Dec 2006 15:20:27 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luming.yu@intel.com, zap@homelink.ru, randy.dunlap@oracle.com,
       kernel-discuss@handhelds.org
Subject: Re: Display class
In-Reply-To: <20061206194442.422c60d3.maxextreme@gmail.com>
Message-ID: <Pine.LNX.4.64.0612071439040.31668@pentafluge.infradead.org>
References: <20061206194442.422c60d3.maxextreme@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   - I would remove "struct device *dev, void *devdata" of display_device_register()
>     Are they neccesary for other display drivers? I have to pass NULL right now.

Yes. Passing in a struct device allows you a link between the device and 
the class. If you pass in the device for the parport a link to the parport 
device would exist in you displayX directory. The devdata is used by the 
probe function to get data about the monitor if it is not NULL.

In the case of most desktop monitors they have EDID blocks. You can 
retrieve them (devdata) and it gets parsed thus you have detail data
about the monitor. In your case it can be null. 

>   - I would add a paramtere ("char *name") to display_device_register() so we
>     set the name when registering. Right now I have to set my name after inited,
>     and this is a Linux module and not a person borning, right? ;)

The probe function gets this for you. In your case you would have a probe 
method that would just fill in the name of the LCD. For me using the ACPI 
video driver I get the name for my monitor

LEN  15"XGA 200nit

Which is the manufacturer - monitor id - ascii block.

>   - I would add a read/writeable attr called "rate" for set/unset the refresh rate
>     of a display.

I suggest creating a group for your driver. See device.h for 
group_attributes.
 
>   - I was going to maintain the drivers/auxdisplay/* tree.
>     Are you going to maintain the driver? I think so, just for being sure.

Yes. I need it for the ACPI video and fbdev layer. Remember its in the 
early stages yet. 

> P.S.
> 
>   When I was working at 2.6.19-rc6-mm2 it worked all fine, but now
>   I have copied it to git7 I'm getting some weird segmentation faults
>   (oops) when at cfag12864bfb_init, at mutex_lock() in
>   display_device_unregister module... I think unrelated (?), but I will
>   look for some mistake I made.

Did you solve the problem?

