Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbVIAW5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbVIAW5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbVIAW5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:57:10 -0400
Received: from usea-naimss2.unisys.com ([192.61.61.104]:11274 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S1030474AbVIAW5I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:57:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Date: Thu, 1 Sep 2005 17:56:40 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D16@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Thread-Index: AcWvPAC8hePQHzIhQmuO8vq+B1hjmwAC9QjA
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Ashok Raj" <ashok.raj@intel.com>
Cc: <shaohua.li@intel.com>, <zwane@arm.linux.org.uk>, <akpm@osdl.org>,
       <ak@suse.de>, <lhcs-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <hotplug_sig@lists.osdl.org>
X-OriginalArrivalTime: 01 Sep 2005 22:56:41.0405 (UTC) FILETIME=[6AC9E6D0:01C5AF48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Ashok Raj [mailto:ashok.raj@intel.com] 
> Sent: Thursday, September 01, 2005 3:27 PM
> To: Protasevich, Natalie
> Cc: Ashok Raj; shaohua.li@intel.com; zwane@arm.linux.org.uk; 
> akpm@osdl.org; ak@suse.de; lhcs-devel@lists.sourceforge.net; 
> linux-kernel@vger.kernel.org; hotplug_sig@lists.osdl.org
> Subject: Re: [patch 1/1] Hot plug CPU to support physical add 
> of new processors (i386)
> 
> On Thu, Sep 01, 2005 at 04:09:09PM -0500, Protasevich, Natalie wrote:
> > > 
> > > > Current IA32 CPU hotplug code doesn't allow bringing up
> > > processors that were not present in the boot configuration. 
> > > > To make existing hot plug facility more practical for 
> physical hot 
> > > > plug, possible processors should be encountered during boot for 
> > > > potentual hot add/replace/remove. On ES7000, ACPI marks all the 
> > > > sockets that are empty or not assigned to the partitionas as 
> > > > "disabled". The patch allows arrays/masks with APIC info
> > > for disabled
> > > > processors to be
> > > 
> > > This sounds like a cluge to me. The correct 
> implementation would be 
> > > you would need some sysmgmt deamon or something that 
> works with the 
> > > kernel to notify of new cpus and populate apicid and grow 
> > > cpu_present_map. Making an assumption that disabled 
> APICID are valid 
> > > for ES7000 sake is not a safe assumption.
> > 
> > Yes, this is a kludge, I realize that. The AML code was not 
> there so 
> > far (it will be in the next one). I have a point here 
> though that if 
> > the processor is there, but is unusable (what "disabled" 
> means as the 
> > ACPI spec says), meaning bad maybe, then with physical hot 
> plug it can 
> > certainly be made usable and I think it should be taken into 
> > consideration (and into configuration). It should be counted as 
> > possible at least, with hot plug, because it represent 
> existing socket.
> 
> 
> I think marking it as present, and considering in 
> cpu_possible_map is perfectly ok. But we would need more glue 
> logic, that is if firmware marked it as disabled, then one 
> would expect you then run _STA and find that the CPU is now 
> present and functional as reported by _STA, then the CPU is onlinable.
> 
> So if _STA can work favorably in your case you can use it to 
> override the disabled setting at boot time which would be 
> prefectly fine.
> > 

We have a server control mechanism that sends appropriate messages and
notifications to the OS. The BIOS handles all the hardware level stuff,
including bringing the processor into appropriate state. The user level
driver handles those messages and uses OS facilities to bring up
processors and make them operational.

--Natalie 
> -- 
> Cheers,
> Ashok Raj
> - Open Source Technology Center
> 
