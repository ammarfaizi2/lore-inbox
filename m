Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTE2U5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTE2U5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:57:43 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:15001
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S262850AbTE2U5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:57:37 -0400
Date: Thu, 29 May 2003 17:10:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] net driver merges
Message-ID: <20030529211053.GA9069@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others may download the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.70-bk3-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/8139too.c        |    6 
 drivers/net/amd8111e.c       | 1047 +++++++++++++++++++++++++++----------------
 drivers/net/amd8111e.h       |  968 ++++++++++++++++++++-------------------
 drivers/net/e100/e100_main.c |   33 -
 drivers/net/pci-skeleton.c   |    4 
 drivers/net/pcnet32.c        |    7 
 drivers/net/r8169.c          |   44 +
 drivers/net/tlan.c           |  116 +++-
 8 files changed, 1306 insertions(+), 919 deletions(-)

through these ChangeSets:

<shemminger@osdl.org> (03/05/29 1.1438)
   [netdrvr e100] initialize callbacks before registering netdev
   
   Ouch.

<reeja.john@amd.com> (03/05/29 1.1437)
   [netdrvr amd8111e] interrupt coalescing, libmii, bug fixes
   
   * Dynamic interrupt coalescing
   * mii lib support
   * dynamic IPG support (disabled by default)
   * jumbo frame fix
   * vlan fix
   * rx irq coalescing fix

<alan@lxorguk.ukuu.org.uk> (03/05/29 1.1436)
   [netdrvr tlan] fix 64-bit issues

<jgarzik@redhat.com> (03/05/29 1.1435)
   [netdrvr r8169] use alloc_etherdev, pci_disable_device

<jgarzik@redhat.com> (03/05/29 1.1433)
   [netdrvr 8139too] respond to "isn't this racy?" comment

<jgarzik@redhat.com> (03/05/28 1.1432)
   [netdrvr] s/init_etherdev/alloc_etherdev/ in code comments,
   in 8139too and pci-skeleton drivers.

<jgarzik@redhat.com> (03/05/28 1.1431)
   [netdrvr tlan] cleanup
   
   * use pci_{request,release}_regions for PCI devices
   * use alloc_etherdev (fixes race)
   * propagate error returns from pci_xxx function errors

<engebret@us.ibm.com> (03/05/27 1.1392.7.7)
   [netdrvr pcnet32] bug fixes
   
   I would like to see a couple of the pcnet32 changes that I think we can
   agree on be put into the trees so a couple of the potential defects can be
   avoided.  The following patch contains just these pieces.  The only
   controversial one is an arbitrary change in the number of iterations in a
   while loop spinning on hardware state.   No matter how this is done, I am
   not especially fond of this bit of code as it has no reasonable error
   recovery path -- however, as a half-way, incremental solution, increasing
   the polling time should help as the 100 value was certainly found to be
   insufficient.  1000 may not be sufficient either, but it is certainly no
   worse.
   
   Both of the other changes were hit in testing (and I belive the wmb() at a
   customer even), so it would help reduce some debug if these go in.  Any
   feedback is appreciated - thanks.

