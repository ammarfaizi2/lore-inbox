Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbVLXJQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbVLXJQh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 04:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030611AbVLXJQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 04:16:37 -0500
Received: from silver.veritas.com ([143.127.12.111]:14011 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030544AbVLXJQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 04:16:36 -0500
Date: Sat, 24 Dec 2005 09:16:48 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: "David S. Miller" <davem@davemloft.net>, michael.bishop@APPIQ.com,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: More info for DSM w/r/t sunffb on 2.6.15-rc6
In-Reply-To: <Pine.LNX.4.64.0512240029581.14098@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0512240909380.18709@goblin.wat.veritas.com>
References: <DF925A10E7204748977502BECE3D11230100CD7C@exch02.appiq.com>
 <20051223.111940.17674086.davem@davemloft.net> <Pine.LNX.4.64.0512231223040.14098@g5.osdl.org>
 <20051223.154509.86780332.davem@davemloft.net> <Pine.LNX.4.64.0512240029581.14098@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Dec 2005 09:16:36.0247 (UTC) FILETIME=[BD522270:01C6086A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Dec 2005, Linus Torvalds wrote:
> On Fri, 23 Dec 2005, David S. Miller wrote:
> >                                          
> > +	if (!(vma->vm_flags & VM_SHARED))
> > +		return -EINVAL;
> > +
> 
> Side note - as I explained to Nick the other week, VM_SHARED really means 
> "shared _writable_" mapping, so you're now disallowing a shared read-only 
> open too.
> 
> Which may be fine, of course. Especially if sbusfb always ends up giving a 
> writable pfn-mapping. But I wanted to check that that was what you meant 
> to do.
> 
> To test for MAP_SHARED, either do the is_cow_mapping() thing, or check 
> the VM_MAYSHARE bit.

I wondered over that too.  Concluded that at the moment it's right for
the test to be on VM_SHARED, because it's secretly giving away shared
write permission.  But in future, once that's been corrected, such checks
would do better to check for VM_MAYSHARE (i.e. reject all MAP_PRIVATE).

Hugh
