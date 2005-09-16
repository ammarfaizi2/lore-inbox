Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbVIPBqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbVIPBqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 21:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbVIPBqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 21:46:55 -0400
Received: from soundwarez.org ([217.160.171.123]:49645 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1161028AbVIPBqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 21:46:54 -0400
Date: Fri, 16 Sep 2005 03:46:52 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Message-ID: <20050916014652.GA12920@vrfy.org>
References: <20050916002036.GA6149@suse.de> <200509151958.45573.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509151958.45573.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 07:58:44PM -0500, Dmitry Torokhov wrote:
> On Thursday 15 September 2005 19:20, Greg KH wrote:
> > I would like to add something called "subclasses" for lack of a better
> > term.  These subclasses would have both drivers, and devices associated
> > with them.  This would show up as the following tree of directories:
> > 
> > 	/sys/class/input/
> > 	|-- input0
> > 	|   |-- event0
> > 	|   `-- mouse0
> > 	|-- input1
> > 	|   |-- event1
> > 	|   `-- ts0
> > 	|-- mice
> > 	`-- drivers
> > 	    |-- event
> > 	    |-- mouse
> > 	    `-- ts
> > 
> > Here we have 3 struct class_devices like today, input0, input1, and
> > mice.  We also have struct subclass_drivers of event, mouse, and ts.
> > These will create the struct subclass_devices event0, mouse0, event1,
> > and ts0.  The "dev" node files will show up in the directories mice,
> > event0, mouse0, event1, and ts0, like you would expect them too.
> 
> This proposed scheme does not answer the question: "what input interfaces
> present in my system?".

If this is really needed, we can just create a "interfaces" directory at
every "class" top-level and put symlinks pointing to all interfaces of that
class into it. How does that sound?

> Input interfaces are objects in their own right
> and deserve their own spot. Compare your picture with the one below:
> 
> [dtor@core ~]$ tree /sys/class/input/
> /sys/class/input/
> |-- devices
> |   |-- input0
> |   |   |-- device -> ../../../../devices/platform/i8042/serio1
> |   |   `-- event0 -> ../../../../class/input/interfaces/event0

> `-- interfaces
>     |-- event0
>     |   |-- dev
>     |   `-- device -> ../../../../class/input/devices/input0
> 
> Here you have exactly the same information as in your picture plus you can
> see the other class (input interfaces) as well.

Well, this is just putting two different classes into one subdirectory. :)
We would better just add "/sys/class/input_device" and don't need to change
any userspace software then.
Sure there is the cosmetical difference that the two classes are just named
input* and not live in the same directory, but that's not enough reason
to start a complete different model in sysfs, I think.

I would like to have the option to move "block" into "class" some day
and therefore prefer the "stacking class devices", compared to the "grouping
and symlinking" classes model.

Kay
