Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVCXFtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVCXFtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVCXFtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:49:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:40940 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262694AbVCXFtF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:49:05 -0500
Message-ID: <424254E0.6060003@in.ibm.com>
Date: Thu, 24 Mar 2005 11:19:20 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Subject: [RFC] Obtaining memory information for kexec/kdump
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The topic of creating a common interface across 
architectures for obtaining system RAM information has been 
discussed on lkml and fastboot for a while now. Kexec needs 
information about the entire physical RAM present in the 
system while kdump needs information on the memory that the 
kernel has booted with.

The /proc/iomem interface is insufficient because its 
behavior varies across architectures.

- on i386, /proc/iomem reflects the memory that the system 
has booted with. But, it does not reflect memory above 4GB.
- on x86_64, /proc/iomem reflects the entire physical memory 
present irrespective of how much memory the kernel has 
booted with.
- on ppc64, /proc/iomem does not reflect system RAM at all.

The patches that follow provide two views in the proc file 
system so we have a common mechanism of extracting this 
information.

- A map of the entire physical memory present, irrespective 
of whether the system has been booted with mem= or memmap= 
options. This view comes up as /proc/physmem.

- A map of the memory currently used by the kernel. This map 
can be accessed as /proc/activemem. This view will vary from 
the previous one depending upon the values provided by mem= 
or memmap= options.

Since the patches made use of the "resource" struct to store 
and retrieve this information, some modifications were 
needed to convert the "start" and "end" fields of struct 
resource to u64. The first patch of the series makes this 
conversion. The rest of the patches provide the code for the 
two maps.

The patches are for the i386 and x86_64 architectures and 
against 2.6.12-rc1-mm1.

Kindly review and comment on the patches.

Thanks and Regards, Hari
