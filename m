Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291664AbSCDFj4>; Mon, 4 Mar 2002 00:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291759AbSCDFjp>; Mon, 4 Mar 2002 00:39:45 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:28405
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291664AbSCDFj3>; Mon, 4 Mar 2002 00:39:29 -0500
Date: Sun, 3 Mar 2002 21:40:25 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Daniel Phillips <phillips@bonn-fries.net>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] delayed disk block allocation
Message-ID: <20020304054025.GH353@matchmail.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin> <20020304050450.GF353@matchmail.com> <20020303223103.J4188@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020303223103.J4188@lynx.adilger.int>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 10:31:03PM -0700, Andreas Dilger wrote:
> On Mar 03, 2002  21:04 -0800, Mike Fedyk wrote:
> > On Mon, Mar 04, 2002 at 03:08:54AM +0100, Daniel Phillips wrote:
> > > The main disconnect there is sub-page sized writes, you will bundle together
> > > young and old 1K buffers.  Since it's getting harder to find a 1K blocksize
> > > filesystem, we might not care.  
> > 
> > Please don't do that.
> > 
> > Hopefully, once this is in, 1k blocks will work much better.  There are many
> > cases where people work with lots of small files, and using 1k blocks is bad
> > enough, 4k would be worse.
> > 
> > Also, with dhash going into ext2/3 lots of tiny files in one dir will be
> > feasible and comparible with reiserfs.
> 
> Actually, there are a whole bunch of performance issues with 1kB block
> ext2 filesystems.  For very small files, you are probably better off
> to have tails in EAs stored with the inode, or with other tails/EAs in
> a shared block.  We discussed this on ext2-devel a few months ago, and
> while the current ext2 EA design is totally unsuitable for that, it
> isn't impossible to fix.

Great, we're finally heading tward dual sized blocks (or clusters or etc).
I'll be looking forward to that. :)

Do you think it'll look like block tails (like ffs?) or will it be more like
tail packing in reiserfs?
