Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288979AbSAUBaY>; Sun, 20 Jan 2002 20:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288992AbSAUBaP>; Sun, 20 Jan 2002 20:30:15 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:38672 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288979AbSAUBaK>; Sun, 20 Jan 2002 20:30:10 -0500
Message-ID: <3C4B6E30.2020007@namesys.com>
Date: Mon, 21 Jan 2002 04:26:08 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201202318090.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Mon, 21 Jan 2002, Hans Reiser wrote:
>
>>Rik van Riel wrote:
>>
>
>>>If your ->writepage() writes pages to disk it just means
>>>that reiserfs will be able to clean its pages faster than
>>>the other filesystems.
>>>
>>the logical extreme of this is that no write caching should be done at
>>all, only read caching?
>>
>
>You know that's bad for write clustering ;)))
>
>>>This means the VM will not call reiserfs ->writepage() as
>>>often as for the other filesystems, since more of the
>>>pages it finds will already be clean and freeable.
>>>
>>>I guess the only way to unbalance the caches is by actually
>>>freeing pages in ->writepage, but I don't see any real reason
>>>why you'd want to do that...
>>>
>>It would unbalance the write cache, not the read cache.
>>
>
>Many workloads tend to read pages again after they've written
>them, so throwing away pages immediately doesn't seem like a
>good idea.
>

I think I must have said free when I meant clean, and this naturally 
confused you.

writepage() cleans pages, which is sometimes necessary for freeing them, 
but it does not free them itself.  

The one place where we would free them is when we repack slums before 
writing them.  In this case, an empty node is not going to get accessed 
again, so it should be freed.

Hans


