Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRDNHgL>; Sat, 14 Apr 2001 03:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130900AbRDNHfw>; Sat, 14 Apr 2001 03:35:52 -0400
Received: from geos.coastside.net ([207.213.212.4]:25796 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S130485AbRDNHfp>; Sat, 14 Apr 2001 03:35:45 -0400
Mime-Version: 1.0
Message-Id: <p05100b03b6fdad68353e@[207.213.214.34]>
In-Reply-To: <CDF99E351003D311A8B0009027457F1402FF5130-100000@ausxmrr501.us.dell.com>
In-Reply-To: <CDF99E351003D311A8B0009027457F1402FF5130-100000@ausxmrr501.us.dell.com>
Date: Sat, 14 Apr 2001 00:35:44 -0700
To: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC][PATCH] adding PCI bus information to SCSI layer
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4:34 PM -0500 2001-04-13, Matt Domsch wrote:
>What I'd like to do is add the PCI location of the SCSI controller to
>the information printed in /proc/scsi/scsi, as follows:
>
>Attached devices:
>Host: scsi0 Channel: 00 Id: 05 Lun: 00 PCI bus: 1 slot: 6 fn: 0
>  Vendor: NEC      Model: CD-ROM DRIVE:466 Rev: 1.06
>  Type:   CD-ROM                           ANSI SCSI revision: 02
>Host: scsi1 Channel: 00 Id: 00 Lun: 00 PCI bus: 0 slot: 2 fn: 1
>  Vendor: DELL     Model: PERCRAID RAID5   Rev: 0001
>  Type:   Direct-Access                    ANSI SCSI revision: 02
>Host: scsi1 Channel: 00 Id: 01 Lun: 00 PCI bus: 0 slot: 2 fn: 1
>  Vendor: DELL     Model: PERCRAID Stripe  Rev: 0001
>  Type:   Direct-Access                    ANSI SCSI revision: 02

Jeff Garzik proposed a scheme for ethtool that addresses somewhat similar needs for network interfaces. It's nice and general, and in particular works for non-PCI interfaces. Why not something like that for SCSI?

At 7:54 AM -0500 2001-03-21, Jeff Garzik wrote:
>In various scenarios where userland needs to interact with hardware,
>userland often needs to know exactly what driver (and driver version) is
>currently running on a given interface.  Hotplugging and other
>applications could -really- use the ability to find out bus information
>for a given interface.  Firmware
>
>So I propose the attached addition to the ethtool interface.  It adds a
>new structure with several ASCII text fields, which are filled in at the
>driver's discretion.  Userland then interprets these fields for their
>own evil designs.
>
>Currently (AFAIK) for all kernel interfaces, userland has no reliable
>way to associate a hardware device with a kernel interface, or a driver
>with a kernel interface[1].  Since we have no generic register_driver()
>interface, solving this problem means implementing a domain-specific
>solution like I have done here...
>
>--
>Jeff Garzik       | May you have warm words on a cold evening,
>Building 1024     | a full mooon on a dark night,
>MandrakeSoft      | and a smooth road all the way to your door.
>Index: include/linux/ethtool.h
>===================================================================
>RCS file: /cvsroot/gkernel/linux_2_4/include/linux/Attic/ethtool.h,v
>retrieving revision 1.1.1.2
>diff -u -r1.1.1.2 ethtool.h
>--- include/linux/ethtool.h	2000/11/14 22:01:49	1.1.1.2
>+++ include/linux/ethtool.h	2001/03/21 12:42:15
>@@ -24,10 +24,21 @@
> 	u32	reserved[4];
> };
> 
>+/* these strings are set to whatever the driver author decides... */
>+struct ethtool_drvinfo {
>+	char	driver[32];	/* driver short name, "tulip", "eepro100" */
>+	char	version[32];	/* driver version string */
>+	char	fw_version[32];	/* firmware version string, if applicable */
>+	char	bus_info[32];	/* Bus info for this interface.  For PCI
>+				 * devices, use pci_dev->slot_name. */
>+	char	reserved1[32];
>+	char	reserved2[32];
>+};
> 
> /* CMDs currently supported */
>-#define ETHTOOL_GSET		0x00000001 /* Get settings, non-privileged. */
>+#define ETHTOOL_GSET		0x00000001 /* Get settings. */
> #define ETHTOOL_SSET		0x00000002 /* Set settings, privileged. */
>+#define ETHTOOL_GDRVINFO	0x00000003 /* Get driver info. */
> 
> /* compatibility with older code */
> #define SPARC_ETH_GSET		ETHTOOL_GSET

-- 
/Jonathan Lundell.
