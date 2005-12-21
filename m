Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVLUSnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVLUSnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVLUSnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:43:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45510 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751163AbVLUSno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:43:44 -0500
Date: Wed, 21 Dec 2005 12:42:30 -0600 (CST)
From: Mark Maule <maule@sgi.com>
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, Mark Maule <maule@sgi.com>
Message-Id: <20051221184337.5003.85653.32527@attica.americas.sgi.com>
Subject: [PATCH 0/4] msi abstractions and support for altix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch set to abstract portions of the MSI core so that it can be used on
architectures which don't use standard interrupt controllers.

1/4 msi-arch-init.patch
	Add an msi_arch_init() hook which can be used to perform platform
	specific setup prior to msi use.

2/4 msi-callouts.patch
	Define a set of callouts to implement the platform-specific tasks:

	msi_setup - set up plumbing to get a vector directed at a default
	    cpu, and return the corresponding MSI bus address and data.
	msi_teardown - inverse of msi_setup
	msi_target - retarget a vector to a given cpu

	Define the routine msi_register_callouts() which can be called from
	a platform's msi_arch_init() code to override the generic callouts.

3/4 ia64-per-platform-device-vector.patch
	For the ia64 arch, allow per-platform definitions of
	IA64_FIRST_DEVICE_VECTOR and IA64_LAST_DEVICE_VECTOR.
	
4/4 msi-altix.patch 
	Altix specific callouts to implement MSI.
