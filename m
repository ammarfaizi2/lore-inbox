Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbUKPQLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbUKPQLG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUKPQLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:11:05 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:17332 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262016AbUKPQK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:10:58 -0500
Message-ID: <419A2698.4080900@namesys.com>
Date: Tue, 16 Nov 2004 08:11:04 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sami Farin <7atbggg02@sneakemail.com>
CC: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vm-pageout-throttling.patch: hanging in throttle_vm_writeout/blk_congestion_wait
References: <20041115012620.GA5750@m.safari.iki.fi> <Pine.LNX.4.44.0411152140030.4171-100000@localhost.localdomain> <20041115223709.GD6654@m.safari.iki.fi>
In-Reply-To: <20041115223709.GD6654@m.safari.iki.fi>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Farin wrote:

>On Mon, Nov 15, 2004 at 09:56:29PM +0000, Hugh Dickins wrote:
>  
>
>>On Mon, 15 Nov 2004, Sami Farin wrote:
>>    
>>
>>>this time I had some swapspace on /dev/loop1 (file-backed, reiserfs,
>>>loop-AES-2.2d)...  I think (!) it caused this deadlock.
>>>      
>>>
>>That's not at all surprising.  See the swap_extent work Andrew did
>>for 2.5 (in mm/swapfile.c), by which swap to a swapfile now avoids
>>the filesystem altogether (except while swapon prepares the map of
>>disk blocks).  By swapping to a loop device over a file, you're
>>sneaking past his work, and putting the filesystem back under swap.
>>    
>>

Does Andrew's approach prevent putting swap on a compressed file (useful 
for reiser4 once the compression plugin is stable, not reiserfs)? (And 
no, I don't have any idea what the performance effect of that would be 
before it is tried and benchmarked....)
