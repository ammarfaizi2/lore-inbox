Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288985AbSAUAsb>; Sun, 20 Jan 2002 19:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288986AbSAUAsW>; Sun, 20 Jan 2002 19:48:22 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:40719 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288985AbSAUAsF>; Sun, 20 Jan 2002 19:48:05 -0500
Message-ID: <3C4B645B.8090703@namesys.com>
Date: Mon, 21 Jan 2002 03:44:11 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201202145070.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Sun, 20 Jan 2002, Shawn Starr wrote:
>
>>My worry is this. If we have different filesystems having their own page
>>buffer/caching daemons we'll definately introduce race conditions.
>>
>>Say have 2 hard drives with ReiserFS and EXT3 and im copying data between
>>the two and each of them has their own daemons its going to get pretty
>>messy no?
>>
>
>Each of the "cache daemons" will react differently to VM
>pressure, meaning the system will most definately get out
>of balance.
>
>regards,
>
>Rik
>
Not if you provide a proper design of a master cache manager.  Really, 
all you have to do is
have the subcache managers designed to free the same number of pages on 
average
in response to pressure, and to pressure them in proportion to their 
size, and it is pretty simple
for VM.

Now of course, we can talk about all sorts of possible refinements of 
this, such as perhaps
for some caches pressure in proportion to the square of their size is 
appropriate, or perhaps for
some caches their pressure should be some multiple of some other cache's 
pressure (suppose
the cost of fetching a page from disk is different from fetching a page 
over a network,
and you have two different caches of pages, one from a disk backing store,
and one of pages from a network device backing store, then it IS optimal 
to keep the pages
from the slower device longer).  I would suggest that such refinements 
go in later though.

Right now, we just want a simple interface for implementing the pressure 
response for
Reiser4.  More complex can wait until after we ship 4.0, and can 
luxuriate in multitudinous
benchmarks.

Hans


