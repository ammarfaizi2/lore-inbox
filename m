Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbVJGQAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbVJGQAf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbVJGQAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:00:34 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:38150 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S1030473AbVJGQAe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:00:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Fix hotplug cpu on x86_64
Date: Fri, 7 Oct 2005 11:00:27 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D9D@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix hotplug cpu on x86_64
Thread-Index: AcXLU3rmTw4NLerPQMqE71ceV60UnwAA5sig
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Brian Gerst" <bgerst@didntduck.org>
Cc: "lkml" <linux-kernel@vger.kernel.org>, "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 07 Oct 2005 16:00:27.0523 (UTC) FILETIME=[3C10ED30:01C5CB58]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I had to do the same in i386, but initially I was trying to 
> avoid the 
> > whole situation - allocating per_cpu data for all possible 
> processors.
> > It seemed wasteful that on the system with NR_CPU=256 or 512 and 
> > brought up as 4x everything per_cpu is (pre)allocated for all, 
> > although it's sure convenient. I though at the time it 
> would be great 
> > if
> > alloc_percpu() mechanism was able to dynamically re-create all the 
> > per_cpu's for new processors, that way cpu_possible_map woun't 
> > probably even be needed. Or is it too much trouble for too 
> little gain...
> > 
> > Thanks,
> > --Natalie
> > 
> 
> It certainly is possible.  In the hotplug cpu case, don't put 
> the .data.percpu section in __initmem.  It will then be 
> preserved for any cpus that come online after boot.
> 

I don't want to confuse Andrew, the patch is definitely correct and
needed...
 
It is more about "cold plug" case, when processors are not present
initially, but physically added to the systen during runtime. The
problem was not to preserve, but not to even allocate per_cpu for all
NR_CPUS, only for physically present processors. Then create per_cpu
with all the allocated data for the newly added processors. But as I
said it is probably too much to ask after all... :)
Thanks,
--Natalie
