Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVG2Rxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVG2Rxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVG2Rxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:53:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30863 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262683AbVG2Rx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:53:28 -0400
Date: Fri, 29 Jul 2005 10:52:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Syncing single filesystem (slow USB writing)
Message-Id: <20050729105220.4004e794.akpm@osdl.org>
In-Reply-To: <200507291544.23545.arvidjaar@mail.ru>
References: <200507290731.32694.arvidjaar@mail.ru>
	<200507291428.06903.arvidjaar@mail.ru>
	<20050729042000.48c40272.akpm@osdl.org>
	<200507291544.23545.arvidjaar@mail.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov <arvidjaar@mail.ru> wrote:
>
> On Friday 29 July 2005 15:20, Andrew Morton wrote:
> > Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> > > On Friday 29 July 2005 07:50, Andrew Morton wrote:
> > > > > One idea how to improve situation - continue to mount with dsync
> > > > > (having basically old case) and do frequent sync of filesystem (this
> > > > > culd be started as HAL callout or whatever). Unfortunately, I could
> > > > > not find a way to request a sync (flush) of single mount point or
> > > > > block device. Have I missed something?
> > > >
> > > > It's trivial to do in-kernel but no, I'm afraid there isn't a userspace
> > > > interface for this.
> > >
> > > apparently one should not ask such a question at 7 am. Any reason why
> > > BLKFLSBUF does not suite?
> >
> > That'll only write back data associated with /dev/hdXX (ie: filesystem
> > metadata) and not the data associated with all the files in the filesystem
> > which is mounted on /dev/hdXX.
> 
> I am confused. BKLFLSBUF boils down to sync_inodes_sb for mounted device, and 
> that appears to write out direty inode pages?

Oh, you're right.  How cunning.  Yes, `blockdev --flushbufs /dev/hda1'
would indeed appear to sync all data associated with that device.

