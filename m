Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265059AbSKRWOc>; Mon, 18 Nov 2002 17:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbSKRWOc>; Mon, 18 Nov 2002 17:14:32 -0500
Received: from dc-mx10.cluster1.charter.net ([209.225.8.20]:4583 "EHLO
	dc-mx10.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S265059AbSKRWOL>; Mon, 18 Nov 2002 17:14:11 -0500
Message-ID: <3DD96838.9040106@free-market.net>
Date: Mon, 18 Nov 2002 14:22:48 -0800
From: "Matthew D. Hall" <mhall@free-market.net>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [rfc] epoll interface change and glibc bits ...
References: <Pine.LNX.4.44.0211180823580.979-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.44.0211180823580.979-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>On Mon, 18 Nov 2002, Jakub Jelinek wrote:
>
>  
>
>>That is as bad as unsigned long - it is different between 32-bit and 64-bit
>>ABIs.
>>    
>>
>
>Yeah, you right. I did thin about 32bit and 64bit as two diffferent
>kernel-glibc environment, I did not think about 32-64 ABI compatibility.
>Ouch, adding a 64bit object will double the size of the event structure :(
>
>
>
>- Davide
>
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
>Yeah, you right. I did thin about 32bit and 64bit as two diffferent
>kernel-glibc environment, I did not think about 32-64 ABI compatibility.
>Ouch, adding a 64bit object will double the size of the event structure :(
>  
>
Pros of a 64-bit opaque user pointer:
- Simpler programming for userland.
- Fewer cache misses, because there is no need for accessing part of a 
separate and large fd->pointer table in userland before being able to 
act upon event notification (some implementations can get around this, 
but it's very common practice).

Cons:
- 4 bytes memory wastage on 32-bit platforms per struct.  Note that it 
is not the full 8, because userland needs to have that table of pointers 
anyway.

Notes:
- No memory wastage for nontrivial applications on 64-bit platforms.

Matthew D. Hall


