Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbUCNBt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 20:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263247AbUCNBt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 20:49:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:61651 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263246AbUCNBt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 20:49:56 -0500
Date: Sat, 13 Mar 2004 17:49:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Micha Feigin <michf@post.tau.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: finding out the value of HZ from userspace
Message-Id: <20040313174929.32b6d259.akpm@osdl.org>
In-Reply-To: <20040314010508.GL5960@luna.mooo.com>
References: <20040311141703.GE3053@luna.mooo.com>
	<1079198671.4446.3.camel@laptop.fenrus.com>
	<4053624D.6080806@BitWagon.com>
	<20040313193852.GC12292@devserv.devel.redhat.com>
	<20040313221418.GF5960@luna.mooo.com>
	<1079217159.4915.0.camel@laptop.fenrus.com>
	<20040314010508.GL5960@luna.mooo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micha Feigin <michf@post.tau.ac.il> wrote:
>
>  > Wrong. Any such interface is supposed to convert automatically. Any
>  > interface you can find that doesn't should be reported as a serious bug!
>  > 
> 
>  Like I said, look at bdflush in 2.4 (this was fixed with the changed 2.6
>  interface) and xfs proc interface in both 2.4 and 2.6.
>  In light of your post then there is a serious bug.
> 
>  For example for bdflush age_buffer field (true for the other used fields
>  also), no conversion:
>  	bh->b_flushtime = jiffies + bdf_prm.b_un.age_buffer;

I doubt if there's any motivation to fix these things in 2.4.  If you change
HZ in 2.4 you own both pieces.  (alpha has HZ=1024 in 2.4, so presumably
bdflush tuning doesn't work right).

In 2.6, the bdflush parameters do not exist.  They were replaced by
/proc/sys/vm/*_centisecs, which are HZ-independent.

There are, I think, still some /proc tunables in 2.6 which do depend upon
HZ and they should be found and fixed.  If the same tunables are present in
2.4 kernels then they should be converted to take centiseconds in 2.6, so
2.4-based tools continue to work correctly.

We have similar problems where /proc tunables are expressed in terms of
"number of pages".  As PAGE_SIZE varies from 4096 to 65536 this is
sometimes wrong.  Fixing this is more subtle.
