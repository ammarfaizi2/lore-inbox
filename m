Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVC0AYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVC0AYI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 19:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVC0AYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 19:24:08 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:15355 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261367AbVC0AYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 19:24:02 -0500
Subject: Re: [Ext2-devel] Re: OOM problems on 2.6.12-rc1 with many fsx tests
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de, mjbligh@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1111788665.21169.54.camel@dyn318077bld.beaverton.ibm.com>
References: <20050315204413.GF20253@csail.mit.edu>
	 <20050316003134.GY7699@opteron.random>
	 <20050316040435.39533675.akpm@osdl.org>
	 <20050316183701.GB21597@opteron.random>
	 <1111607584.5786.55.camel@localhost.localdomain>
	 <20050325135630.28cd492c.akpm@osdl.org>
	 <1111788665.21169.54.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Sat, 26 Mar 2005 16:23:58 -0800
Message-Id: <1111883038.3633.9.camel@dyn318043bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 14:11 -0800, Badari Pulavarty wrote:
> On Fri, 2005-03-25 at 13:56, Andrew Morton wrote:
> > Mingming Cao <cmm@us.ibm.com> wrote:
> > >
> > > I run into OOM problem again on 2.6.12-rc1. I run some(20) fsx tests on
> > > 2.6.12-rc1 kernel(and 2.6.11-mm4) on ext3 filesystem, after about 10
> > > hours the system hit OOM, and OOM keep killing processes one by one. I
> > > could reproduce this problem very constantly on a 2 way PIII 700MHZ with
> > > 512MB RAM. Also the problem could be reproduced on running the same test
> > > on reiser fs.
> > > 
> > > The fsx command is:
> > > 
> > > ./fsx -c 10 -n -r 4096 -w 4096 /mnt/test/foo1 &
> > 
> > I was able to reproduce this on ext3.  Seven instances of the above leaked
> > 10-15MB over 10 hours.  All of it permanently stuck on the LRU.
> > 
> > I'll continue to poke at it - see what kernel it started with, which
> > filesystems it affects, whether it happens on UP&&!PREEMPT, etc.  Not a
> > quick process.
> 
> I reproduced *similar* issue with 2.6.11. The reason I say similar, is
> there is no OOM kill, but very low free memory and machine doesn't
> respond at all. (I booted my machine with 256M memory and ran 20 copies
> of fsx on ext3).
> 
> 

Yes, I re-run the same test on 2.6.11 for 24 hours, like Badari see on
his machine, my machine did not go to OOM on 2.6.11,still alive, but
memory is very low(only 5M free). Killed all fsx and umount the ext3
filesystem did not bring back much memory. I will going to rerun the
tests without the mapped read/write to see what happen.


