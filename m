Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUJHD2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUJHD2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUJHDZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 23:25:33 -0400
Received: from mail-13.iinet.net.au ([203.59.3.45]:41119 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266116AbUJHDNn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 23:13:43 -0400
Message-ID: <416605CC.2080204@cyberone.com.au>
Date: Fri, 08 Oct 2004 13:13:16 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: chrisw@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
References: <20041007142019.D2441@build.pdx.osdl.net>	<20041007164044.23bac609.akpm@osdl.org>	<4165E0A7.7080305@yahoo.com.au>	<20041007174242.3dd6facd.akpm@osdl.org>	<20041007184134.S2357@build.pdx.osdl.net>	<20041007185131.T2357@build.pdx.osdl.net>	<20041007185352.60e07b2f.akpm@osdl.org>	<4165FF7B.1070302@cyberone.com.au> <20041007200109.57ce24ae.akpm@osdl.org>
In-Reply-To: <20041007200109.57ce24ae.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>>Chris Wright <chrisw@osdl.org> wrote:
>>>
>> >
>> >>(whereas I could get the mainline code, and the
>> >> one-liner to spin right off).  
>> >>
>> >
>> >How?  (up to and including .config please).
>> >
>> >
>> >
>>
>> Ah, free_pages <= pages_high, ie. 0 <= 0, which is true;
>> commence spinning.
>>
>
>Maybe.  It requires that the zonelists be screwy:
>
> Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
> protections[]: 0 0 0
> Node 1 Normal free:25272kB min:1020kB low:2040kB high:3060kB active:624172kB inactive:282700kB present:1047936kB
> protections[]: 0 0 0
> Node 1 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
> protections[]: 0 0 0
> Node 0 DMA free:728kB min:12kB low:24kB high:36kB active:788kB inactive:7848kB present:16384kB
> protections[]: 0 0 0
> Node 0 Normal free:27200kB min:1004kB low:2008kB high:3012kB active:332792kB inactive:422744kB present:1032188kB
> protections[]: 0 0 0
> Node 0 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
> protections[]: 0 0 0
>
>See that DMA zone on node 1?  Wonder how it got like that.  It
>should not be inside pgdat->nrzones anyway.
>
>
Oh? Why not? I didn't think empty zones were filtered out? (perhaps
they should be).

>David, is your setup NUMA?  Can you show us a sysrq-M dump?
>
>

Yes. Incase he's alseep, I'll quote:

"I saw the same thing yesterday, also on an amd64 box though that
could be coincidence. The kswapd1 process was pegging the cpu at 99%
kswapd0 was idle. After a few minutes, the box became so unresponsive"

