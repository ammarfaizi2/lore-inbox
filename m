Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbRFNIbd>; Thu, 14 Jun 2001 04:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbRFNIbX>; Thu, 14 Jun 2001 04:31:23 -0400
Received: from www.wen-online.de ([212.223.88.39]:47116 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261535AbRFNIbR>;
	Thu, 14 Jun 2001 04:31:17 -0400
Date: Thu, 14 Jun 2001 10:30:32 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Tom Sightler <ttsig@tuxyturvy.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
In-Reply-To: <Pine.LNX.4.33.0106131716510.1742-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106140954130.927-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001, Rik van Riel wrote:

> On Wed, 13 Jun 2001, Tom Sightler wrote:
>
> > 1.  Transfer of the first 100-150MB is very fast (9.8MB/sec via 100Mb Ethernet,
> > close to wire speed).  At this point Linux has yet to write the first byte to
> > disk.  OK, this might be an exaggerated, but very little disk activity has
> > occured on my laptop.
> >
> > 2.  Suddenly it's as if Linux says, "Damn, I've got a lot of data to flush,
> > maybe I should do that" then the hard drive light comes on solid for several
> > seconds.  During this time the ftp transfer drops to about 1/5 of the original
> > speed.
> >
> > 3.  After the initial burst of data is written things seem much more reasonable,
> > and data streams to the disk almost continually while the rest of the transfer
> > completes at near full speed again.
> >
> > Basically, it seems the kernel buffers all of the incoming file up to nearly
> > available memory before it begins to panic and starts flushing the file to disk.
> >  It seems it should start to lazy write somewhat ealier.
> > Perhaps some of this is tuneable from userland and I just don't
> > know how.
>
> Actually, it already does the lazy write earlier.
>
> The page reclaim code scans up to 1/4th of the inactive_dirty
> pages on the first loop, where it does NOT write things to
> disk.

I've done some experiments with a _clean_ shortage.  Requiring that a
portion of inactive pages be pre cleaned improves response as you start
reclaiming.  Even though you may have enough inactive pages total, you
know that laundering is needed before things get heavy.  This gets the
dirty pages moving a little sooner.  As you're reclaiming pages, writes
trickle out whether your dirty list is short or long.  (and if I'd been
able to make that idea work a little better, you'd have seen my mess;)

	-Mike

