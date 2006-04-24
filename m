Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWDXSOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWDXSOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 14:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWDXSOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 14:14:15 -0400
Received: from mga03.intel.com ([143.182.124.21]:17495 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751077AbWDXSOO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 14:14:14 -0400
X-IronPort-AV: i="4.04,152,1144047600"; 
   d="scan'208"; a="27109345:sNHT48968206"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Mon, 24 Apr 2006 11:14:04 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392DA239FC@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZnxgd91Avag54oRL6D8phpeS2MzAAA4liw
From: "Gross, Mark" <mark.gross@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
X-OriginalArrivalTime: 24 Apr 2006 18:14:12.0947 (UTC) FILETIME=[E3CBB230:01C667CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>Sent: Monday, April 24, 2006 10:50 AM
>To: Gross, Mark
>Cc: bluesmoke-devel@lists.sourceforge.net; LKML; Carbonari, Steven;
Ong,
>Soo Keong; Wang, Zhenyu Z
>Subject: RE: Problems with EDAC coexisting with BIOS
>
>On Llu, 2006-04-24 at 08:57 -0700, Gross, Mark wrote:
>> I think what I'm saying is pretty clear and I don't think it is
related
>> to whatever workarounds where done earlier.
>
>Ok. I was concerned as I seem to remember an earlier errata fix enabled
>the memory controller temporarily to do a workaround on one bridge. We
>hit this because it unconditionally disabled it afterwards and Intel
>sent fixes for RHEL4. I don't believe the workaround in question is in
>the current tree as it was fixed elsewhere.
>
>Just worried that if that is the case an SMI the wrong moment might
fail
>to apply the workaround.
>
>
>> >Why did Intel bother implementing this functionality and then
screwing
>> >it up so that OS vendors can't use it ? It seems so bogus.
>> >
>>
>> It was just a screw up not to have identified this issue sooner.
>
>Ok. So the intention was that the OS should also be able to access this
>material.
>

The E752x Si is made to allow access to the device / Function.  However;
when it's integrated onto a MoBo with BIOS there can be implementations
where we get into this coordination issue.

>> >At the very least we should print a warning advising the user that
the
>> >BIOS is incompatible and to ask the BIOS vendor for an update so
that
>> >they can enable error detection and management support.
>>
>> I would place the warning in the probe or init code.
>
>Agreed, and then bale out. Customer pressure should do the rest if the
>BIOS needs updating, or ACPI or similar need to grow a 'shared' API for
>this so the BIOS and OS can co-operate.
>

Yes and yes. 

I'm having trouble getting the dev0:fun1 hidden by bios test into the
e752x_init code.  It seems to be a shame having to fail the probe1 and
leave the driver loaded in memory.  Are there any recommendations on a
good way to do this?


--mgross
