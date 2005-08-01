Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVHAUeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVHAUeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVHAUeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:34:11 -0400
Received: from fmr18.intel.com ([134.134.136.17]:58025 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261246AbVHAUeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:34:00 -0400
Message-Id: <20050801202017.043754000@araj-em64t>
Date: Mon, 01 Aug 2005 13:20:17 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk
Subject: [patch 0/8] Updated patches for x86_64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch series contains some misc fixes related to CPU hotplug for X86_64.

Some are new, some are due to regressions from introduction of physflat mode
genapic schemes. Please consider for -mm. These are on 2.6.13-rc4-mm1

do_clustered_apic_check
	Needed for x86_64, removed recently from shared code.
create-sysfs-onlyfor-present-cpus
	Create sysfs entries only for present cpus. New cpus will have them
	created by ACPI code when notification for the same is processed.
fix-enforce-max-cpu
	Dont enforce this when CPU hotplug is enabled. This doesnt permit
	booting with maxcpus=1 and then testing logical hot-add of cpu.
fix-cluster-allbutself-ipi
	Cluster mode also needs to prevent preempt when excluding self from
	online map. Propagating the fix i added for genapic_flat to cluster
	genapic code as well.
fix-flat-mode-nobroadcast-again
	Recent physflat broke this for hotplug. Re-introducing it again.
fix-physflat-dmode
	Removed un-necessary code from physflat settings.
use-common-physflat-cluster
	Used common code for genapic-physflat and cluster since they share 
	a lot of code was duplicated instead of sharing them.
choose-physflat-onlyfor-gt8cpus-amd
	Choose physflat only when >8 cpus. We could still use flat mode without 
	broadcast shortcut. The mask version of IPI is still effective and 
	more performant than the unicast version thats required when we use
	physical mode.

Cheers,
ashok

