Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUCSDTF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 22:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUCSDTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 22:19:05 -0500
Received: from fmr10.intel.com ([192.55.52.30]:30858 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S262182AbUCSDS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 22:18:59 -0500
Subject: how to disable HT
From: Len Brown <len.brown@intel.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1079666329.3274.55.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Mar 2004 22:18:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BIOS SETUP is the best method to disable HT.  But sometimes
that isn't practical, so disabling at Linux boot-time is needed.

Most OEMs' BIOS enumerates primary logical processors before
secondary logical processors -- so reducing NR_CPUS at build-time
can start a processor per package before hitting the limit --
effectively disabling HT.

2.6.5-rc1-mm2 includes a patch that allows boot-time maxcpus=N to
work the same as NR_CPUS=N:

http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm2/broken-out/bk-acpi.patch

It moves maxcpus=N earlier to cpu enumeration time
from CPU startup time.

So if disabling HT at boot-time is important to you, please
try it out and comment on the success/failure in the bug report:
http://bugzilla.kernel.org/show_bug.cgi?id=2317

I expect that it will work on most systems, but not all, and so it
is important to look in dmesg to verify that it disabled the
secondary logical processors at intended.

eg. system with 4 logical processors booted with maxcpus=2:

Total of 2 processors activated (11091.96 BogoMIPS). 
WARNING: No sibling found for CPU 0. 
WARNING: No sibling found for CPU 1. 

thanks,
-Len


