Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317931AbSG2Ulj>; Mon, 29 Jul 2002 16:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSG2Uli>; Mon, 29 Jul 2002 16:41:38 -0400
Received: from imo-m10.mx.aol.com ([64.12.136.165]:7923 "EHLO
	imo-m10.mx.aol.com") by vger.kernel.org with ESMTP
	id <S317931AbSG2Ulf>; Mon, 29 Jul 2002 16:41:35 -0400
Message-ID: <3D4571B7.1000709@netscape.net>
Date: Mon, 29 Jul 2002 16:47:51 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: mochel@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] integrate driverfs and devfs (2.5.28)
References: <Pine.LNX.4.44.0207291214340.22697-100000@cherise.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



mochel@osdl.org wrote:

>Wow. I don't know whether to laugh, or to cry. 
>
Nor do I.

>
>Not a chance. I refuse to apply any devfs interface layers to the device 
>model core, or any devfs-specific members to the device model data 
>structures. And, that's just on principle. 
>
This patch merely adds one new list to the device struct.  The 
information it provides is not devfs specific and it only extracts data 
from the devfs structures that already exist.

>
>
>As for technical reasons, why on earth would you want to do this in the 
>first place? 
>
Actually doing this is extremely useful.  Without such an interface it's 
impossible to tell which device interface in the driver model 
corresponds to which dev entry both with and without the use of devfs. 
 Imagine a user trying to configure a serial port through the driverfs. 
 Without this interface how can the user determine which serial port he 
is configuring.  With my patch it is possible to determine the !major! 
and !minor! number of the device as well as a path to devfs in the event 
that it is used.  It provides information so that the user can determine 
which device the driver model is talking about.  With the floppy driver 
that I converted it is especially nice because it lists for the user all 
the many devices that correspond with that particular floppy drive. 
 Many user level scripts and programs "will" need this kind of 
information when the driver model is complete.

>
>
>We've collectively decided that enforcing device naming policy in the 
>kernel is the Wrong Thing To Do. devfs does this; and your patch furthers 
>the pain. 
>
 My patch does not enforce any policies, it merely extracts information 
from the already existing devfs.  The major and minor numbers provided 
are useful to even those who don't use devfs.

>
>
>Besides, look at the interace. Tell me devfs_register is not horrid. 8 
>parameters is rediculous, and you want to add another one? And, change 
>every driver? 
>
You're already changing every driver with this new driver model.  Yes, I 
agree, it is horrid.  Like I said earlier this is only stage one of this 
integration.  It currently does not break anything and merely provides 
the !option! for a driver to register its devfs handle.  I wanted to get 
this feature in before the freeze.  If you read my comments you'd 
realize that my function with 9 parameters is an all in one function 
that is only optional.  Remove it or change it if you like.

>
>
>I won't touch devfs, as it's unmaintainable. I won't even look at it, 
>because it's unreadable. But, if you really want to build a bridge between 
>the two, I would suggest looking at a way to collapse some of the data 
>structures and the calls. devfs_register (or the like) should take 1 
>structure with all the information it needs in it. Most of that data you 
>can derive from other places (like a higher level). In fact, IMO, it 
>should be the higher level that is doing the registration of the devices, 
>not the individual drivers themselves. 
>
I agree that should definitely be done, maybe I'll even do it (I'm not 
the maintainer though).  What do you mean by the higher level should 
register the devices?

>
>
>I appreciate the effort, but I don't support it. We should soon have a 
>working device class model, which is where you'll start to see devfs-like 
>concepts handled in a sane way. Please look there for ideas, rather than 
>devfs. 
>
 Device Class Model, hmm, I can't wait to see that.
 My next driver model patch will be less controversial:-;.

>
>
>Thanks,
>
>    -pat
>
 Please have a more open mind about this.  It may need a bit of 
adaptation but is still very useful.  If you have any questions or 
comments feel free to contact me.
Thanks,
Adam

