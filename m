Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289907AbSAWRSK>; Wed, 23 Jan 2002 12:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289925AbSAWRSF>; Wed, 23 Jan 2002 12:18:05 -0500
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:32402 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S289907AbSAWRQI>; Wed, 23 Jan 2002 12:16:08 -0500
Date: Wed, 23 Jan 2002 09:15:23 -0800
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Hans Reiser <reiser@namesys.com>, Chris Mason <mason@suse.com>,
        Andreas Dilger <adilger@turbolabs.com>, Shawn Starr <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
Message-ID: <20020123091522.A16614@helen.CS.Berkeley.EDU>
In-Reply-To: <3C4DB36F.4090306@namesys.com> <Pine.LNX.4.33L.0201221818140.32617-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0201221818140.32617-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Jan 22, 2002 at 06:20:52PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rik van Riel (riel@conectiva.com.br):
> On Tue, 22 Jan 2002, Hans Reiser wrote:
> > Rik van Riel wrote:
> > >On Tue, 22 Jan 2002, Chris Mason wrote:
> 
> > >>The FS doesn't know how long a page has been dirty, or how often it
> > >>gets used,
> > >
> > >In an efficient system, the FS will never get to know this, either.
> >
> > I don't understand this statement.  If dereferencing a vfs op for
> > every page aging is too expensive, then ask it to age more than one
> > page at a time.  Or do I miss your meaning?
> 
> Please repeat after me:
> 
>  "THE  FS  DOES  NOT  SEE  THE  MMU  ACCESSED  BITS"
> 
> Also, if a piece of data is in the page cache, it is accessed
> without calling the filesystem code.
> 
> 
> This means the filesystem doesn't know how often pages are or
> are not used, hence it cannot make the decisions the VM make.
> 
> Or do you want to have your own ReiserVM and ReiserPageCache ?

Rik,

We think there are good reasons for the FS to know when and how 
its data is accessed, although this issue is less significant than
the semantics of writepage() being discussed in this thread.  

Referring to the transaction design document I posted several months 
ago:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=100510090926874&w=2

Our intention is for the file system to be capable of tracking 
read and write data-dependencies so that it can safely defer
writing batches of data and still guarantee consistent crash 
recovery from the application's point of view.  The interaction 
between transactions and mmaped regions may leave something to 
be desired, and we may not need to know how often pages are or 
are not used, but we would like to know which pages are read and 
written by whom, even for the case of a page cache hit.

-josh

-- 
PRCS version control system    http://sourceforge.net/projects/prcs
Xdelta storage & transport     http://sourceforge.net/projects/xdelta
Need a concurrent skip list?   http://sourceforge.net/projects/skiplist
