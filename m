Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316127AbSFUAqN>; Thu, 20 Jun 2002 20:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSFUAqM>; Thu, 20 Jun 2002 20:46:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57608 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316089AbSFUAqK>; Thu, 20 Jun 2002 20:46:10 -0400
Date: Thu, 20 Jun 2002 17:46:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Andries Brouwer <aebr@win.tue.nl>, Martin Schwenke <martin@meltin.net>,
       Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map 
In-Reply-To: <20020620162801.24988@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0206201741590.1647-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Benjamin Herrenschmidt wrote:
>
> Looking at how other kind of device trees are doing (typically
> Open Firmware), I beleive this can be acheived by having a "type"
> node (ie. file).

I think you're right. Embedding types into naming makes for easy examples
of using "find /devices -name ..." to look cool, but it also likely makes
for rather cumbersome names, _and_ there are tons of devices that want to
expose multiple different capabilitites ("it's not just a floor wax, it's
a dessert topping too!").

> Also, there are lots of good reasons to put device/driver settings as
> "properties" of the device node in the device tree, which ends up having
> proc-like files under each device node.

You're bound to have multiple files under each node anyway, for things
like partition information etc. Yes.

> We could define some standard ones (like the device type) and provide a
> simple way (proc-like) for drivers to add more properties, thus replacing
> in most cases the need for ioctls.

Absolutely. The current driverfs thing does some of that (the "name"
thing, mainly useful for havign uniform naming between different tools,
and PCI devices for example all get a standard set of property files
from the bus driver).

But it should hopefully be driven by real need, not just "cool feature".
Which is always a chicken-and-egg issue, of course.

		Linus

