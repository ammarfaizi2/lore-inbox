Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSJ1TEm>; Mon, 28 Oct 2002 14:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJ1TEm>; Mon, 28 Oct 2002 14:04:42 -0500
Received: from [195.223.140.107] ([195.223.140.107]:33920 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261448AbSJ1TEk>;
	Mon, 28 Oct 2002 14:04:40 -0500
Date: Mon, 28 Oct 2002 20:10:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugo Mills <hugo-lkml@carfax.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Oops in kswapd, 2.4.19 kernel and before
Message-ID: <20021028191012.GG13972@dualathlon.random>
References: <20021028102439.GB13490@carfax.org.uk> <20021028132901.B27077@oldwotan.suse.de> <20021028164540.GE13490@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028164540.GE13490@carfax.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 04:45:40PM +0000, Hugo Mills wrote:
> On Mon, Oct 28, 2002 at 01:29:01PM +0100, Andrea Arcangeli wrote:
> > On Mon, Oct 28, 2002 at 10:24:39AM +0000, Hugo Mills wrote:
> > >    I'm getting regular oopsen in kswapd on my 2.4.19 kernel. They
> > > generally appear to happen while running Amanda (a tape backup
> > 
> > if it only happens while or after running Amanda, it may be a tape
> > driver bug.
> 
>    I may have seen it (once?) before without touching the tape drive,
> although I'm not certain. I shall see if I can reproduce without use
> of the tape.

perfect, thanks.

> 
> > >    Decoded oopsen are below (they _are_ decoded with the right system
> > > maps, despite ksymoops's concerns). If there's anything else that's
> > > needed in order to track this down, please let me know.
> > 
> > the oopses shows some inode was corrupted, it doesn't tell us who is
> > corrupting them but most likely it is not a piece of common code (a driver
> > or a non mainstream feature or we should be able to reproduce it) You
> > should try to localize the bug to a piece of code, by for example making
> > 100% sure that it triggers as soon as you start amanda. 
> 
>    It's not certain. I appear to have triggered it this morning on the
> _third_ consecutive run of amflush. Again, I'll test more carefully.

You may want to start a very intensive kernel stress test right after
doing the backup. If it corrupts memory, you won't notice until you
actually use the corrupted memory. Other times it may corrupt user or
free memory and in such cases you won't get an oops.

> > Then you can try to backup using another device (not tape) and see
> > if you can still reproduce. finally you can try to use older or
> > newer 2.4 drivers for the tape and see if there's any change that
> > fixes the problem in the old/new drivers. Of course it isn't certain
> > at all that it is the tape, I'm just guessing because you said it
> > happens while backing up to the tape.
> 
>    I've definitely seen the problem throughout the 2.4 series. I don't
> recall what the first 2.4 kernel I used was, but it was definitely
> there in all mainstream kernels (and those -ac kernels I tried) from
> about 2.4.14 onwards. I'll try 2.4.20-preX and report on that as well.
> 
>    Thanks for your help. It may be a week or two before I can get all
> these tests completed, but I shall definitely report back when I'm
> done.

Ok.

Andrea
