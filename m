Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVIIPXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVIIPXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVIIPXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:23:09 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:23651 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964902AbVIIPXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:23:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=eYVDLdFVKGWTvt7Op/e7nRoynkCd6Zsj1X4Jz/xCdqW9jPxaQ4wFWh5zlf/MMeJFDiiT6cQ8joGP7p3FEcb0U32acULi5fKaJjHzKHLIeq80sghGS7OKleOzGwBFckxFso5khkAR7v4SKhpTg01Wo/pe0lbD7LOgY/ivJ1GD1s4=  ;
Message-ID: <4321A8EE.9080206@yahoo.com.au>
Date: Sat, 10 Sep 2005 01:23:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] lockless pagecache 7/7
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au> <4317F136.4040601@yahoo.com.au> <4317F17F.5050306@yahoo.com.au> <4317F1A2.8030605@yahoo.com.au> <4317F1BD.8060808@yahoo.com.au> <4317F1E2.7030608@yahoo.com.au> <4317F203.7060109@yahoo.com.au> <Pine.LNX.4.62.0509090549110.7332@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509090549110.7332@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> For Itanium (and I guess also for ppc64 and sparch64) the performance of 
> write_lock/unlock is the same as spin_lock/unlock. There is at least 
> one case where concurrent reads would be allowed without this patch. 
> 

Yep, I picked up another one that was easy to make lockless (I'll send
out a new patchset soon), however the tagged lookup that was under read
lock is changed to a spin lock.

It shouldn't be too difficult to make the tag lookups (find_get_pages_tag)
lockless, however I just haven't gotten around to looking at the write
side of the tagging yet.

When that is done, there should be no more read locks at all.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
