Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268128AbTBYS1d>; Tue, 25 Feb 2003 13:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbTBYS1c>; Tue, 25 Feb 2003 13:27:32 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:60108 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S268128AbTBYS1c>;
	Tue, 25 Feb 2003 13:27:32 -0500
Message-ID: <3E5BB7EE.5090301@colorfullife.com>
Date: Tue, 25 Feb 2003 19:37:34 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: Horrible L2 cache effects from kernel compile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:

>The reason:
>
>Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
>Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
>
>(1GB) I bet on your big memory box it is even worse. No cache
>in the world can cache that.
>
[snip]

>Try the appended experimental patch. It replaces the hash table madness
>with relatively small fixed tables.
>  
>
Are you sure that this will help?
With a smaller table, you might cause fewer cache misses for the table 
lookup. Instead you get longer hash chains. Walking linked lists 
probably causes more cache line misses than the single array lookup.

Dave, how many entries are in the dcache?

Btw, has anyone tried to replaced the global dcache with something 
local, perhaps a tree instead of d_child, and then lookup in d_child_tree?

--
    Manfred

