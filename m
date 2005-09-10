Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVIJF2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVIJF2U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 01:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbVIJF2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 01:28:20 -0400
Received: from ppp59-167.lns1.cbr1.internode.on.net ([59.167.59.167]:51461
	"EHLO triton.bird.org") by vger.kernel.org with ESMTP
	id S932205AbVIJF2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 01:28:19 -0400
Message-ID: <43226FDA.4070607@acquerra.com.au>
Date: Sat, 10 Sep 2005 15:32:10 +1000
From: Anthony Wesley <awesley@acquerra.com.au>
Reply-To: awesley@acquerra.com.au
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nate.diller@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13 buffer strangeness
References: <432151B0.7030603@acquerra.com.au>	 <EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com>	 <5c49b0ed05090914394dba42bf@mail.gmail.com>	 <432225E0.9030606@acquerra.com.au>	 <5c49b0ed0509091735436260bb@mail.gmail.com>	 <432231B7.2060200@acquerra.com.au>	 <5c49b0ed0509091847135834c0@mail.gmail.com>	 <432243AA.4000508@acquerra.com.au> <5c49b0ed05090922021b8f8112@mail.gmail.com>
In-Reply-To: <5c49b0ed05090922021b8f8112@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Diller wrote:
> just found the culprit.  guess i should have read the code the first 
> time.  get_dirty_limits() in drivers/block/page_writeback.c has a 
> hard-coded upper limit to dirty_ratio.  it's capped to half of the 
> unmapped pages, so maybe 30-40% of your system's memory.  so if you are 
> brave, just remove the "/ 2" parts from the 'if (dirty_ratio > 
> unmapped_ratio / 2) dirty_ratio = unmapped_ratio / 2;' check, and you 
> can have all the OOM goodness you want.

Excellent. OOM here I come.

> i really recommend you focus on getting better disk bandwidth, you stand 
> to gain a lot more from that approach.  i presume you're on ext3; 
> perhaps you should try reiser4 or xfs, they are more likely to meet your 
> disk bandwidth requirements.

Yep, pursuing this as well, also looking to add more RAM to the machine. At this stage
I was just trying to understand the numbers that I was seeing, so I could work out the
best way to proceed.

I'm using ext2 at the moment, on the assumption that the journal would cost 
me a bit of performance so I left it out :-)

I'll certainly try the other filesystems as you suggest.

Thanks again, Anthony

-- 
Anthony Wesley
Director and IT/Network Consultant
Smart Networks Pty Ltd
Acquerra Pty Ltd

Anthony.Wesley@acquerra.com.au
Phone: (02) 62595404 or 0419409836
