Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282893AbRLGSDZ>; Fri, 7 Dec 2001 13:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282904AbRLGSDP>; Fri, 7 Dec 2001 13:03:15 -0500
Received: from stine.vestdata.no ([195.204.68.10]:28575 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S282893AbRLGSDI>; Fri, 7 Dec 2001 13:03:08 -0500
Date: Fri, 7 Dec 2001 19:03:01 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Message-ID: <20011207190301.C6640@vestdata.no>
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16CNHk-0000u4-00@starship.berlin> <20011207174726.B6640@vestdata.no> <E16CP0X-0000uE-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16CP0X-0000uE-00@starship.berlin>; from phillips@bonn-fries.net on Fri, Dec 07, 2001 at 06:41:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 06:41:53PM +0100, Daniel Phillips wrote:
> I've observed disk cache effects with Ext2, the relevant relationship being 
> directory entry order vs inode order.  Layout of the index itself doesn't 
> seem to matter much because of its small size, and 'popularity', which tends 
> to keep it in cache.

Exactly.

And if the files have data in them (all my tests were done with files
with bodies) then there is a third data-type (the allocated blocks)
whose order compared to the entry-order and the inode-order also
matters.

> With ReiserFS we see slowdown due to random access even with small 
> directories.  I don't think this is a cache effect.

I can't see why the benefit from read-ahead on the file-data should be
affected by the directory-size?


I forgot to mention another important effect of hash-ordering:
If you mostly add new files to the directory it is far less work if you
almost always can add the new entry at the end rather than insert it in
the middle. Well, it depends on your implementation of course, but this
effect is quite noticable on reiserfs. When untaring a big directory of
maildir the performance difference between the tea hash and a special
maildir hash was approxemately 20%. The choice of hash should not affect
the performance on writing the data itself, so it has to be related to
the cost of the insert operation.




-- 
Ragnar Kjørstad
Big Storage
