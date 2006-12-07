Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032379AbWLGQVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032379AbWLGQVP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032380AbWLGQVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:21:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:34417 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032379AbWLGQVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:21:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aNvOHbuKuCyA+1e6fIkRfhKCOT3PUZfCUSdhQkOkX9NGRyNoSZYYEY3kD8GbluTZBHvJ/bJ/dmQMI3D/ZY+eCaLpZ4Od4qW/imPaoRkSi+hfQj8lQJKEZpXaKe343dUOsgilOeWqvGE9Su7WID88EMt6mHbdQ//d1crMKKJhLrw=
Message-ID: <653402b90612070821v37de7611g54fef20cd5132d95@mail.gmail.com>
Date: Thu, 7 Dec 2006 17:21:13 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: Display class
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       Luming.yu@intel.com, zap@homelink.ru, randy.dunlap@oracle.com,
       kernel-discuss@handhelds.org
In-Reply-To: <Pine.LNX.4.64.0612071439040.31668@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061206194442.422c60d3.maxextreme@gmail.com>
	 <Pine.LNX.4.64.0612071439040.31668@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/06, James Simmons <jsimmons@infradead.org> wrote:
>
> >   - I would remove "struct device *dev, void *devdata" of display_device_register()
> >     Are they neccesary for other display drivers? I have to pass NULL right now.
>
> Yes. Passing in a struct device allows you a link between the device and
> the class. If you pass in the device for the parport a link to the parport
> device would exist in you displayX directory. The devdata is used by the
> probe function to get data about the monitor if it is not NULL.
>
> In the case of most desktop monitors they have EDID blocks. You can
> retrieve them (devdata) and it gets parsed thus you have detail data
> about the monitor. In your case it can be null.
>
> >   - I would add a paramtere ("char *name") to display_device_register() so we
> >     set the name when registering. Right now I have to set my name after inited,
> >     and this is a Linux module and not a person borning, right? ;)
>
> The probe function gets this for you. In your case you would have a probe
> method that would just fill in the name of the LCD. For me using the ACPI
> video driver I get the name for my monitor
>
> LEN  15"XGA 200nit
>
> Which is the manufacturer - monitor id - ascii block.
>
> >   - I would add a read/writeable attr called "rate" for set/unset the refresh rate
> >     of a display.
>
> I suggest creating a group for your driver. See device.h for
> group_attributes.
>
> >   - I was going to maintain the drivers/auxdisplay/* tree.
> >     Are you going to maintain the driver? I think so, just for being sure.
>
> Yes. I need it for the ACPI video and fbdev layer. Remember its in the
> early stages yet.
>
> > P.S.
> >
> >   When I was working at 2.6.19-rc6-mm2 it worked all fine, but now
> >   I have copied it to git7 I'm getting some weird segmentation faults
> >   (oops) when at cfag12864bfb_init, at mutex_lock() in
> >   display_device_unregister module... I think unrelated (?), but I will
> >   look for some mistake I made.
>
> Did you solve the problem?
>

I didn't look further, but I will be able to try again in some hours.
Anyway, the problem is probably at cfag12864bfb.c (as it was almost
the only file I modified from -mm2); but I can't tell where the
problem is as I tried just a few times.

Please review cfag12864bfb_init/_exit to check if your code/class is
intended to be used that way, I will focus on the segfaults.

Greets!

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
