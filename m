Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284272AbRLGSQU>; Fri, 7 Dec 2001 13:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284275AbRLGSQI>; Fri, 7 Dec 2001 13:16:08 -0500
Received: from dsl-213-023-043-071.arcor-ip.net ([213.23.43.71]:63754 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284272AbRLGSQB>;
	Fri, 7 Dec 2001 13:16:01 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ragnar =?iso-8859-1?q?Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Fri, 7 Dec 2001 19:18:37 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16CP0X-0000uE-00@starship.berlin> <20011207190301.C6640@vestdata.no>
In-Reply-To: <20011207190301.C6640@vestdata.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16CPaA-0000uj-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 7, 2001 07:03 pm, Ragnar Kjørstad wrote:
> > With ReiserFS we see slowdown due to random access even with small 
> > directories.  I don't think this is a cache effect.
> 
> I can't see why the benefit from read-ahead on the file-data should be
> affected by the directory-size?
> 
> I forgot to mention another important effect of hash-ordering:
> If you mostly add new files to the directory it is far less work if you
> almost always can add the new entry at the end rather than insert it in
> the middle. Well, it depends on your implementation of course, but this
> effect is quite noticable on reiserfs. When untaring a big directory of
> maildir the performance difference between the tea hash and a special
> maildir hash was approxemately 20%. The choice of hash should not affect
> the performance on writing the data itself, so it has to be related to
> the cost of the insert operation.

Yes, I think you're on the right track.  HTree on the other hand is optimized 
for inserting in arbitrary places, it takes no advantage at all of sequential 
insertion.  (And doesn't suffer from this, because it all happens in cache 
anyway - a million-file indexed directory is around 30 meg.)

--
Daniel
