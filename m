Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262306AbSI1Sjg>; Sat, 28 Sep 2002 14:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262308AbSI1Sjg>; Sat, 28 Sep 2002 14:39:36 -0400
Received: from [210.73.87.125] ([210.73.87.125]:3332 "HELO www.gnuchina.org")
	by vger.kernel.org with SMTP id <S262306AbSI1Sjf>;
	Sat, 28 Sep 2002 14:39:35 -0400
Date: Sat, 28 Sep 2002 11:43:58 -0700
From: chrisl@gnuchina.org
To: "Theodore Ts'o" <tytso@mit.edu>,
       Ryan Cumming <ryan@completely.kicks-ass.org>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020928184357.GB15377@vmware.com>
References: <E17uINs-0003bG-00@think.thunk.org> <20020926235741.GC10551@think.thunk.org> <20020927041234.GS22795@clusterfs.com> <200209271820.41906.ryan@completely.kicks-ass.org> <20020928141330.GA653@think.thunk.org> <20020928172748.GF22795@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020928172748.GF22795@clusterfs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking at this also.

It is very possible the case. I am doing experiment now. This happened
very randomly. Same script randomly produce the bug. Each time the problem
block happen at a different place. I just can't consistently reproduce
the bug.

I am doing some experiment now.

Chris

On Sat, Sep 28, 2002 at 11:27:49AM -0600, Andreas Dilger wrote:
> On Sep 28, 2002  10:13 -0400, Theodore Ts'o wrote:
> > The nature of the corruption is that a directory entry of size 8
> > (which is enough room for a zero-length name) is left in the
> > directory.  This is harmless, but it should never happen normally, and
> > so the ext3 sanity-checking code flags it as an error.  With this
> > patch, e2fsck is much smarter about salvaging corrupt directories, and
> > so it can do so without causing any directory entries to be lost.
> > (This corrupted, too-small directory entry appears at the beginning of
> > the directory block, which is another reason why I strongly suspect
> > the dx_split code.)
> 
> One idea I just had but don't have time to investigate (babysitting
> both kids today) is if the do_split() code is creating a hash entry
> for unused dir entries (i.e. inode == 0 or name_len == 0).  If that
> is the case, then it could explain the presence of this short entry.
> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> http://sourceforge.net/projects/ext2resize/
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel
