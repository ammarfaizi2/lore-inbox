Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbUKEGco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbUKEGco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 01:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbUKEGcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 01:32:43 -0500
Received: from [211.58.254.17] ([211.58.254.17]:60883 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262326AbUKEGck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 01:32:40 -0500
Date: Fri, 5 Nov 2004 15:32:37 +0900
From: Tejun Heo <tj@home-tj.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       rusty@rustcorp.com.au, mochel@osdl.org
Subject: Re: [PATCH 2.6.10-rc1 0/4] driver-model: manual device attach
Message-ID: <20041105063237.GA28308@home-tj.org>
References: <20041104074330.GG25567@home-tj.org> <20041104175318.GH16389@kroah.com> <200411050002.57174.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411050002.57174.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 12:02:57AM -0500, Dmitry Torokhov wrote:
> I think that my bind)mode patches which allow to control binding through
> sysfs on pre-device and per-driver base should suffice here. I really doubt
> that anybody would want to keep autoattach disabled and do all matching
> manually ;). Besides having per-driver attribute allows drivers authors
> control binding.

 Think about extending hotplug to cover all device bindings.  It will
kick in very early in the booting process (maybe in the initrd image)
and names/binds every device on the device with appropriate arguments
as user requested.  I was thinking about usages like that when I was
making the sysctl node.  Maybe I was going too far. :-)

> Do we really need 2 or even 3 files ("attach", "detach" and "rescan")?
> Given that you really can't (at least not yet) do all there operations
> for all buses from the core that woudl require 3 per-bus callbacks.
> I think reserving special values such as "none" or "detach" and "rescan"
> shoudl work just fine and also willallow extending supported operations
> on per-bus basis. For example serio bus supports "reconnect" option which
> tries to re-initialize device if something happened to it. It does not
> want to do rescan as that would generate new input devices while it is
> much more convenient to re-use old ones. 

 How about making the command format "CMD ARGS" rather than
"{CMD|DRIVERNAME}"  i.e.

 not

 # echo e100 > drvctl
 # echo detach > drvctl

 but

 # echo attach e100 > drvctl
 # echo detach > drvctl

 But, I don't know.  It now just seems too much like a proc node.

> I disagree. Here you working with particular device. You are not saying
> "from now on I want e100 to bind all my 5 new network cards that happen
> to have id XXXX:YYYY". Instead you are saying "I want to bind e100 driver
> to this card residing at /sys/bus/pci/0000.....". In other word it is
> operation on particular device and should be done by manipulating device
> attribute.

 I kind of agree with you but I think either way is fine.

 Thanks.

-- 
tejun

