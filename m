Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbTGHTMy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbTGHTMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:12:24 -0400
Received: from ns.suse.de ([213.95.15.193]:11527 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267537AbTGHTMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:12:08 -0400
Date: Tue, 8 Jul 2003 21:26:42 +0200
From: Andi Kleen <ak@suse.de>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org
Subject: Re: [RFC] parallel directory operations
Message-Id: <20030708212642.7d7b44ea.ak@suse.de>
In-Reply-To: <20030708102225.D4482@schatzie.adilger.int>
References: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel>
	<p73brw5qmxk.fsf@oldwotan.suse.de>
	<87of05ujfo.fsf@gw.home.net>
	<20030708134601.7992e64a.ak@suse.de>
	<20030708102225.D4482@schatzie.adilger.int>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003 10:22:25 -0700
Andreas Dilger <adilger@clusterfs.com> wrote:

> On Jul 08, 2003  13:46 +0200, Andi Kleen wrote:
> > On Tue, 08 Jul 2003 15:28:27 +0000 bzzz@tmi.comex.ru wrote:
> > > dynlocks implements 'lock namespace', so you can lock A for namepace N1 and
> > > lock B for namespace N1 and so on. we need this because we want to take lock
> > > on _part_ of directory.
> > 
> > Ok, a mini database lock manager. Wouldn't it be better to use a small hash 
> > table and lock escalation on overflow for this?  Otherwise you could
> > have quite a lot of entries queued up in the list if the server is slow.
> 
> That was my initial thought also, but the number of locks that are in
> existence at one time are very small (i.e. number of threads active in
> a directory at one time).  Having a "more scalable" locking setup will,
> I think, hurt performance for the common case.

I don't see how it will be slower than the current patch.

The main advantage of lock escalation is that the worst case is bounded
very closely (worst it is just like currently with the single lock) 

-Andi
