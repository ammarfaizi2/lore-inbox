Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbTD1RFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbTD1RFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:05:38 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:46583 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261212AbTD1RFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:05:37 -0400
Message-ID: <3EAD61FB.30907@us.ibm.com>
Date: Mon, 28 Apr 2003 10:16:43 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
CC: Andi Kleen <ak@suse.de>, Henti Smith <bain@tcsn.co.za>,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       Riley Williams <Riley@Williams.Name>
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD5AC1.7090003@us.ibm.com> <3EAD5D90.7010101@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Cool. Sorry to be pestering about the 64-bit limits, but can we really
> use 2^64 bytes of memory on ia64/ppc64/x86-64 etc.? (AFAIK, 64-bit
> arches don't suffer from a small ZONE_LOWMEM.)

First of all, I'm not sure any of the 64-bit arches even fully support
64-bit physical addresses.  If I remember correctly the first hammers
support 40 bits, with more to be added later.  Power4 is in close to the
same boat, but I know they go up to 256GB today (I seem to recall
something about 44-bit being the limit, though).

Don't forget that highmem starts to be needed before the 4G boundary.
The kernel has only 1GB of virtual space (look for PAGE_OFFSET, which
defines it), which means that you start needing to pull all of the
highmem trickery before you get to the actual limits.

Nobody knows how far it will go.  It's fairly safe to say that, at this
rate, Linux will keep up with whatever hardware anyone produces.
Unless, of course, someone gets even more perverse than PAE. :)

-- 
Dave Hansen
haveblue@us.ibm.com

