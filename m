Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284477AbRLHT4x>; Sat, 8 Dec 2001 14:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284507AbRLHT4o>; Sat, 8 Dec 2001 14:56:44 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:58120 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284477AbRLHT4X>; Sat, 8 Dec 2001 14:56:23 -0500
Message-ID: <3C12701A.10904@namesys.com>
Date: Sat, 08 Dec 2001 22:55:06 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ragnar =?ISO-8859-1?Q?Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>
CC: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, Nikita Danilov <god@namesys.com>,
        green@thebsh.namesys.com
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C0EE8DD.3080108@namesys.com> <20011206122753.A9253@vestdata.no> <E16CNHk-0000u4-00@starship.berlin> <20011207174726.B6640@vestdata.no> <3C112E20.2080105@namesys.com> <20011207235641.B18104@vestdata.no> <3C115BB6.5050402@namesys.com> <20011208201639.B12687@vestdata.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ragnar Kjørstad wrote:

>
>
>So, I think the _only_ way to get the optimal performance for a growing
>directory is to do allocation and ordering by creating-time. 
>
>
We could set the key to the starting packing locality plus starting name 
hash, check to see if object with that key already exists, and then if 
it does already exist we use a generation counter as originally planned 
(though now it must start at some number large enough to avoid collision 
with the previous technique, which can happen because generation 
counters soak up some bits).  This way in most practical situations (the 
99% case where you don't have lots of files all created with the same 
name in the same directory and renamed to a variety of other things) we 
win performance-wise.  For the 1% case, we can merely perform as well as 
we do now.   Comments?  Maybe this could work.....  Hate being slower 
than ext2 at ANYTHING.....;-)

I wonder if Daniel is showing that the cost of our having to slide a 
whole node sideways for every directory entry insertion is significant. 
 I'd better wait for some benchmarks before concluding.  Leaving 
airholes in directories is one of those optimizations we are putting off 
until after v4 is very stable (which means fully coded;-) ).

Daniel, you didn't mention though whether leaking collision bits is a 
problem for Htrees.  Is it?  Do you need to rehash every so often to 
solve it?  Or it is rare enough that the performance cost can be ignored?

Interesting work you do Daniel, good work.

Hans

