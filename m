Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTKJQ54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTKJQ5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:57:55 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54454
	"EHLO x30.random") by vger.kernel.org with ESMTP id S263996AbTKJQ5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:57:54 -0500
Date: Mon, 10 Nov 2003 17:57:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Larry McVoy <lm@bitmover.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031110165738.GD6834@x30.random>
References: <20031110132617.GA6834@x30.random> <Pine.LNX.4.44.0311100844190.1821-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311100844190.1821-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 08:49:20AM -0800, Davide Libenzi wrote:
> On Mon, 10 Nov 2003, Andrea Arcangeli wrote:
> 
> > same here, however the rsync export on kernel.org is lacking a two
> > sequence number locking that would allow us to checkout a coherent copy
> > of the cvs repository.  Currently it works by luck.
> 
> Peter, how the current rsync BKCVS root is updated at kernel.org? Is 
> coherency guaranteed in some way?

our rsync isn't going to be coherency guaranteed anyways, no matter how
the updates shows up on kernel.org, rsync can't even hang on per-file
locks, sure it can't be coherent as a whole.

The best way to fix this isn't to add locking to rsync, but to add two
files inside or outside the tree, each one is a sequence number, so you
fetch file1 first, then you rsync and you fetch file2, then you compare
them. If they're the same, your rsync copy is coherent. It's the same
locking we introduced with vgettimeofday.

Ideally rsync could learn to check the sequence numbers by itself but I
don't mind a bit of scripting outside of rsync.
