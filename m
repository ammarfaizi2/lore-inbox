Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292946AbSB1IGr>; Thu, 28 Feb 2002 03:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293038AbSB1IEi>; Thu, 28 Feb 2002 03:04:38 -0500
Received: from [195.163.186.27] ([195.163.186.27]:943 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S293187AbSB1ID2>;
	Thu, 28 Feb 2002 03:03:28 -0500
Date: Thu, 28 Feb 2002 10:03:25 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Doug McNaught <doug@wireboard.com>
Cc: "Doug O'Neil" <DougO@seven-systems.com>, lk <linux-kernel@vger.kernel.org>
Subject: Re: LFS Support for Sendfile
Message-ID: <20020228100325.O23151@mea-ext.zmailer.org>
In-Reply-To: <036801c1bfee$b5b0f780$1801010a@Mauser> <m34rk2tn7h.fsf@varsoon.denali.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34rk2tn7h.fsf@varsoon.denali.to>; from doug@wireboard.com on Wed, Feb 27, 2002 at 08:22:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 08:22:10PM -0500, Doug McNaught wrote:
> "Doug O'Neil" <DougO@seven-systems.com> writes:
> > Hello group.
> > 
> > First time poster. If this isn't the right place for this then please point
> > me in the right direction and accept my apology.
> > 
> > I'm using Linux 2.4.12 on a PIII
> 
> That's pretty darn old.  Can you try it with a modern kernel (2.4.18)?

  Won't help.

The API (kernel syscall) as defined does not support LFS.

mm/filemap.c:
	asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset,
					 size_t count)

The problem there is that "off_t *" thing.  A loff_t in that spot would
solve the problem, but that needs rewriting the thing with a new syscall
number.   Trivial in itself, though.  (And changeing the count to 64-bit
value is equally trivial at the same time.)


There lurks another problem in the filesystems, though.

All SysV UFS tradition type filesystems with indirect indexing of
disk blocks will need more and more of metadata traversal to reach
actual data blocks on very large files.  It slows things down.

The "extent based" filesystems offer flatter performance, and while
I can't determine if ReiserFS is exactly of that type, it too offers
fast and flat performance.

> -Doug

/Matti Aarnio
