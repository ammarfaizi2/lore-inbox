Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbTFLRzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbTFLRzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:55:24 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:6285 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264929AbTFLRzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:55:17 -0400
Date: Thu, 12 Jun 2003 11:10:05 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andy Pfiffer <andyp@osdl.org>
Cc: christophe@saout.de, adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
Message-Id: <20030612111005.389e065b.akpm@digeo.com>
In-Reply-To: <1055441028.1202.11.camel@andyp.pdx.osdl.net>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	<1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	<1052513725.15923.45.camel@andyp.pdx.osdl.net>
	<1055369326.1158.252.camel@andyp.pdx.osdl.net>
	<1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	<1055377253.1222.8.camel@andyp.pdx.osdl.net>
	<20030611172958.5e4d3500.akpm@digeo.com>
	<1055438856.1202.6.camel@andyp.pdx.osdl.net>
	<20030612105347.6ea644b7.akpm@digeo.com>
	<1055441028.1202.11.camel@andyp.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 18:09:02.0634 (UTC) FILETIME=[B45570A0:01C3310D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> wrote:
>
> On Thu, 2003-06-12 at 10:53, Andrew Morton wrote:
> > Andy Pfiffer <andyp@osdl.org> wrote:
> > >
> > > Dirty:               0 kB	Dirty:               4 kB <---
> > 
> > OK.  And are you using initrd as well?
> 
> It is specified in lilo.conf (SuSE 8.0 distro) but I don't see any
> reason to keep it.  I'll yank it and see if it makes a difference.
> 

That would be interesting.

Also, what about this shot in the dark?


--- 25/fs/fs-writeback.c~a	2003-06-12 11:08:34.000000000 -0700
+++ 25-akpm/fs/fs-writeback.c	2003-06-12 11:08:39.000000000 -0700
@@ -368,7 +368,7 @@ void sync_inodes_sb(struct super_block *
 	};
 
 	get_page_state(&ps);
-	wbc.nr_to_write = ps.nr_dirty + ps.nr_unstable +
+	wbc.nr_to_write = ps.nr_dirty + ps.nr_unstable + 1024 +
 		(ps.nr_dirty + ps.nr_unstable) / 4;
 	spin_lock(&inode_lock);
 	sync_sb_inodes(sb, &wbc);

_

