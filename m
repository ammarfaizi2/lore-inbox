Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUCCAPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 19:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUCCAPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 19:15:43 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:15579 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S261802AbUCCAPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 19:15:41 -0500
Date: Wed, 3 Mar 2004 01:15:10 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
       miquels@cistron.nl
Subject: Re: 2.6.4-rc1-mm1: queue-congestion-dm-implementation patch
Message-ID: <20040303001510.GA23103@drinkel.cistron.nl>
References: <cistron.200403011400.51008.kevcorry@us.ibm.com> <20040302130137.GA9941@cistron.nl> <200403020826.52448.kevcorry@us.ibm.com> <20040302142134.4074cd2f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040302142134.4074cd2f.akpm@osdl.org> (from akpm@osdl.org on Tue, Mar 02, 2004 at 23:21:34 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2004 23:21:34, Andrew Morton wrote:
> Kevin Corry <kevcorry@us.ibm.com> wrote:
> >
> > > Changing down_read() in dm_any_congested to down_read_trylock() would
> > > probably fix it for bdi_*_congested(). If you can tell me how to
> > > reproduce it I can try a few things..
> > 
> > Switching to down_read_trylock() would certainly eliminate this problem, as 
> > long as you don't *need* to check the congestion of the underlying devices 
> > each time dm_any_congested() is called.
> 
> It's clear from the trace: we're doing down_read() inside
> sync_sb_inodes()'s inode_lock.
> 
> Yes, a trylock would fix it up, but it's a bit sleazy.
>
> So for two reasons now, it's looking like that semaphore which protects the
> devicemapper tables needs to become a spinlock.  One which has interesting
> ranking properties.

Is that 2.6 material? If so, good. If not, the "passing up" congestion
method doesn't seem so bad after all, I think. At least it keeps the
backing_dev_info struct completely static ..

(I haven't tried 2.6.4-rc1-mm1 yet - the e1000 driver doesn't work for me
 in that kernel, so I can't reach the damn boxes).

Mike.
