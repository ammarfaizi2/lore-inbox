Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285117AbRLFL2o>; Thu, 6 Dec 2001 06:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285118AbRLFL2f>; Thu, 6 Dec 2001 06:28:35 -0500
Received: from stine.vestdata.no ([195.204.68.10]:26807 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S285117AbRLFL2S>; Thu, 6 Dec 2001 06:28:18 -0500
Date: Thu, 6 Dec 2001 12:27:53 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>
To: Hans Reiser <reiser@namesys.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Message-ID: <20011206122753.A9253@vestdata.no>
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C0EE8DD.3080108@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0EE8DD.3080108@namesys.com>; from reiser@namesys.com on Thu, Dec 06, 2001 at 06:41:17AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 06:41:17AM +0300, Hans Reiser wrote:
> >Curiously, Reiserfs actually depends on the spelling of the filename for a 
> >lot of its good performance.  Creating files with names that don't follow a 
> >lexigraphically contiguous sequence produces far different results:
> >
> >   http://people.nl.linux.org/~phillips/htree/indexed.vs.classic.vs.reiser.10x10000.create.random.jpg
> >
> >So it seems that for realistic cases, ext2+htree outperforms reiserfs quite 
> >dramatically.  (Are you reading, Hans?  Fighting words... ;-)
> 
> Have you ever seen an application that creates millions of files create 
> them in random order?  Almost always there is some non-randomness in the 
> order, and our newer hash functions are pretty good at preserving it. 
> Applications that create millions of files are usually willing to play 
> nice for an order of magnitude performance gain also.....

There is obviously something missing in this picture, or reiserfs would
be as fast as ext2 for random access and much faster for access in
sequential order by filename spelling.

(a "random" hash should not be significantly better than a hash that
preserves order, because the randomness in the hash is of course not the
same random order in wich the files are accessed. The only exception is
that hashes that preserve order may have a harder time using the full
hash-space evenly)

So, did anyone investigate why ext2 is faster than reiserfs in theese
cases, or try benchmarking ext2 with one of the reiserfs-hashes (eg r5)?
We know from earlier benchmarks on reiserfs (tea vs r5 tests, and r5 vs
maildir-hash) that a hash that preserves order can give a magnitude of
order performance improvement in certain cases.



-- 
Ragnar Kjørstad
Big Storage
