Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269049AbUJWEge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269049AbUJWEge (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269621AbUJWEfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:35:04 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:11898 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269049AbUJWEdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:33:43 -0400
Message-ID: <4179DF23.4030402@yahoo.com.au>
Date: Sat, 23 Oct 2004 14:33:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
References: <20041021011714.GQ24619@dualathlon.random> <417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org> <417837A7.8010908@yahoo.com.au> <20041021224533.GB8756@dualathlon.random> <41785585.6030809@yahoo.com.au> <20041022011057.GC14325@dualathlon.random> <41787840.3060807@yahoo.com.au> <20041022165809.GH14325@dualathlon.random>
In-Reply-To: <20041022165809.GH14325@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Fri, Oct 22, 2004 at 01:02:24PM +1000, Nick Piggin wrote:
> 
>>I don't agree, there are times when you need to know the bare pages_xxx
>>watermark, and times when you need to know the whole ->protection thing.
> 

[snip]

> 
> I don't see any benefit in limiting the high order, infact it seems a
> bad bug. If something you should limit the _small_ order, so that the
> high order will have a slight chance to succeed. You're basically doing
> the opposite.
> 

You need the order there so someone can't allocate a huge amount
of memory and deplete all your reserves and crash the system.

For day to day running, it should barely make a difference because
the watermarks will be an order of magnitude larger.

> The pages_low is completely useless too for example and it could go.
> pages_min has some benefit for some more feature 2.6 provides (that
> could be translated in more watermarks, to separate the "settings of
> the watermarks" from the alloc_page user of the watermarks).
> 

AFAIKS, pages_min, pages_low and pages_high are all required for
what we want to be doing. I don't see you you could remove any one
of them and still have everything functioning properly....

I haven't really looked at 2.4 or your patches though. Maybe I
misunderstood you.

