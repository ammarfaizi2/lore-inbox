Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131615AbRAKHXa>; Thu, 11 Jan 2001 02:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132490AbRAKHXV>; Thu, 11 Jan 2001 02:23:21 -0500
Received: from ns1.megapath.net ([216.200.176.4]:59922 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S131615AbRAKHXH>;
	Thu, 11 Jan 2001 02:23:07 -0500
Message-ID: <3A5D5F16.1030707@megapathdsl.net>
Date: Wed, 10 Jan 2001 23:21:58 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac1 i686; en-US; m18) Gecko/20010107
X-Accept-Language: en
MIME-Version: 1.0
To: David Hinds <dhinds@sonic.net>
CC: Aaron Eppert <eppertan@rose-hulman.edu>, dhinds@zen.stanford.edu,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 Patch for 3c575
In-Reply-To: <20010110204420.A7699@rose-hulman.edu> <3A5D20D6.6090906@megapathdsl.net> <20010110201537.F12593@sonic.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Hinds wrote:

> On Wed, Jan 10, 2001 at 06:56:22PM -0800, Miles Lane wrote:
> 
>> There's one other annoyance:
>> 
>> The config files for pcmcia-cs expect the 3c575_cb driver,
>> so I either have to hack the configuration files or load
>> the 3c59x driver by hand.
> 
> 
> Yes, I'm not sure how to best communicate the fact that 3c59x should
> be used to cardmgr.

There are at least two things that need to happen.

	1. The pcmcia-cs installation needs to install
	   different default configuration files when
	   the target machine is running kernel drivers
	   instead of pcmcia-cs drivers.  Specifically,
	   there are numerous devices that aren't supported
	   yet by drivers in the kernel tree (e.g. D-Link
	   DFE-650 Fast Ethernet PC-Card).  So, those
	   device configuration entries should probably be
	   removed until the needed drivers exist.
	   Then there is the need to map support for some
	   devices (like the 3c575) to new drivers (the
	   3c59x).  I am not sure whether there are other
	   devices for which this is true.

	   For the case where drivers don't exist yet,
	   the /etc/pcmcia/config* files could be migrated
	   into the kernel tree, so that when a kernel is
	   installed that is configured to use the kernel
	   drivers instead of pcmcia-cs drivers, then
	   install the modified /etc/pcmcia/config* files.

	   Now, this is a mess.  Because, people will likely
	   want to test the kernel drivers before making a
	   permanent commitment to the transition.  Therefore,
	   it's important that the current /etc/pcmcia/config*
	   files get backed up.  Then you have to keep backing
	   them up as you install additional kernels.  Like
	   this:
		/etc/pcmcia/backup/config*
		/etc/pcmcia/backup.1/config*
		/etc/pcmcia/backup.2/config*

	   This seems kind of heinous.  But, these
	   configuration files sometimes get tweaked for
	   a particular machine's hardware configuration,
	   so it's important not to lose them.

	2. A concerted development effort needs to be made
	   to get the PCMCIA/Cardbus device support for
	   kernel drivers to be on a par with the device
	   support in pcmcia-cs.

	   It would be really helpful to at least get the
	   pcnet_cs driver ported to the kernel tree, because
	   that pcmcia-cs driver support a wide array of
	   ethernet PCMCIA cards.  On the other hand, it's
	   my impression that Linus wants to make sure that
	   the Cardbus support in the 2.4.0 tree is really
	   solid before developing PCMCIA support in the
	   kernel tree.  Is that correct?

David, do you know whether there is a tulip driver in the
kernel tree that will support PC-Card tulip PC-Cards?
Your tulip_cb seems to support a huge number of cards.

I should note that I once before I modified my /etc/pcmcia/config
file so that cardmgr loaded 3c59x for my 3c575 card.  I got some
errors during the card detection phase and I never got "ifup eth0"
to run automatically when I inserted the card.

Cheers,
	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
