Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVJFMgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVJFMgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 08:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVJFMgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 08:36:55 -0400
Received: from fmr16.intel.com ([192.55.52.70]:58284 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750845AbVJFMgz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 08:36:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PAE causing failure to run various executables.
Date: Thu, 6 Oct 2005 05:36:35 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6005EE9110@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PAE causing failure to run various executables.
Thread-Index: AcXJ9K4UZpCWwflGQcept2jCd165EAAfU84g
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "avi" <avi@argo.co.il>, "Dave Jones" <davej@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Oct 2005 12:36:36.0422 (UTC) FILETIME=[97594660:01C5CA72]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of avi
>Sent: Wednesday, October 05, 2005 2:32 PM
>To: Dave Jones
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: PAE causing failure to run various executables.
>
>Dave Jones wrote:
>
>>A fedora user recently filed a puzzling bug at
>>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=169741
>>
>>The system being reported has exactly 4GB, and its E820
>>tables seem to concur that there is in fact 4GB.
>>
>>When run in non-PAE mode, it triggers the
>>"Warning only 4GB will be used. Use a PAE enabled kernel."
>>message, which is odd, but the system does actually run.
>>
>>When run in PAE mode, it seems to lose its mind, and it
>>fails to run various binaries.
>>
>>Booting with mem=4G causes the machine to boot fine
>>(though for some reason, it finds only 3042M of RAM).
>>
>>  
>>
>looks like a 1GB hole.

Yes. E820 map here indeed shows 1GB of memory at higher than 32 bits
range.


>
>>The reporter of this bug has tested on 2.6.14-rc3-git4, and found the
>>same issue exists as he saw on the original FC3 kernel, thus 
>ruling out
>>any Fedora-specific patches.
>>
>>Anyone have any ideas what's wrong here?
>>
>>		
>>
>maybe the last 1GB is bad. since it can only be accessed by pae, only 
>the pae kernel fails.
>

Another possible reason can be NX(Execute Disable) support, which is 
active only on a PAE kernel. Trying "noexec=off" on a PAE kernel can be
tried here.

Thanks,
Venki
