Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSGONiX>; Mon, 15 Jul 2002 09:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSGONiW>; Mon, 15 Jul 2002 09:38:22 -0400
Received: from 216-42-72-165.ppp.netsville.net ([216.42.72.165]:23381 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S317482AbSGONiV>; Mon, 15 Jul 2002 09:38:21 -0400
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
From: Chris Mason <mason@suse.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sam Vilain <sam@vilain.net>, dax@gurulabs.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1026739383.13885.114.camel@irongate.swansea.linux.org.uk>
References: <1026490866.5316.41.camel@thud> <1026679245.15054.9.camel@thud>
	<E17U1BD-0000m0-00@hofmann>
	<1026736251.13885.108.camel@irongate.swansea.linux.org.uk> 
	<E17U4YE-0000TL-00@hofmann> 
	<1026739383.13885.114.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Jul 2002 09:40:49 -0400
Message-Id: <1026740450.21656.355.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-15 at 09:23, Alan Cox wrote:
> On Mon, 2002-07-15 at 13:02, Sam Vilain wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >    "Yes, we know that there is no directory hashing in ext2/3.  You'll have 
> > to find another solution to the problem, I'm afraid.  Why not ease the
> > burden on the filesystem by breaking up the task for it, and giving it
> > to it in small pieces.  That way it's much less likely to choke."
> 
> Actually there are several other reasons for it. It sucks a lot less
> when you need to use ls and friends to inspect part of the spool. It
> also makes it much easier to split the mail spool over multiple disks as
> it grows without having to backup/restore the spool area

Another good reason is i_sem.  If you've got more than one process doing
something to that directory, you spend lots of time waiting for the
semaphore.  I think it was andrew that reminded me i_sem is held on
fsync, so fync(dir) to make things safe after a rename can slow things
down. 

reiserfs only needs fsync(file), ext3 needs fsync(anything on the fs). 
If ext3 would promise to make fsync(file) sufficient forever, it might
help the mta authors tune.

-chris


