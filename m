Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288623AbSATOZS>; Sun, 20 Jan 2002 09:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288639AbSATOZI>; Sun, 20 Jan 2002 09:25:08 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:263 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S288623AbSATOY4>;
	Sun, 20 Jan 2002 09:24:56 -0500
Message-ID: <3C4AD24D.4050206@namesys.com>
Date: Sun, 20 Jan 2002 17:21:01 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Shawn <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201201155380.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Write clustering is one thing it achieves.   When we flush a slum, the 
cost of the seek so far outweighs the transfer cost that we should 
transfer FLUSH_SIZE (where flush size is imagined to be something like 
64 or 16 or at least 8) adjacent (in the tree order) nodes at the same 
time to disk.  There are many ways in which LRU is only an approximation 
to optimum.  This is one of many.

Flushing everything involved in a transaction so that (the buffers being 
pinned in RAM (so that they don't have to be reread from disk when the 
transaction commits) until the transaction commits) can be unpinned is 
another thing.  

Hans

