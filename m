Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWDHQKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWDHQKf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 12:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWDHQKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 12:10:35 -0400
Received: from amdext3.amd.com ([139.95.251.6]:43472 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S965010AbWDHQKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 12:10:34 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Sat, 8 Apr 2006 10:43:22 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Andrew Morton" <akpm@osdl.org>
cc: johnstul@us.ibm.com, jim.cromie@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: 2.6.17-rc1-mm1 - detects buggy TSC on GEODE
Message-ID: <20060408164322.GF17356@cosmic.amd.com>
References: <20060407174129.67e0bc45.akpm@osdl.org>
MIME-Version: 1.0
In-Reply-To: <20060407174129.67e0bc45.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 08 Apr 2006 16:04:52.0095 (UTC)
 FILETIME=[2B5BA8F0:01C65B26]
X-WSS-ID: 682900AE3H43593836-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/06 17:41 -0700, Andrew Morton wrote:
> 
> Sorry, I should have cc'ed you on this :(
 
No worries. 

> > > 1.   the new kernel is now detecting the buggy TSC on the GEODE-sc1100
> > > 2.    the bug is apparently correctable by passing 'idle=poll' on kernel 
> > > boot-line.

I am assuming that this is the problem where the TSC doesn't roll over
correctly on the SC1100 and SC1200.

> > John, does this mean that enable-tsc-for-amd-geode-gx-lx.patch is only safe
> > to merge after all your time-management patches have gone in?

If that is the case, then the enable-tsc-for-amd-geode-gx-lx.patch is still
safe since the TSC on the GX and LX doesn't have that same problem.

For what its worth, we used to have a fix for the TSC issue back
in the 2.4 days that looked something like this:

#ifdef CONFIG_GEODE_SC1200
#define rdtsc(low,high) \
	__asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high)); \
	if ((unsigned long) low > 0xFFFFFFFC) high--
#else
#define rdtsc(low,high) \
	__asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
#endif

That seemed to work, but it is ugly, and I didn't bring it forward
when we moved to 2.6.  Perhaps we can revive it if there are SC1100/SC1200
users who need it.

Thanks,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

