Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267412AbTBFVbG>; Thu, 6 Feb 2003 16:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbTBFVbG>; Thu, 6 Feb 2003 16:31:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:34256 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267412AbTBFVbF>;
	Thu, 6 Feb 2003 16:31:05 -0500
Date: Thu, 6 Feb 2003 13:40:25 -0800
From: Andrew Morton <akpm@digeo.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible partition corruption
Message-Id: <20030206134025.487cb3d3.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302061529240.998-100000@localhost.localdomain>
References: <20030206132346.4b635676.akpm@digeo.com>
	<Pine.LNX.4.44.0302061529240.998-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Feb 2003 21:40:37.0818 (UTC) FILETIME=[633449A0:01C2CE28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cox.net> wrote:
>
> On Thu, 6 Feb 2003, Andrew Morton wrote:
> 
> > Thomas Molina <tmolina@cox.net> wrote:
> > >
> > > > Everything you describe is consistent with a kernel which does not have ext3
> > > > compiled into it.
> > > ...
> > > I'm aware of that.
> > 
> > In that case you may be experiencing the mysterious vanishing
> > ext3_read_super-doesn't-work bug.  Usually a recompile/relink makes it go
> > away.  I haven't seen it in months.
> > 
> > Could you please drop this additional debugging in there and see
> > what happens?
> 
> I'll try it, but a question did occur to me.  I got the hang while booting 
> a freshly-compiled 2.5.59, but the error message was received after 
> supposedly cleaning and recovering the journal.  That was using the stock 
> RedHat 8.0 kernel, 2.4.18-24.8.0, which most certainly does have ext3 
> support.  Would the bug you described affect a following boot into a 
> totally different kernel?

The error message you saw was ext2 saying "I don't know how to deal with
uncleanly shut-down ext3 filesystems".

The kernel will try to mount the fs as ext3 first, and then as ext2.

For some reason the ext3 attempt is not successful, so it falls through to
ext2 and that is the first message we see.

