Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268143AbTB1Une>; Fri, 28 Feb 2003 15:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268141AbTB1Une>; Fri, 28 Feb 2003 15:43:34 -0500
Received: from fmr02.intel.com ([192.55.52.25]:4049 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268150AbTB1Unb>; Fri, 28 Feb 2003 15:43:31 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A1BB@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: ACPI patches updated (20030228)
Date: Fri, 28 Feb 2003 12:53:33 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The ACPI patches against 2.4 and 2.5 have been updated and are now
available from http://sf.net/project/acpi . The non-Linux-specific
releases should be available from
http://developer.intel.com/technology/iapc/acpi/downloads.htm hopefully
by tonight but possibly as late as Monday evening.

This includes a LOT of fixes for longstanding bugs. If you have had
issues in the past with long delays or oopses on reads from the battery
interface, hangs on boot, or excessive ACPI interrupts causing system
slowness, please try this patch.

The incorrect "mem=" additions are still in these patches, sorry. I will
remove them in the next update.

Regards -- Andy

---------------------------------------
28 February 2003.  Summary of changes for version 20030228.

1) Linux

S3 fixes (Ole Rohne)

Update ACPI PHP driver with to use new acpi_walk_resource API
(Bjorn Helgaas)

(2.5) Add S4BIOS support (Pavel Machek)

Map in entire table before performing checksum (John Stultz)

Expand the mem= cmdline to allow the specification of reserved
and ACPI DATA blocks (Pavel Machek)

Never use ACPI on VISWS

Fix derive_pci_id (Ducrot Bruno, Alvaro Lopez)

Revert a change that allowed P_BLK lengths to be 4 or 5. This is
causing us to think that some systems support C2 when they really
don't.

Do not count processor objects for non-present CPUs (Thanks to
Dominik Brodowski)

2) ACPI CA Core Subsystem:

The GPE handling and dispatch code has been completely overhauled
in preparation for support of GPE Block Devices (ID ACPI0006).
This affects internal data structures and code only; there should
be no differences visible externally.  One new file has been
added, evgpeblk.c

The FADT fields GPE0_BLK_LEN and GPE1_BLK_LEN are now the only
fields that are used to determine the GPE block lengths.  The
REGISTER_BIT_WIDTH field of the X_GPEx_BLK extended address
structures are ignored.  This is per the ACPI specification but
it isn't very clear.  The full 256 Block 0/1 GPEs are now
supported (the use of REGISTER_BIT_WIDTH limited the number of
GPEs to 128).

In the SCI interrupt handler, removed the read of the PM1_CONTROL
register to look at the SCI_EN bit.  On some machines, this read
causes an SMI event and greatly slows down SCI events.  (This may
in fact be the cause of slow battery status response on some
systems.)

Fixed a problem where a store of a NULL string to a package
object could cause the premature deletion of the object.  This
was seen during execution of the battery _BIF method on some
systems, resulting in no battery data being returned.

Added AcpiWalkResources interface to simplify parsing of resource
lists.


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

