Return-Path: <linux-kernel-owner+w=401wt.eu-S932416AbXAPG1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbXAPG1r (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 01:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXAPG1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 01:27:47 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:44244 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932416AbXAPG1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 01:27:46 -0500
Message-Id: <20070116061516.899460000@bull.net>
User-Agent: quilt/0.45-1
Date: Tue, 16 Jan 2007 07:15:16 +0100
From: Nadia.Derbey@bull.net
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 0/6] Automatice kernel tunables (AKT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patches that introduces a feature that makes the kernel
automatically change the tunables values as it sees resources running out.

The AKT framework is made of 2 parts:

1) Kernel part:
Interfaces are provided to the kernel subsystems, to (un)register the
tunables that might be automatically tuned in the future.

Registering a tunable consists in the following steps:
- a structure is declared and filled by the kernel subsystem for the
registered tunable
- that tunable structure is registered into sysfs

Registration should be done during the kernel subsystem initialization step.


Another interface is provided to the kernel subsystems, to activate the
automatic tuning for a registered tunable. It can be called during resource
allocation to tune up, and during resource freeing to tune down the registered
tunable. The automatic tuning routine is called only if the tunable has
been enabled to be automatically tuning in sysfs.

2) User part:

AKT uses sysfs to enable the tunables management from the user world (mainly
making them automatic or manual).

akt uses sysfs in the following way:
- a tunables subsystem (tunables_subsys) is declared and registered during akt
initialization.
- registering a tunable is equivalent to registering the corresponding kobject
within that subsystem.
- each tunable kobject has 3 associated attributes, all with a RW mode (i.e.
the show() and store() methods are provided for them):
        . autotune: enables to (de)activate automatic tuning for the tunable
        . max: enables to set a new maximum value for the tunable
        . min: enables to set a new minimum value for the tunable

The only way to activate automatic tuning is from user side:
- the directory /sys/tunables is created during the init phase.
- each time a tunable is registered by a kernel subsystem, a directory is
created for it under /sys/tunables.
- This directory contains 1 file for each tunable kobject attribute



These patches should be applied to 2.6.20-rc4, in the following order:

[PATCH 1/6]: tunables_registration.patch
[PATCH 2/6]: auto_tuning_activation.patch
[PATCH 3/6]: auto_tuning_kobjects.patch
[PATCH 4/6]: tunable_min_max_kobjects.patch
[PATCH 5/6]: per_namespace_tunables.patch
[PATCH 6/6]: auto_tune_applied.patch

--
