Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271679AbVBDEP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271679AbVBDEP3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 23:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271703AbVBDEP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 23:15:29 -0500
Received: from stinkfoot.org ([65.75.25.34]:22977 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S271679AbVBDEPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 23:15:17 -0500
Message-ID: <4202F725.8040509@stinkfoot.org>
Date: Thu, 03 Feb 2005 23:16:37 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e1000, sshd, and the infamous "Corrupted MAC on input"
References: <42019E0E.1020205@stinkfoot.org> <20050203070415.GC17460@waste.org>
In-Reply-To: <20050203070415.GC17460@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Wed, Feb 02, 2005 at 10:44:14PM -0500, Ethan Weinstein wrote:
...
>>Finally, I used a crossover cable between the two boxes, which resulted 
>>in the same error from sshd again.
> 
> 
> Well ssh isn't an especially good test as it's hard to debug.
> 
> Try transferring large compressed files via netcat and comparing the
> results. eg:
> 
> host1# nc -l -p 2000 > foo.bz2
> 
> host2# nc host1 2000 < foo.bz2
> 
> If the md5sums differ, follow up with a cmp -bl to see what changed.
> 
> Then we can look at the failure patterns and determine if there's some
> data or alignment dependence.
> 

Excellent tip, thanks.  I was able to reprodce the problem several times 
using this technique with nc, however the problem was intermittent (as 
nasty problems like this often are).  I used a 1.3G gzipped tarball and 
  experienced several botched transfers along with a few good ones.  To 
be fair, I also switched back to 100Fdx and repeated; I didn't get a 
single failure at this speed over 25 or so runs.

The results of two cmp's are here:

http://www.stinkfoot.org/e1000tests.out

What next?

-Ethan
