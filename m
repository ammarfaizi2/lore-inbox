Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263237AbVBDBbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263237AbVBDBbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVBDB2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:28:50 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:20066 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263343AbVBDBUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:20:04 -0500
Message-ID: <4202CDBF.9070304@yahoo.com.au>
Date: Fri, 04 Feb 2005 12:19:59 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: terje_fb@yahoo.no, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: 2.6.10: kswapd spins like crazy
References: <20050203195033.29314.qmail@web51608.mail.yahoo.com>	<4202BE05.9090901@yahoo.com.au>	<4202C839.8000103@yahoo.com.au> <20050203171638.668f2892.akpm@osdl.org>
In-Reply-To: <20050203171638.668f2892.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Oh, attached should be a minimal fix if you would like to try it out.
>>
>>
>>...
>>--- linux-2.6/mm/vmscan.c~vmscan-minfix	2005-02-04 11:52:37.000000000 +1100
>>+++ linux-2.6-npiggin/mm/vmscan.c	2005-02-04 11:53:32.000000000 +1100
>>@@ -575,6 +575,7 @@ static void shrink_cache(struct zone *zo
>> 			nr_taken++;
>> 		}
>> 		zone->nr_inactive -= nr_taken;
>>+		zone->pages_scanned += nr_scan;
>> 		spin_unlock_irq(&zone->lru_lock);
>> 
>> 		if (nr_taken == 0)
>>
> 
> 
> Any theories as to why these pages aren't being activated and aren't being
> reclaimed?
> 
> 

No none yet, which is what we should get to the bottom of. I must be
overlooking something, but the only ways I can see should be due to
transient conditions like page locked or under writeback. laptop_mode?

Terje, what is /proc/sys/vm/laptop_mode set to?

