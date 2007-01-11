Return-Path: <linux-kernel-owner+w=401wt.eu-S965342AbXAKJ1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965342AbXAKJ1l (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 04:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965345AbXAKJ1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 04:27:41 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:28757 "HELO
	smtp101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965342AbXAKJ1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 04:27:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=MBJ6uK4AtKhy5/BzmQtgBBAxd4Pu8yixhpycJ83uTxddrXIhfLMmWnp7nL+rjAibGZRtPd3nlvqWLBEYBlmz8aFy1CvUnagDto2PjHPmunSHL13EpcACFoBwrnW1AcMLtB4pR26fQAyCN/ouOYkXr/i22MMDAjQ6enUOeFhzLFc=  ;
X-YMail-OSG: XBuY2I8VM1kbhJ7jj8yYYRCKUqDzV6rYkldUVYLuEXfMf1C69vgU6uW2YNVtCInpfR4czM8xkJKuv0CWydpXb7SBxrLfOsXp.D4dSei778UoyBZXkL5Yq004lq7FAQL3V.AQG02wXcWtn8Q-
Message-ID: <45A602F0.1090405@yahoo.com.au>
Date: Thu, 11 Jan 2007 20:27:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
References: <20070110223731.GC44411608@melbourne.sgi.com> <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com> <20070110230855.GF44411608@melbourne.sgi.com> <45A57333.6060904@yahoo.com.au> <20070111003158.GT33919298@melbourne.sgi.com> <45A58DFA.8050304@yahoo.com.au> <20070111012404.GW33919298@melbourne.sgi.com>
In-Reply-To: <20070111012404.GW33919298@melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner wrote:
> On Thu, Jan 11, 2007 at 12:08:10PM +1100, Nick Piggin wrote:

>>>So, what I've attached is three files which have both
>>>'vmstat 5' output and 'iostat 5 |grep dm-' output in them.
>>
>>Ahh, sorry to be unclear, I meant:
>>
>>  cat /proc/vmstat > pre
>>  run_test
>>  cat /proc/vmstat > post
> 
> 
> Ok, I'll get back to you on that one - even at 600+MB/s, writing 5TB
> of data takes some time....

OK, according to your vmstat deltas, you are doing an order of magnitude
more writeout off the LRU with 2.6.20-rc3 default than with the smaller
dirty_ratio (53GB of data vs 4GB of data). 2.6.18 does not have that stat,
unfortunately.

allocstall and direct reclaim are way down when the dirty ratio is lower,
but those numbers with vanilla 2.6.20-rc3 are comparable to 2.6.18, so
that shows that kswapd in 2.6.18 is probably also having trouble which may
mean it is also writing out a lot off the LRU.

You're not turning on zone_reclaim, by any chance, are you?

Otherwise, nothing jumps out at me yet. I'll have a bit of a look through
changelogs tomorrow. I guess it could be a pdflush or vmscan change (XFS,
maybe?).

Can you narrow it down at all?

THanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
