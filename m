Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270490AbTHQSb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 14:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270489AbTHQSb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 14:31:57 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:37033
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S270490AbTHQSbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 14:31:43 -0400
Date: Sun, 17 Aug 2003 14:31:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [bk patches] net driver updates
Message-ID: <20030817183137.GA18521@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.6

Patch is also available at

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test3-bk5-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/Kconfig               |   11 
 drivers/net/Makefile              |    1 
 drivers/net/Makefile.lib          |    1 
 drivers/net/arcnet/com20020-pci.c |    6 
 drivers/net/arcnet/com20020.c     |   31 
 drivers/net/arcnet/com90io.c      |   17 
 drivers/net/hydra.c               |   24 
 drivers/net/sis190.c              | 2094 +++++++++++++++++++++++++++++---------
 drivers/net/tokenring/3c359.c     |    2 
 drivers/net/tokenring/olympic.c   |    3 
 drivers/net/tulip/tulip_core.c    |    1 
 drivers/net/wan/z85230.c          |    6 
 drivers/net/wireless/airo.c       |   12 
 drivers/net/wireless/atmel_cs.c   |    1 
 14 files changed, 1715 insertions(+), 495 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/08/17 1.1217)
   [netdrvr sis190] allocate RX/TX descriptors using PCI DMA API
   
   The RX buffers themselves still need to be converted.  The three
   places that need fixing are marked with #warning.

<ionut@badula.org> (03/08/17 1.1216)
   [netdrvr tulip] add pci id for 3com 3CSOHO100B-TX

<jgarzik@redhat.com> (03/08/17 1.1215)
   [netdrvr sis190] manually clean up formatting a bit more
   
   Also, two trivial code changes:
   * add unlikely() to assert() definition
   * fix MODULE_AUTHOR email address brackets

<jgarzik@redhat.com> (03/08/17 1.1214)
   [netdrvr sis190] Lindent sis190.  zero code changes.

<jgarzik@redhat.com> (03/08/17 1.1213)
   [netdrvr] add sis190 gigabit ethernet driver (note: needs work)

<shemminger@osdl.org> (03/08/17 1.1212)
   [PATCH] Make z8530.c build on 2.6
   
   Either we need to mark this driver (and the parts that use them) as BROKEN,
   or at least get it building again.
   
   With this it builds, but of course, I don't have the real hardware.

<rddunlap@osdl.org> (03/08/17 1.1211)
   [netdrvr hydra] janitor cleanups

<achirica@telefonica.net> (03/08/17 1.1210)
   [wireless airo] Fix PCI unregister code

<achirica@telefonica.net> (03/08/17 1.1209)
   [wireless airo] Turns on spy code in wireless extensions v16

<jgarzik@redhat.com> (03/08/17 1.1208)
   [arcnet com90io] replace check_region with temporary request_region,
   in probe phase.

<jgarzik@redhat.com> (03/08/17 1.1207)
   [arcnet com20020] misc fixes
   
   * com20020_close expects two arguments (and actually uses the
     second argument), but the arcnet layer only passes one arg.
     Fun ensues.
   * Remove __devinit markers, this is a library module.
   * Move request_region up in com20020_found, to make the call
     occur before the first I/O access in the function.

<jgarzik@redhat.com> (03/08/17 1.1206)
   [arcnet com20020] check_region removal, ->name removal breakage fix

<jgarzik@redhat.com> (03/08/17 1.1205)
   [netdrvr] clean up driver object name removal breakage
   
   Affected drivers: atmel_cs, olympic, 3c359

