Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266325AbUAVVdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 16:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266331AbUAVVdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 16:33:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:45280 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266325AbUAVVdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 16:33:35 -0500
Date: Thu, 22 Jan 2004 13:34:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Axel Siebenwirth <axel@pearbough.net>
Cc: linux-kernel@vger.kernel.org, aia21@cantab.net
Subject: Re: 2.6.2-rc1-mm1
Message-Id: <20040122133453.1932eae0.akpm@osdl.org>
In-Reply-To: <20040122132044.GA18954@neon>
References: <20040122013501.2251e65e.akpm@osdl.org>
	<20040122132044.GA18954@neon>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Siebenwirth <axel@pearbough.net> wrote:
>
> Hi!
> 
> On Thu, 22 Jan 2004, Andrew Morton wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm1/
> > 
> > 
> > - Nothing very exciting, just lots of random fixes.
> > 
> > - The x86 gcc-3.4/gcc-3.5 support seems pretty much complete now.  There
> >   are enough fixes here to get a reasonably clean build with my .config but a
> >   full kernel build still will need work.
> 
> In my case it is NTFS causing the build failure.
> 
>   CC      fs/ntfs/inode.o
> fs/ntfs/inode.c: In function `ntfs_read_locked_inode':
> fs/ntfs/ntfs.h:186: sorry, unimplemented: inlining failed in call to
> 'ntfs2utc': function body not available

Yes, there are going to be a lot of these.   Lots of code does

foo.h:
	extern inline void foo(void);
foo.c:
	inline void foo(void) 
	{
	}

and latest gcc generates an error in this case (with the options we're
currently using, at least).

The fix is to remove the `inline' from the declaration in foo.h.  It's the
right thing to do anyway, so I'm thinking we should just get in there and
fix them all up.

