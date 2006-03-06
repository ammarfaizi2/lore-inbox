Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWCFWf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWCFWf7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWCFWf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:35:59 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:44004
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932413AbWCFWf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:35:58 -0500
Date: Mon, 6 Mar 2006 14:35:45 -0800
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
Message-ID: <20060306223545.GA20885@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a summary of the current state of the Linux PCI and PCI Hotplug
subsystems as of 2.6.16-rc5

If the information in here is incorrect, or anyone knows of any
outstanding issues not listed here, please let me know.

List of outstanding regressions from 2.6.15:
	- none known.

List of outstanding regressions from older kernel versions:
	- some cardbus users still have issues with the change to the
	  PCI resource allocation stuff.
	  http://bugzilla.kernel.org/show_bug.cgi?id=5736 shows this
	  issue, but seems to be stalled for now :(

Here is a list of the current outstanding bugs for the PCI subsystem as
tracked at bugzilla.kernel.org.  If anyone can help out with any of
these, please add information to the bug reports.

 * 5736 [greg@kroah.com] - pci broken on PIIX/ICH laptop (CARDBUS_IO_SIZE
	too small?).


Future stuff:
  Wow, for a subsystem that no one cared about for a long time (PCI
  Hotplug) all of a sudden we have so many patches floating around that
  it is difficult to handle all of them.  If you are interested in the
  changes in this area that will be coming in 2.6.17, please see my
  quilt tree at
  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/

  Summary of the changes found there are:
	- shpchp driver reworks that fix issues and handle the module
	  being able to be unloaded properly
	- acpiphp driver changes to try to be able to work properly for
	  laptop docking stations.  There is still remaining work to do
	  in this area.
	- We have unstable patches to handle multi-domain PCI busses for
	  i386 and x86 arches in this tree.  Unfortunately they still
	  seem to break NUMA and other random boxes, so they will not be
	  heading for mainline any time soon.  If anyone has one of
	  these boxes and wishes to work on this, please let me know.
	- MSI cleanups and fixes to get things to work on ia64.
	- Other minor PCI and PCI bug fixes.


I still have a few outstanding patches in my TODO queue that I have not
applied to my quilt tree.  These patches do the following:
	- boot parameter to disable MSI
	- various PCI quirks added
	- remove PCI_LEGACY_PROC functionality.
	- more acpiphp driver fixes.
	- kzalloc cleanup for drivers/pci
	- cpqphp driver cleanups as found by the Coverty checker.
	- other minor things.

I hope to get to these by the end of the week, depending on other 2.6.16
stabilization work.  If you don't hear back from me by then, and you
have sent me a PCI or PCI Hotplug patch, please resend it and poke me
about it.

There are no new PCI driver API changes are pending that I am aware of.

Was this summary useful for people?  Anything that I should add to it?

thanks,

greg k-h
