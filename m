Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318220AbSHDTOF>; Sun, 4 Aug 2002 15:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318223AbSHDTOE>; Sun, 4 Aug 2002 15:14:04 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:55046 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318220AbSHDTOB>; Sun, 4 Aug 2002 15:14:01 -0400
Message-ID: <3D4D7DAF.8080309@namesys.com>
Date: Sun, 04 Aug 2002 23:17:03 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rik van Riel <riel@conectiva.com.br>, Andreas Gruenbacher <agruen@suse.de>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       Joshua MacDonald <jmacd@namesys.com>
Subject: Re: [PATCH] Caches that shrink automatically
References: <Pine.LNX.4.44.0208041202390.10314-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sun, 4 Aug 2002, Rik van Riel wrote:
>  
>
>>>In particular, it is useless for the sub-caches to try to maintain their
>>>own LRU lists and their own accessed bits. But that doesn't mean that
>>>they can _act_ as if they updated their own accessed bits, while really
>>>just telling the page-based thing that that page is active.
>>>      
>>>
>>I'm not sure I agree with this.  For eg. the dcache you will want
>>to reclaim the less used entries on a page even if there are a few
>>very intensely used entries on that page.
>>    
>>
>
>True in theory, but I doubt you will see it very much in practice. 
>
>Most of the time when you want to free dentries, it is because you have a 
>_ton_ of them. 
>
>The fact that some will look cold even if they aren't should not matter 
>that much statistically.
>
>Yah, it's a guess. We can test it.
>
>		Linus
>
>
>
>  
>
Josh tested it.  He posted on it.  I'll have him find his original post 
and repost tomorrow, but summarized in brief, the current dcache 
shrinking/management approach was quite inefficient.  Each active dcache 
entry kept a whole lot of dead ones around.

-- 
Hans



