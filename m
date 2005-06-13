Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVFMVds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVFMVds (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVFMVdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:33:02 -0400
Received: from soundwarez.org ([217.160.171.123]:41692 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261327AbVFMV07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:26:59 -0400
Date: Mon, 13 Jun 2005 23:26:54 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Hannes Reinecke <hare@suse.de>
Subject: Re: Input sysbsystema and hotplug
Message-ID: <20050613212654.GB11182@vrfy.org>
References: <200506131607.51736.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506131607.51736.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 04:07:51PM -0500, Dmitry Torokhov wrote:
> I am trying to convert input systsem to play nicely with sysfs and I am
> having trouble with hotplug agent. The old hotplug mechanism was using
> "input" as agent/subsystem name, unfortunately I can't simply use "input"
> class because when Greg added class_simple support to input handlers
> (evdev, mousedev, joydev, etc) he used that name. So currently stock
> kernel gets 2 types of hotplug events (from input core and from input
> handlers) with completely different arguments processed by the same
> input agent.
> 
> So I guess my question is: is there anyone who uses hotplug events
> for input interface devices (as in mouseX, eventX) as opposed to
> parent input devices (inputX).

Hmm, udev uses it. But, who needs device nodes. :)

> If not then I could rename Greg's class
> to "input_dev" and my new class to "input" and that will be compatible
> with older installations. 

I still think we should rename the parent-input device class and keep
the more interesting class named "input", cause this will not break current
setups besides one hotplug-handler and follows the usual style in sysfs.

> Also, in the long run I would probably want to see something like this:
> 
> /sys/class/input---input0
> 		 |
> 		 |-input1
> 		 |
> 		 |-input2
> 		 |
> 		 |-mouse---mouse0
> 		 |	 |
> 		 |	 |-mouse1
> 		 |	 |
> 		 |	 --mice
> 		 |
> 		 |-event---event0
> 			 |
> 			 |-event1
> 			 |
> 			 |-event2
> 
> where inputX are class devices, mouse and event are subclasses of input
> class and mouseX and eventX are again class devices.

We don't support childs of class devices until now. Would be nice maybe, but
someone needs to add that to the driver-core first and we would need to make
a bunch of userspace stuff aware of it ...

Kay
