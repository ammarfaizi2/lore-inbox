Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTE1XIv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTE1XIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:08:51 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:39548 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261702AbTE1XHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:07:47 -0400
Date: Wed, 28 May 2003 16:18:37 -0700
From: Andrew Morton <akpm@digeo.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       neilb@cse.unsw.edu.au
Subject: Re: 2.5.70-mm1 bootcrash, possibly RAID-1
Message-Id: <20030528161837.409099eb.akpm@digeo.com>
In-Reply-To: <20030528225913.GA1103@hh.idb.hist.no>
References: <20030408042239.053e1d23.akpm@digeo.com>
	<3ED49A14.2020704@aitel.hist.no>
	<20030528111345.GU8978@holomorphy.com>
	<3ED49EB8.1080506@aitel.hist.no>
	<20030528113544.GV8978@holomorphy.com>
	<20030528225913.GA1103@hh.idb.hist.no>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 23:21:03.0503 (UTC) FILETIME=[CEA519F0:01C3256F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> On Wed, May 28, 2003 at 04:35:44AM -0700, William Lee Irwin III wrote:
> > 
> > This is unusual; I'm having trouble very close to this area. There is
> > a remote chance it could be the same problem.
> > 
> > Could you log this to serial and get the rest of the oops/BUG? If it's
> > where I think it is, I've been looking at end_page_writeback() and so
> > might have an idea or two.
> 
> I tried 2.5.70-mm1 on the dual celeron at home.  This one has
> scsi instead of ide, so I guess it is a RAID-1 problem.
> This machine has root on raid-1 too.  I believe there where
> several oopses in a row, I captured all of the last one
> thanks to a framebuffer with a small font. Here it is:
> 
> Unable to handle kernel paging request at virtual address 8a8a8ab6
> *pde=0 OOPS 0000 [#1]
> EIP at put_all_bios+0x47/0x80
> (edx was the register containing 8a8a8a8a)
> Process swapper pid=0 threadinfo c1352000 task=c13f52d0
> Call trace:
> raid_end_bio_io
> raid1_end_request

That's POISON_BEFORE: "use of uninitialised memory", not "use of freed
memory".

I fiddled with the slab poisoning values, and shall undo that.
