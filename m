Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263450AbVCEAgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263450AbVCEAgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbVCEALh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:11:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:48822 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263310AbVCDX3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:29:12 -0500
Date: Fri, 4 Mar 2005 15:29:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Junfeng Yang <yjf@stanford.edu>
Cc: lmb@suse.de, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, mc@cs.stanford.edu
Subject: Re: [MC] [CHECKER] Do ext2, jfs and reiserfs respect mount -o
 sync/dirsync option?
Message-Id: <20050304152902.60f7c0c7.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.44.0503041440030.17155-100000@elaine24.Stanford.EDU>
References: <20050304032025.119ce69e.akpm@osdl.org>
	<Pine.GSO.4.44.0503041440030.17155-100000@elaine24.Stanford.EDU>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang <yjf@stanford.edu> wrote:
>
> > >From a quick parse, ext2 seems to be full of MS_SYNCHRONOUS holes, and
> > there might be some O_SYNC ones there as well.
> 
> I should be able to easily add O_SYNC check to FiSC.  Several questions:
> 1. Does O_SYNC apply to directory as well?

Only if you can open directores for writing ;)

> 2. For the same file, if I open twice, once with O_SYNC and another time
> without, only writes through the O_SYNC fd will be sychonous, right?

Yes, O_SYNC is a per-fd thing.

> 3. I open a file w/o O_SYNC, issue a bunch of writes, then call
> ioctl(FIOASYNC) to set the fd sync, then issure a second set of writes.
> Only the second set of writes are synchronous?

FIOSYNC is unrelated to O_SYNC.  OSYNC can only be set at open().

> btw, man page show that O_DSYNC and O_RSYNC are just O_SYNC.  Is this true
> for current linux kernel (2.6)?

The kernel only supports O_SYNC (equivalent behaviour to O_RSYNC|O_DSYNC). 
Perhaps glibc does a conversion.

> > So this wild scattergun patch probably does extra work and possibly extra
> > I/O all over the place, but I'd be interested if Junfeng could give it a
> > quick test.   It's against 2.6.11.
> 
> I checked 2.6.11 with your patch just now.  Looks like the problem is
> still there.  If you need more information, let me know.  Image is at
> http://fisc.stanford.edu/bug2/crash-1.img.bz2.  Below is the output from
> e2fsck.

ugh.  Thanks.

