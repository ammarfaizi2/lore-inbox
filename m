Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287833AbSATVfB>; Sun, 20 Jan 2002 16:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287279AbSATVel>; Sun, 20 Jan 2002 16:34:41 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:62730 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288051AbSATVeb>; Sun, 20 Jan 2002 16:34:31 -0500
Message-ID: <3C4B3703.6080101@namesys.com>
Date: Mon, 21 Jan 2002 00:30:43 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Shawn <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201201924020.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Mon, 21 Jan 2002, Hans Reiser wrote:
>
>>Rik van Riel wrote:
>>
>>>On Sun, 20 Jan 2002, Hans Reiser wrote:
>>>
>
>>>Agreed on these points, but you really HAVE TO work towards
>>>flushing the page ->writepage() gets called for.
>>>
>>>Think about your typical PC, with memory in ZONE_DMA,
>>>ZONE_NORMAL and ZONE_HIGHMEM. If we are short on DMA pages
>>>we will end up calling ->writepage() on a DMA page.
>>>
>>>If the filesystem ends up writing completely unrelated pages
>>>and marking the DMA page in question referenced the VM will
>>>go in a loop until the filesystem finally gets around to
>>>making a page in the (small) DMA zone freeable ...
>>>
>>This is a bug in VM design, yes?  It should signal that it needs the
>>particular page written, which probnably means that it should use
>>writepage only when it needs that particular page written,
>>
>
>That is exactly what the VM does.
>
So basically you continue to believe that one cache manager shall rule 
them all, and in the darkness as to their needs, bind them.

>
>
>>and should otherwise check to see if the filesystem supports something
>>like pressure_fs_cache(), yes?
>>
>
>That's incompatible with the concept of memory zones.
>
Care to explain more?

>
>
>regards,
>
>Rik
>



