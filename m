Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVBXPbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVBXPbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVBXPbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:31:06 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:40353 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262375AbVBXPYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:24:41 -0500
Subject: [RFC][PATCH 0/3] Kdump: Overview
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1109261749.5148.807.camel@terminator.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Feb 2005 21:45:49 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following set of patches go one step ahead in restoring the broken kdump
functionality in -mm tree on x86. Most of the kdump functionality has
now moved to kexec user space (kexec-tools).

This patch set performs following.

kexec-tool-1.101
(http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.101.tar.gz)
-----------------------------------------------------------------------

- Create a backup region and copy the first 640K of memory to backup
  region over a crash.
- Generate Elf headers representing crashed memory and store in reserved
  region. Also appends the memmap= and elfcorehdr= parameters to command
  line internally to be passed to capture kernel.


2.6.11-rc4-mm1
--------------
- Export address of start of crash notes section (crash_notes) to user
  space through sysfs

I look forward for comments and suggestions. I have done basic testing
on uni and 4way (SMT) systems. 


2.6.11-rc4-mm1 does not boot if booted with kexec enabled and
crashkernel=X@Y is passed as command line parameter. Following patch
needs to be applied to rectify the problem.

http://lkml.org/lkml/2005/2/24/51


Thanks
Vivek

