Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbVKAFQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbVKAFQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVKAFQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:16:49 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:22662 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965025AbVKAFQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:16:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=03sYZ+dwrupYIkTylX7YpABlSFrWOjAA7DPAVjVv2yxgFtwUDHT/QNtG4e7IoWRWg2CgEarhjMlejn0tAwYo+Og5vNAd80+GiZ70wjM8dbV+Xgi48qVxdhv64t2Gf8DRsn2ccwJTFYhvvxZgx3Kn+8iCQPrg6y8XO0q4eZuciu8=  ;
Message-ID: <4366FA9A.20402@yahoo.com.au>
Date: Tue, 01 Nov 2005 16:18:18 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] better zone and watermark balancing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset I have had around for a long time and improves
various zone and watermark balancing by making calculations
more logical.

When reading 128GB through the pagecache, in 4 concurrent
streams, the final page residency and total reclaim ratios
look like this (no highmem, ~900MB RAM):

2.6.14-git3
DMA pages=  2214, scan= 124146
NRM pages=215966, scan=3990129

      Pages  Scan
DMA  01.01  03.01
NRM  98.99  96.99


2.6.14-git3-vm
DMA pages=  2220, scan=  99264
NRM pages=216373, scan=4011975

      Pages  Scan
DMA  01.01  02.41
NRM  98.99  97.59

So in this case, DMA is still getting a beating, but things have
improved nicely. Now are results with highmem and ~4GB RAM:

2.6.14-git3
DMA pages=0, scan=0
NRM pages=177241, scan=1607991
HIG pages=817122, scan=1607166

     Pages  Scan
DMA 00.00  00.00
NRM 17.83  50.01
HIG 82.17  49.99

2.6.14-git3-vm
DMA pages=0, scan=0
NRM pages=178215, scan=553311
HIG pages=815771, scan=2757744

     Pages  Scan
DMA 00.00  00.00
NRM 17.92  16.71
HIG 82.07  83.28

Current kernels are abysmal, while the patches bring scanning to
an almost perfect ratio.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
