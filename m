Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbUCRWXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 17:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbUCRWX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 17:23:29 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:36368 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263115AbUCRWXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 17:23:17 -0500
Date: Thu, 18 Mar 2004 22:21:45 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>
cc: anton@samba.org, ak@suse.de, raybry@sgi.com,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, mbligh@aracnet.com
Subject: Re: [Lse-tech] Re: Hugetlbpages in very large memory
 machines.......
Message-ID: <378619693.1079648505@[192.168.0.89]>
In-Reply-To: <1079644967.12704.216.camel@moss-spartans.epoch.ncsc.mil>
References: <40528383.10305@sgi.com> <20040313034840.GF4638@wotan.suse.de>	
 <20040313184547.6e127b51.akpm@osdl.org>	
 <20040314040634.GC19737@krispykreme>	
 <37640233.1079550324@42.150.104.212.access.eclipse.net.uk>	
 <20040318122524.3904db7d.akpm@osdl.org>
 <1079644967.12704.216.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: Mulberry/3.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 18 March 2004 16:22 -0500 Stephen Smalley <sds@epoch.ncsc.mil> wrote:

> On Thu, 2004-03-18 at 15:25, Andrew Morton wrote:
>> Seems reasonable, although "vm_enough_acctdom" makes my eyes pop.  Why
>> not keep the "vm_enough_memory" identifier?
>>
>> I've asked Stephen for comment - assuming he's OK with it I'd ask you to
>> finish this off please.

I have no emotional attachment to any of the names.  If we can come up with 
a more sensible name then all for the best.  I was trying to find something 
which implied the 'measurement' thing which didn't overlap with any of the 
other memory grouping concepts.  As the domains overlap nodes and zones.

> To keep the name, he needs to update all callers, right?  Current patch
> appears to add a static inline for security_vm_enough_memory that
> retains the old interface to avoid having to update most callers.

Yes this is the main reason for the name change.  This is at the dirty hack 
stage in that sense, minimal changes to prove the concept.  I think that we 
should be changing all the callers if this is going mainline in the longer 
term.  Although then the do cross 4 architecture and with it being in the 
security interface it also interfaces with selinux as well (sigh).

I'll put together a more complete change over of the interface, keep the 
name the same and see how intrusive that seems.  Then we'll get some 
testing on it.

> I don't have any fundamental problem with the nature of the change.  As
> a side note, patch was malformed (at least as I received it), not sure
> if that was just a problem on my end.

Steven, I'll send you a copy of the patch under separate cover.

-apw
