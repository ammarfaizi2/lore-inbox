Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270193AbRHGLkO>; Tue, 7 Aug 2001 07:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270194AbRHGLjy>; Tue, 7 Aug 2001 07:39:54 -0400
Received: from tomts14.bellnexxia.net ([209.226.175.35]:16016 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S270193AbRHGLjv>; Tue, 7 Aug 2001 07:39:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: "Stephen C. Tweedie" <sct@redhat.com>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [RFC] using writepage to start io
Date: Tue, 7 Aug 2001 07:39:44 -0400
X-Mailer: KMail [version 1.3]
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <755760000.997128720@tiny> <01080623182601.01864@starship> <20010807120234.D4036@redhat.com>
In-Reply-To: <20010807120234.D4036@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010807113944.D229E7B53@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 7, 2001 07:02 am, Stephen C. Tweedie wrote:
> Hi,
>
> On Mon, Aug 06, 2001 at 11:18:26PM +0200, Daniel Phillips wrote:
> > > On Monday, August 06, 2001 09:45:12 PM +0200 Daniel Phillips
> > >
> > > Grin, we're talking in circles.  My point is that by having two
> > > threads, bdflush is allowed to skip over older buffers in favor of
> > > younger ones because somebody else is responsible for writing the
> > > older ones out.
> >
> > Yes, and you can't imagine an algorithm that could do that with *one*
> > thread?
>
> FWIW, we've seen big performance degradations in the past when testing
> different ext3 checkpointing modes.  You can't reuse a disk block in
> the journal without making sure that the data in it has been flushed
> to disk, so ext3 does regular checkpointing to flush journaled blocks
> out.  That can interact very badly with normal VM writeback if you're
> not careful: having two threads doing the same thing at the same time
> can just thrash the disk.
>
> Parallel sync() calls from multiple processes has shown up the same
> behaviour on ext2 in the past.  I'd definitely like to see at most one
> thread of writeback per disk to avoid that.

Be carefull here.  I have a system (solaris) at the office that has 96 drives 
on it.  Do we really want 96 writeback threads?  With 96 drives, suspect the
bus bandwidth would be the limiting factor.

Ed Tomlinson 
