Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSFUBBy>; Thu, 20 Jun 2002 21:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSFUBBx>; Thu, 20 Jun 2002 21:01:53 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:57222 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S315191AbSFUBBv>; Thu, 20 Jun 2002 21:01:51 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Andries Brouwer <aebr@win.tue.nl>, Martin Schwenke <martin@meltin.net>,
       Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map 
Date: Thu, 20 Jun 2002 18:49:35 +0200
Message-Id: <20020620164935.10141@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.44.0206201741590.1647-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0206201741590.1647-100000@home.transmeta.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On Thu, 20 Jun 2002, Benjamin Herrenschmidt wrote:
>>
>> Looking at how other kind of device trees are doing (typically
>> Open Firmware), I beleive this can be acheived by having a "type"
>> node (ie. file).
>
>I think you're right. Embedding types into naming makes for easy examples
>of using "find /devices -name ..." to look cool, but it also likely makes
>for rather cumbersome names, _and_ there are tons of devices that want to
>expose multiple different capabilitites ("it's not just a floor wax, it's
>a dessert topping too!").

Which is +/- dealt with in open firmware by also having a "compatible"
property that contain a list of names which this device is compatible with.

The "type" and "class" proper says if you are dealing with a bridge, a disk,
a serial port, etc... (but we could refine that into separate types/subtypes,
like a serial port beeing a type "char device" and subtype "serial port")

The compatible says which what kind of HW you are compatible with (it's
a list), which can be the name of other HW, but can also be generic types.
One example is NE2k compatible cards. They can have a specific name, a type
of "ethernet adapter" (or just ethernet to make things simple) a class
of "network device" and compatible "ne2k".

The "compatible" isn't exactly relative to the kind of service you provide,
this is the job of "device_type" and "class", at least in OF world, but
more the kind of HW you are compatible with (to help pick the proper
driver), though that don't necessarily make sense in driverfs. It's just
that the idea could be reused.

>> Also, there are lots of good reasons to put device/driver settings as
>> "properties" of the device node in the device tree, which ends up having
>> proc-like files under each device node.
>
>You're bound to have multiple files under each node anyway, for things
>like partition information etc. Yes.
>
>> We could define some standard ones (like the device type) and provide a
>> simple way (proc-like) for drivers to add more properties, thus replacing
>> in most cases the need for ioctls.
>
>Absolutely. The current driverfs thing does some of that (the "name"
>thing, mainly useful for havign uniform naming between different tools,
>and PCI devices for example all get a standard set of property files
>from the bus driver).
>
>But it should hopefully be driven by real need, not just "cool feature".
>Which is always a chicken-and-egg issue, of course.

Well, I have a bunch of real needs for it easily available ;) But in lots
of case, I beleive slowly replacing most ioctl's in drivers with that would
make sense. I _think_ Patrick and I agree on that, and It's something I want
to discuss at OLS/KS, probably as part of the Power Management BOF.

Ben.


