Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTAXRNY>; Fri, 24 Jan 2003 12:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbTAXRNY>; Fri, 24 Jan 2003 12:13:24 -0500
Received: from dial-ctb05175.webone.com.au ([210.9.245.175]:57862 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S262038AbTAXRNX>;
	Fri, 24 Jan 2003 12:13:23 -0500
Message-ID: <3E31765F.4010900@cyberone.com.au>
Date: Sat, 25 Jan 2003 04:22:39 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kernel@alex.org.uk,
       Alex Tomas <bzzz@tmi.comex.ru>, Andrew Morton <akpm@digeo.com>,
       Oliver Xymoron <oxymoron@waste.org>
Subject: Re: 2.5.59-mm5
References: <XFMail.20030124180942.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:

>>>An alternate approach might be to change the way the scheduler splits
>>>things. That is, rather than marking I/O read vs write and scheduling
>>>based on that, add a flag bit to mark them all sync vs async since
>>>that's the distinction we actually care about. The normal paths can
>>>all do read+sync and write+async, but you can now do things like
>>>marking your truncate writes sync and readahead async.
>>>
>
>>That will be worth investigating to see if the complexity is worth it.
>>I think from a disk point of view, we still want to split batches between
>>reads and writes. Could be wrong.
>>
>
>Yes, sync vs async is a better way to classify io requests than
>read vs write and it's more correct from OS point of view. IMHO
>it's not more complex then now. Just replace r/w with sy/as and
>it will work.
>
We probably wouldn't want to go that far as you obviously can
only merge reads with reads and writes with writes, a flag would
be fine. We have to get the basics working first though ;)

