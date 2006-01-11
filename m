Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWAKPxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWAKPxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 10:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWAKPxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 10:53:04 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:7395 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751158AbWAKPxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 10:53:03 -0500
Date: Wed, 11 Jan 2006 09:52:51 -0600 (CST)
From: Mark Maule <maule@sgi.com>
To: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, gregkh@suse.de,
       Mark Maule <maule@sgi.com>
Message-Id: <20060111155251.12460.71269.12163@attica.americas.sgi.com>
Subject: [PATCH 0/3] msi abstractions and support for altix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend #3: misc fixups

Patch set to abstract portions of the MSI core so that it can be used on
architectures which don't use standard interrupt controllers.

Changes from Resend #2 to Resend #3:

+ Cleanup the ia64 platform_msi_init macro so it works on non-altix ia64

Changes from initial version to Resend #2:

+ Change uintXX_t to uXX
+ Change _callouts to _ops
+ Renamed the _generic routines to _apic and moved them to a new file
  msi-apic.c
+ Have each msi_arch_init() routine call msi_register() with the desired
  msi ops for that platform.
+ Moved msi_address, msi_data, and related defs out of msi.h and into
  msi-apic.c, replaced by shifts/masks.
+ Rolled msi-arch-init.patch and msi-callouts.patch into a single msi-ops.patch

Mark

1/3 msi-ops.patch
	Add an msi_arch_init() hook which can be used to perform platform
	specific setup prior to msi use.

	Define a set of msi ops to implement the platform-specific tasks:

	    setup - set up plumbing to get a vector directed at a default
		cpu, and return the corresponding MSI bus address and data.
	    teardown - inverse of msi_setup
	    target - retarget a vector to a given cpu

	Define the routine msi_register() called from msi_arch_init()
	to set the desired ops.

	Move a bunch of apic-specific code out of the msi core .h/.c and
	into a new msi-apic.c file.

2/3 ia64-per-platform-device-vector.patch
	For the ia64 arch, allow per-platform definitions of
	IA64_FIRST_DEVICE_VECTOR and IA64_LAST_DEVICE_VECTOR.
	
3/3 msi-altix.patch 
	Altix specific callouts to implement MSI.
