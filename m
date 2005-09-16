Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbVIPH7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbVIPH7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161121AbVIPH7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:59:12 -0400
Received: from styx.suse.cz ([82.119.242.94]:8424 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1161120AbVIPH7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:59:12 -0400
Date: Fri, 16 Sep 2005 09:59:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <gregkh@suse.de>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Message-ID: <20050916075908.GC10007@midnight.suse.cz>
References: <20050916002036.GA6149@suse.de> <20050916010438.GA12759@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916010438.GA12759@vrfy.org>
X-Bounce-Cookie: It's a lemmon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 03:04:38AM +0200, Kay Sievers wrote:
> On Thu, Sep 15, 2005 at 05:20:37PM -0700, Greg KH wrote:
> > The problem:  We need a way to show complex class and class device
> > structures properly in sysfs.  Examples of these "complex" views are the
> > input layer's use of different input drivers for devices (usually the
> > same device), the video subsystem view of frame buffer devices and
> > monitors, and even the block layer with it's disks and partitions.
> > 
> > Proposed solutions in the past have been either add the ability to nest
> > classes themselves (as shown in Dmitry's recent proposal for fixing the
> > input layer), or add the ability to nest class_device structures (I
> > think others have tried to do this in the past, sorry for not
> > remembering the specifics.)  Both of these proposals don't really solve
> > the real problem, that of the fact that we need to come up with a
> > solution that all of the different subsystems can use properly.
> > 
> > So, here's my take on it.  Feel free to tell me what I messed up :)
> > 
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
> 
> I like that the child devices are actually below the parent device
> and represent the logical structure. I prefer that compared to the
> symlink-representation between the classes at the same directory
> level which the input patches propose.

I like this one better, too. It's much simpler, and does the job just as
well.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
