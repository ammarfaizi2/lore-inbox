Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbSJQFQe>; Thu, 17 Oct 2002 01:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbSJQFQe>; Thu, 17 Oct 2002 01:16:34 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4129 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261801AbSJQFQd>; Thu, 17 Oct 2002 01:16:33 -0400
Date: Thu, 17 Oct 2002 01:22:46 -0400
From: Doug Ledford <dledford@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: balance_dirty_pages broken
Message-ID: <20021017052246.GB10276@redhat.com>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <20021017043623.GR8159@redhat.com> <3DAE4615.F98B6DE@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAE4615.F98B6DE@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 10:09:41PM -0700, Andrew Morton wrote:
> Doug Ledford wrote:
> > 
> > Actually, I don't know if it's balance_dirty_pages fault or some other
> > part of the kernel's fault, but it is broken here.  Failure mode is that
> > balance_dirty_pages would loop forever.  Reason it would loop forever is
> > because the ps struct had a negative entry for nr_dirty.
> 
> I've seen one other report of this.  Something has gone wrong
> with the page accounting.  Could you please send me your
> .config and a description of what filesytems you're using?

Sure, coming under separate cover.

> err.  ramdisk?   initrd? If so, does this fix?

initrd.  Will try booting without initrd and see if memcounts go back to 
normal.  On the current setup, when the thing locks up, Shift-ScrollLock 
dumps the meminfo.  Of interest here is the line right after the 
Zone:HighMem line which reads:

( Active:1634 inactive:1603 dirty:4294966795 writeback:0 free:59222 )

Booting without initrd solves the lockup issue.  It also clears up the 
dirty count.  So, initrd is what's corrupting things.  I'll try the patch 
and let you know if it solves the initrd corruption here in a sec.

> 
> 
>  drivers/block/rd.c |  173 +++++++++++++++++++++++------------------------------
>  fs/buffer.c        |   18 +++--
>  kernel/ksyms.c     |    1 
>  3 files changed, 90 insertions(+), 102 deletions(-)

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
