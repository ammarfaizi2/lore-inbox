Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUG0EU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUG0EU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 00:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUG0EU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 00:20:29 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:51087 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266250AbUG0ET7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 00:19:59 -0400
Message-ID: <4105D7ED.5040206@yahoo.com.au>
Date: Tue, 27 Jul 2004 14:19:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Sweetman <safemode@comcast.net>
CC: Jan-Frode Myklebust <janfrode@parallab.uib.no>,
       linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy.
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net> <20040726091004.GA32403@ii.uib.no> <410500FD.8070206@comcast.net>
In-Reply-To: <410500FD.8070206@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:

> This is not the same problem as I and other are describing.  There is 
> no free memory when the OOM killer activates in our situation.  The 
> kernel has allocated all available ram and as such, the OOM killer 
> can't kill the memory hog because it's the kernel, itself.  So the OOM 
> killer kills all the big apps running ...but it's to no use because 
> the kernel just keeps trying to use more until the cd is completed.   
> After which the memory is still never released.
> Your thread has nothing to do with mine.
>

I believe it could be the same problem. Jan-Frode's system has all 
ZONE_NORMAL
memory used up. The free memory would be highmem which would be unsuable for
those allocations that are causing OOM.

The vfs_cache_pressure change could possibly be responsible for the 
problem...
I don't have the code in front of me, but I think it divides by 100 
first, then
multiplies by vfs_cache_pressure. I wouldn't have thought this would 
have such
a large impact though.


