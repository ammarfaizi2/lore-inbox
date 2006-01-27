Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWA0Kds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWA0Kds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWA0Kds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:33:48 -0500
Received: from [85.8.13.51] ([85.8.13.51]:7897 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1030289AbWA0Kds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:33:48 -0500
Message-ID: <43D9F705.5000403@drzeus.cx>
Date: Fri, 27 Jan 2006 11:33:41 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de>
In-Reply-To: <20060127102611.GC4311@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Jan 27 2006, Pierre Ossman wrote:
>   
>> I'm having some problems getting high memory support to work smoothly in
>> my driver. The documentation doesn't indicate what I might be doing
>> wrong so I'll have to ask here.
>>
>> The problem seems to be that kmap & co maps a single page into kernel
>> memory. So when I happen to cross page boundaries I start corrupting
>> some unrelated parts of the kernel. I would prefer not having to
>> consider page boundaries in an already messy PIO loop, so I've been
>> trying to find either a routine to map an entire sg entry or some way to
>> force the block layer to not give me stuff crossing pages.
>>
>> As you can guess I have not found anything that can do what I want, so
>> some pointers would be nice.
>>     
>
> Honestly, just don't bother if you are doing PIO anyways. Just tell the
> block layer that you want io bounced for you instead.
>
>   

This is the MMC layer so there is some separation between the block
layer and the drivers. Also, the transfers won't necessarily be from the
block layer so a generic solution is desired. I don't suppose there is
some way of accessing the bounce buffer routines in a non-bio context?

Rgds
Pierre

