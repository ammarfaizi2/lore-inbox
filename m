Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280026AbRLGNGw>; Fri, 7 Dec 2001 08:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280029AbRLGNGc>; Fri, 7 Dec 2001 08:06:32 -0500
Received: from stine.vestdata.no ([195.204.68.10]:35729 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S280026AbRLGNGb>; Fri, 7 Dec 2001 08:06:31 -0500
Date: Fri, 7 Dec 2001 14:06:09 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>
To: Cameron Simpson <cs@zip.com.au>
Cc: Hans Reiser <reiser@namesys.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Message-ID: <20011207140608.A1684@vestdata.no>
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C0EE8DD.3080108@namesys.com> <20011207141913.A26225@zapff.research.canon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207141913.A26225@zapff.research.canon.com.au>; from cs@zip.com.au on Fri, Dec 07, 2001 at 02:19:13PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 02:19:13PM +1100, Cameron Simpson wrote:
> On Thu, Dec 06, 2001 at 06:41:17AM +0300, Hans Reiser <reiser@namesys.com> wrote:
> | Have you ever seen an application that creates millions of files create 
> | them in random order?
> 
> I can readily imagine one. An app which stashes things sent by random
> other things (usenet/email attachment trollers? security cameras taking
> thouands of still photos a day?). Mail services like hotmail. with a
> zillion mail spools, being made and deleted and accessed at random...

I wouldn't think either of those had "random" names.
E.g. a lot of mailsystems use maildir for storage, and the filenames
depend on the server recieving the data and a timestamp. It's a very
good example of what can be optimized with some guesses about ordering.

> But they shouldn't have to! Specificly, to "play nice" you need to know
> about the filesystem attributes. You can obviously do simple things like
> a directory hierachy as for squid proxy caches etc, but it's an ad hoc
> thing. Tuning it does require specific knowledge, and the act itself
> presumes exactly the sort of inefficiency in the fs implementation that
> this htree stuff is aimed at rooting out.

An ordering hash doesn't imply that you _need_ some knowledge about the
filesystem attributes. The hash should not change the worst-case
scenario significantly. The only effect of an ordering hash should be
that you get best-case whenever you access the files in order, and I
believe that tests on reiserfs have shown both that:
* this particular ordering is used in real life applications
and
* the best case is significantly better than the worst case.
  (probably because of read-ahead and better cache results)

That said, there are other ways for filesystem to guess the optimal
order of the files, e.g.:
1 the order of wich files are created
2 a seperate interface where userspace programs could specify optimal
  order

The 2. is probably out of the question because applications would need
to be changed to take advantage, but ordering the files on disk in the
order they were created in is probably a very good approxemation.



-- 
Ragnar Kjørstad
Big Storage
