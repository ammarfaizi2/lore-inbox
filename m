Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263002AbVCDS7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbVCDS7X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbVCDS4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:56:09 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:48295 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S262987AbVCDSv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:51:56 -0500
Date: Fri, 4 Mar 2005 19:51:47 +0100
From: Hans-Christian Egtvedt <hc@mivu.no>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new driver for ITM Touch touchscreen
Message-ID: <20050304185147.GB9407@samfundet.no>
References: <1109932223.5453.16.camel@charlie.itk.ntnu.no> <200503041403.37137.adobriyan@mail.ru> <d120d50005030406525896b6cb@mail.gmail.com> <1109953224.3069.39.camel@charlie.itk.ntnu.no> <d120d50005030408544462c9ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005030408544462c9ea@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Around Fri 04 Mar 2005 11:54:18 +0000 or thereabout, Dmitry Torokhov wrote:
> On Fri, 04 Mar 2005 17:20:24 +0100, Hans-Christian Egtvedt <hc@mivu.no> wrote:
>> On Fri, 2005-03-04 at 09:52 -0500, Dmitry Torokhov wrote:
>> > On Fri, 4 Mar 2005 14:03:37 +0200, Alexey Dobriyan <adobriyan@mail.ru> wrote:
>> > > On Friday 04 March 2005 12:30, Hans-Christian Egtvedt wrote:
>> > As far as the driver goes:
>> >
>> > - yes, it does need input_sync;
>> One problem with input_sync is that the panel get's too fast, and double
>> click is experienced quite often, maybe some threshold is needed for low
>> values in Z-direction?
>> 
>> I'm probably doing something wrong here since I experience easy
>> doubleclicks when I just lightly touch the screen.
> Yes, I think you need to use some threshold when reporting BTN_TOUCH
> event. Still, always report ABS_PRESSURE as is. This way the
> touchscreen is useable via legacy interfaces (mousedev. tsdev) and if
> a specialized userspace driver is written it still can get pretty much
> unmangled data from /dev/input/eventX. This will also allow such
> driver adjust touchpad sensitivity, if needed.

OK, I'll try to find some better documentation about input devices, any
tips/pointers would be nice. I'm completly new to kernel drivers, I'm used to
writing drivers in embedded systems.

The driver is made in the way it is today because there is also a driver for
X which read raw events from /dev/input/eventX. It's called lictouch, I have
the source for it too, but I'm not (yet) part of any developing there.

It would be a really nice feature if one could use the touchscreen as a
legacy interface, but then I would need to be able to calibrate the screen in
the driver and not frontend. At least preferable.

>> > Also, is there a way to query the screen for actual size?
>> 
>> Sorry, the panel is a fixed size, and it gives out coordinates from 0 ->
>> 4095 in both X- and Y-direction. In Z-direction (pressure strength) it
>> goes from 0 to 255.
>> 
>> Or did you want the size of the screen? Meaning you want to know if it's
>> a 15", 17" and so on?
> No, not physical sizes. I was wondering if soe touchscreens are
> reporting let's say actual coordinates from 1100-3600 and others from
> 600-3850, instead of full 0-4096. Is there a way to query the hardware
> and find the actual min and max for a device so it can be reported to
> userspace.

I really don't have an answer, I'm still waiting for the datascheet to the
controller beeing used. When I get that I can perhaps do calibration in the
driver, and not with a config file or in xf86free/x.org config.

-- 
Regards
Hans-Christian Egtvedt
MIVU Solutions DA
