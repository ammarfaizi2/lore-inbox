Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVIAOtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVIAOtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbVIAOtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:49:22 -0400
Received: from usea-naimss2.unisys.com ([192.61.61.104]:33808 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S965168AbVIAOtV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:49:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Hot plug CPU to support physical add of newprocessors (i386)
Date: Thu, 1 Sep 2005 09:49:00 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D0E@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Hot plug CPU to support physical add of newprocessors (i386)
Thread-Index: AcWuysV3Ou5tphoXRmqJjJTYrCZs+QALjDJg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Shaohua Li" <shaohua.li@intel.com>
Cc: <zwane@arm.linux.org.uk>, "Raj, Ashok" <ashok.raj@intel.com>,
       <akpm@osdl.org>, <ak@suse.de>, <lhcs-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <hotplug_sig@lists.osdl.org>
X-OriginalArrivalTime: 01 Sep 2005 14:49:01.0290 (UTC) FILETIME=[4A66ACA0:01C5AF04]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> On Wed, 2005-08-31 at 20:13 +0800, 
> Natalie.Protasevich@unisys.com wrote:
> > Current IA32 CPU hotplug code doesn't allow bringing up processors 
> > that were not present in the boot configuration.
> > To make existing hot plug facility more practical for physical hot 
> > plug, possible processors should be encountered during boot for 
> > potentual hot add/replace/remove. On ES7000, ACPI marks all the 
> > sockets that are empty or not assigned to the partitionas as 
> > "disabled". The patch allows arrays/masks with APIC info 
> for disabled 
> > processors to be initialized. Then the OS can bring up a processor 
> > that was inserted in the socked and brought into 
> configuration during 
> > runtime.
> > To test the code, one can boot the system with maxcpu=1 and 
> then bring 
> > the rest of the processors up, which was not possible so far (only 
> > maxcpus number of nodes were created).
> > The patch also makes proc entry for interrupts dynamically 
> change to 
> > only show current onlined processors.
> Could we clean up the cpu_present_map a bit, like IA64 does? 
> Eg, if a new CPU is inserted, we allocated cpu id for it and 
> set cpu_present_map.
> Current alloc_cpu_id is just a workaround for suspend/resume 
> use, but isn't ok for physical cpu hotplug to me.
> 
> Thanks,
> Shaohua
> 
Sure, but this looks like independent task from the case I have with
ES7000. We don't have ACPI add/eject methods in AML to bring up new
processors so far (also thinking of implementing them). The IA64 code
also disregards the disabled processors, but ES7000 hot plug mechanism
only supports and relies on this deterministic method of topologically
pre-allocating APIC IDs by the platform.
Thanks,
--Natalie
