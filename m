Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUAEEkF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUAEEkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:40:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41315 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263014AbUAEEjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:39:55 -0500
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny1 tree for small systems
References: <20040103030814.GG18208@waste.org>
	<m13cawi2h8.fsf@ebiederm.dsl.xmission.com>
	<20040104084005.GU18208@waste.org>
	<m1ekufgt72.fsf@ebiederm.dsl.xmission.com>
	<20040105003426.GZ4176@parcelfarce.linux.theplanet.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2004 21:34:12 -0700
In-Reply-To: <20040105003426.GZ4176@parcelfarce.linux.theplanet.co.uk>
Message-ID: <m1brpjf1yz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First thanks for the review.

viro@parcelfarce.linux.theplanet.co.uk writes:

> On Sun, Jan 04, 2004 at 05:00:49PM -0700, Eric W. Biederman wrote:
> 
> 1) make block-based filesystems dependent on CONFIG_BLOCK

Yep that sounds better and is easier to type.
 
> > --- linux-2.6.1-rc1-tiny1.eb1/fs/super.c	Wed Dec 17 19:58:48 2003
> > +++ linux-2.6.1-rc1-tiny1.eb2/fs/super.c	Sun Jan  4 15:18:28 2004
> > @@ -473,8 +473,10 @@
> >  {
> >  	int retval;
> >  	
> > +#ifdef CONFIG_BLOCK_DEVICES
> >  	if (!(flags & MS_RDONLY) && bdev_read_only(sb->s_bdev))
> >  		return -EACCES;
> > +#endif
> >  	if (flags & MS_RDONLY)
> >  		acct_auto_close(sb);
> >  	shrink_dcache_sb(sb);
> > @@ -588,6 +590,7 @@
> >  	return (void *)s->s_bdev == data;
> >  }
> 
> Tons of stuff here make sense only for block-based filesystems (e.g. the
> function immediately above ;-).  Ifdef, or, better yet, move to fs/block_dev.c

remounting only makes sense for block based filesystems?
That does not sound right.  

Definitely something to look into next time I get the chance.

> > +cond_syscall(sys_fsync)
> > +cond_syscall(sys_fdatasync)
> 
> Huh?  They should work for network filesystems.

Good catch.  I did say this was a first cut that was too ugly to use.
The problem is those functions need to move out of buffer.c

I have moved them into fs-writeback.c and things still appear to work.

My method of exacting the dependencies was to remove the obvious files
from the build and then to fixup whatever linker problems were left.

Eric
