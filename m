Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277348AbRJLSjL>; Fri, 12 Oct 2001 14:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277687AbRJLSjA>; Fri, 12 Oct 2001 14:39:00 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:519 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S277536AbRJLSil>;
	Fri, 12 Oct 2001 14:38:41 -0400
Date: Fri, 12 Oct 2001 11:31:14 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.13-pre1
Message-ID: <20011012113114.A20602@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another release of the Compaq Hotplug PCI driver is available against
2.4.13-pre1 is at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-2001_10_12-2.4.13-pre1.patch.gz
With a full changelog at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-Changelog

The latest version of modutils is required to use this version of the
patch.

I have also included the ddfs patch from Pat Mochel in this patch, as
the hotplug pci driver now uses it as its interface to userspace.  I
have fixed a few minor bugs that I ran into in the ddfs patch, so people
interested in ddfs might want to take a look at this version.

Changes since the last release:
 	- forward ported to 2.4.13-pre1
	- changed the identifying feature of a hotplug pci slot from an
	  int to a char * due to the PPC hotplug pci driver's needs.
	- cleaned up the hotplug pci slot structure a bit to hid hotplug
	  pci core structures from the hotplug pci drivers.
 	- removed the last known direct hardware access code.  If anyone
	  sees any places that the Compaq driver does not use the proper
	  kernel apis to access hardware, please let me know.
	- removed all *_sleep_on() calls to eliminate the potential
	  races in those usages.
	
TODO:
	- move the filesystem code into the hotplug pci core, removing
	  it's dependency on the ddfs patch.
	- possibly merge the 2 passes of the pci bus when removing a
	  device as the /proc logic that required that is now gone.
	- Port the Linux PPC hotplug pci controller driver to the
	  hotplug pci core  interface, whenever Anton sends me an
	  updated file...

thanks,

greg k-h
