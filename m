Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTEBGLc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 02:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbTEBGLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 02:11:02 -0400
Received: from granite.he.net ([216.218.226.66]:5905 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261845AbTEBGJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 02:09:12 -0400
Date: Thu, 1 May 2003 23:22:46 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Linux-usb-users@lists.sourceforge.net
Subject: [ANNOUNCE] 2003-05-01 release of hotplug scripts
Message-ID: <20030502062245.GB6363@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just packaged up the latest Linux hotplug scripts into a release,
which can be found at:
 	http://sourceforge.net/project/showfiles.php?group_id=17679

Or from your favorite kernel.org mirror at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2003_05_01.tar.gz
or for those who like bz2 packages:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2003_05_01.tar.bz2

I've also packaged up some pre-built (and signed) Red Hat 7.3 based rpms:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2003_05_01-1.noarch.rpm
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-base-2003_05_01-1.noarch.rpm
	
The source rpm is available if you want to rebuild it for other distros
or versions of Red Hat at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2003_05_01-1.src.rpm

The main web site for the linux-hotplug project can be found at:
	http://linux-hotplug.sf.net/
which contains lots of documentation on the whole linux-hotplug
process.

There are lots of changes in this release from the last one (which was
almost 8 months ago), most of them make things work better for systems
running 2.5, but some of them fix problems that 2.4 users will see.

Some of the major changes in this release are:
	- fix for the lack of a drivers file in usbfs in 2.5.
	- initial scsi.agent for 2.5, modprobes sd_mod or sr_mod
	- call devlabel if it's present
	- made /sbin/hotplug a tiny multiplexer program, moving the original
	  /sbin/hotplug program to /etc/hotplug.d/default/default.hotplug

The full ChangeLog extract since the last release is included below for
those who want to know everything that's been changed, and who to blame
for them :)

thanks,

greg k-h


--------------

Thu May 1 2003 kroah
	- 2003_05_01 release
	- made /sbin/hotplug a tiny multiplexer program, moving the original
	  /sbin/hotplug program to /etc/hotplug.d/default/default.hotplug
	- split the rpms generated into two: hotplug and hotplug-base.
	  hotplug-base contains /sbin/hotplug and /etc/hotplug.d/ only
	  hotplug contains everything else
	  hotplug depends on hotplug-base to be present to be able to be
	  loaded.

Thu Apr 17 2003 dbrownell
	- from Dan Dennedy <dan@dennedy.org>, firewire agent now loads
	  multiple modules.  video control and data can be separate.

Fri Jan 17 2003 dbrownell
	- call devlabel if it's present; <Gary_Lerhaupt@Dell.com>

Thu Dec 12 2002 dbrownell
	- handle some sysfs timing and sequencing quirks
	- if it's there, sysfs can provide some missing usb data

Mon Dec  2 2002 dbrownell
	- update README
	- updates from suse's patches
	- DEBUG messages should be off by default!
	- clean up "make install"
	- LSB says init scripts in /etc/init.d, and handle 'force-reload'

Fri Nov 29 2002 dbrownell
	- initial scsi.agent for 2.5, modprobes sd_mod or sr_mod

Wed Nov 21 2002 dbrownell
    more updates for 2.5 kernels:
	- handle additional "device mode" usb hotplug, ignoring it for now
	  unless /sys/$DEVPATH/bNumConfigurations says we have choice of
	  configurations (the first one might not be best).
	- handle the improved "interface mode" usb hotplug in 2.5: don't
	  use 'usbmodules', each interface gets its own event report.
	- don't slow down usb hotplug, all hcds now do control queueing.
	- flag usb and pci 'coldplug' cleanups, needed now that we can
	  finally eliminate usbmodules (pcimodules too?)
    other fixes:
	- patch from <Reinhold.May@gmx.de> to address fact that usbmodules
	  can fail where the script parsing works
	- /sbin/hotplug can now save events to a logfile for later use,
	  suitable for debugging, collecting as test data, sending to a
	  daemon, and so on.
	- better fix for 'always run setup scripts', handling cases where
	  modprobe fails until the setup script renumerates to new usb ids.
	- usb.rc, comment the usbdevfs versioning issue (counting files in
	  /proc/bus/usb became fragile recently) and handle some similar
	  config-dependent startup issues

Tue Oct 1 2002 kroah
	- fix for the lack of a drivers file in usbfs in 2.5.  Patch is from
	  Duncan Sands <duncan.sands@wanadoo.fr>
