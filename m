Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbSJQFe4>; Thu, 17 Oct 2002 01:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbSJQFe4>; Thu, 17 Oct 2002 01:34:56 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33061 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261800AbSJQFe4>; Thu, 17 Oct 2002 01:34:56 -0400
Date: Thu, 17 Oct 2002 01:41:10 -0400
From: Doug Ledford <dledford@redhat.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: balance_dirty_pages broken
Message-ID: <20021017054110.GC10276@redhat.com>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <20021017043623.GR8159@redhat.com> <3DAE4615.F98B6DE@digeo.com> <20021017052246.GB10276@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017052246.GB10276@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 01:22:46AM -0400, Doug Ledford wrote:
> Sure, coming under separate cover.

Actually, this isn't needed now I assume ;-)

> > err.  ramdisk?   initrd? If so, does this fix?
> 
> initrd.  Will try booting without initrd and see if memcounts go back to 
> normal.  On the current setup, when the thing locks up, Shift-ScrollLock 
> dumps the meminfo.  Of interest here is the line right after the 
> Zone:HighMem line which reads:
> 
> ( Active:1634 inactive:1603 dirty:4294966795 writeback:0 free:59222 )
> 
> Booting without initrd solves the lockup issue.  It also clears up the 
> dirty count.  So, initrd is what's corrupting things.  I'll try the patch 
> and let you know if it solves the initrd corruption here in a sec.

Patch solves the problem.  Writes don't hang and Shift-ScrollLock shows a 
reasonable number for dirty now.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
