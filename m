Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275481AbTHNUDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275482AbTHNUDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:03:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:44521 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275481AbTHNUDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:03:09 -0400
Message-Id: <200308142002.h7EK2ro26422@mail.osdl.org>
Date: Thu, 14 Aug 2003 13:02:50 -0700 (PDT)
From: markw@osdl.org
Subject: Re: bounce buffers and i/o schedulers with aacraid
To: akpm@osdl.org
cc: piggin@cyberone.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20030813170007.61694cbb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Aug, Andrew Morton wrote:
> markw@osdl.org wrote:
>>
>> We're still trying to avoid bounce buffers with the aacraid driver and
>> noticed something interesting in some profiles (which I'll copy farther
>> down) with the deadline scheduler and AS.  Using our DBT-2 workload, we
>> see with the deadline scheduler our patch to avoid bounce buffers
>> doesn't change the profile much.  But with AS, we don't see
>> bounce_copy_vec or __blk_queue_bounce near the top of the profile.  Any
>> ideas why?
> 
> It shouldn't make any difference.
> 
> One thing to be careful about is to make sure that the pages which are
> being put under I/O are in the same place across different tests.
> 
> Suppose your machine already had 3G of pagecache and you then run the test.
> You would magically find that newly allocated pages come out of
> ZONE_NORMAL and no bouncing is needed for them.  So the moral is to make
> sure that the starting conditions are the same for each test: almost all
> memory free.

I think we've tracked the problem to old firmware on the raid
controllers we have.  They'll be upgraded shortly.

Mark
