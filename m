Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265288AbUGGSmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUGGSmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbUGGSmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:42:19 -0400
Received: from mail-relay-1.tiscali.it ([212.123.84.91]:48297 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S265288AbUGGSmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:42:15 -0400
Date: Wed, 7 Jul 2004 20:42:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: marcelo.tosatti@cyclades.com, mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: Unnecessary barrier in sync_page()?
Message-ID: <20040707184202.GN28479@dualathlon.random>
References: <20040707175724.GB3106@logos.cnet> <20040707182025.GJ28479@dualathlon.random> <20040707112953.0157383e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707112953.0157383e.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 11:29:53AM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > however the smp_mb() isn't needed in sync_page, simply because it's
> >  perfectly ok if we start running sync_page before reading pagelocked.
> >  All we care about is to run sync_page _before_ io_schedule() and that we
> >  read PageLocked _after_ prepare_to_wait_exclusive.
> > 
> >  So the locking in between PageLocked and sync_page is _absolutely_
> >  worthless and the smp_mb() can go away.
> 
> IIRC, Chris added that barrier (and several similar) for the reads in
> page_mapping().

how does it help to know the page is not locked before executing
page_mapped?
