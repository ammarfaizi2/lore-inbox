Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129556AbRBCH0P>; Sat, 3 Feb 2001 02:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131116AbRBCH0E>; Sat, 3 Feb 2001 02:26:04 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:51214 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S129556AbRBCHZ6>;
	Sat, 3 Feb 2001 02:25:58 -0500
Message-ID: <3A7BB31D.CA1AF3E4@megapathdsl.net>
Date: Fri, 02 Feb 2001 23:28:29 -0800
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Adding PCMCIA support to the kernel tree -- developers needed.
In-Reply-To: <3A711BB1.C5B8BCFB@megapathdsl.net> <3A711CB1.62757B52@megapathdsl.net> <20010131200621.F29731@sonic.net> <3A78E3EC.8050605@megapathdsl.net> <20010202183642.F30100@sonic.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I asked David Hinds to write up an outline of the things that
will be needed to get PCMCIA support cleanly and completely
integrated into the kernel tree.

David has expressed that he'll not be able to participate in
this work.  He has his hands full with his day job and his 
role as maintainer/developer of the pcmcia-cs package.

David, I would appreciate one additional layer of information that is
not present in your list.  Would add the names of a few representative 
devices for each of your bullet points?  For example, for the last 
list item, what are the names of the major (non-CardBus) PCI-to-PCMCIA 
bridges?

Here is David's list:

> To include 16-bit PCMCIA cards in the hot plug framework would require
> few driver changes; the only mandatory changes would be in how drivers
> register themselves and are hooked up with appropriate devices:
> 
> -- Make up pcmcia_device_id and pcmcia_driver types, and write new
>    register/unregister calls to parallel PCI and USB drivers.  This
>    would eventually take over for the "ds" module and cardmgr.
> 
> -- Rewrite all PCMCIA client drivers to have MODULE_DEVICE_TABLE
>    entries and use the new driver services.  This can all be done
>    incrementally, with ds/cardmgr handling old-style drivers.
> 
> -- The CIS override functionality in the PCMCIA package is unpleasant
>    to support in a completely in-kernel framework.
> 
> Missing functionality in the hot plug framework:
> 
> -- Only new network devices generate /sbin/hotplug events now.  Modify
>    all other device types to also do so: the ones currently handled by
>    PCMCIA include serial, parallel, SCSI (all types), and IDE.
> 
> -- There is no mechanism to request a card eject in the new framework.
>    This is required for clean shutdown of SCSI and IDE adapters.
> 
> -- The PCMCIA device configuration scripts have a lot of capabilities
>    that the hotplug scripts do not have yet.  At the moment, the
>    extent of device-specific hotplug configuration is running "ifup".
> 
> Missing functionality in the 2.4 PCMCIA drivers:
> 
> -- The yenta driver can't handle CardBus adapter cards for desktop
>    systems.  Many require explicit overrides for the default interrupt
>    delivery settings, and a few require other special bridge settings.
> 
> -- The i82365 driver can't handle (non-CardBus) PCI-to-PCMCIA bridges
>    any more.  Some of the PCI code in the old i82365 driver needs to
>    be put back.

This list does seem to break out the work into chunks that can
be tackled more or less independently.

Anyone willing to sign up for some of this effort?

	Miles
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
