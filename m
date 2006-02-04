Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWBDPD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWBDPD3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 10:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWBDPD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 10:03:29 -0500
Received: from mail.gmx.de ([213.165.64.21]:34971 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932501AbWBDPD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 10:03:29 -0500
X-Authenticated: #7534793
Date: Sat, 4 Feb 2006 16:03:19 +0100
From: Gerhard Schrenk <deb.gschrenk@gmx.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: acpi_cpufreq broken after _PDC patch
Message-ID: <20060204150319.GA6704@mailhub.uni-konstanz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r655 (Debian)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

commit 05131ecc99ea9da7f45ba3058fe8a2c1d0ceeab8 breaks acpi_cpufreq for
an Intel Centrino notebook with Pentium M 1.60GHz (it's a Medion MD
95600 (aka MSI S260) notebook).

|gps@medusa:~/scratch/kernel-tree$ git bisect bad
|05131ecc99ea9da7f45ba3058fe8a2c1d0ceeab8 is first bad commit
|diff-tree 05131ecc99ea9da7f45ba3058fe8a2c1d0ceeab8 (from d2149b542382bfc206cb28485108f6470c979566)
|Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
|Date:   Sun Oct 23 16:31:00 2005 -0400
|
|    [ACPI] Avoid BIOS inflicted crashes by evaluating _PDC only once
|    
|    Linux invokes the AML _PDC method (Processor Driver Capabilities)
|    to tell the BIOS what features it can handle.  While the ACPI
|    spec says nothing about the OS invoking _PDC multiple times,
|    doing so with changing bits seems to hopelessly confuse the BIOS
|    on multiple platforms up to and including crashing the system.
|    
|    Factor out the _PDC invocation so Linux invokes it only once.
|    
|    http://bugzilla.kernel.org/show_bug.cgi?id=5483
|    
|    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
|    Signed-off-by: Len Brown <len.brown@intel.com>

The error message is

|gps@medusa:~$ sudo modprobe acpi_cpufreq
|FATAL: Error inserting acpi_cpufreq
|(/lib/modules/2.6.15-rc3-bisect1/kernel/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.ko):
|No such device

Unfortunately 

  git revert 05131ecc99ea9da7f45ba3058fe8a2c1d0ceeab8 

does not work without merge conflict on top of Linus' tree.

-- Gerhard
