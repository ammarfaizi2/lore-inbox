Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTIYASV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 20:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTIYASV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 20:18:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:43193 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261567AbTIYAST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 20:18:19 -0400
Date: Wed, 24 Sep 2003 17:18:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
In-Reply-To: <20030924235041.GA21416@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0309241710380.1688-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Sep 2003, Andries Brouwer wrote:
> 
> Ha, Linus - didn't you know I am always right?

Yeah, sure. But ...

> But being right in theory - like you say, I have repeated these
> things for many years - is not enough to submit a kernel patch.
> The post of today was prompted by a mail about
> certain USB devices:
> 
> > On closer examination it seems to be the partition table
> > which is read ok (as one partition) on W2K and XP
> > but Linux (both 2.4 and 2.6) gets really confused and
> > thinks there are 4 malformed partitions.

So? There's a bug, and we'll fix it. 

The _worst_ thing that can happen is that you have four extra (totally 
bogus) partitions, and you end up using the whole device.

That's my point about partitioning - not that it's necessarily perfect, 
but even when it _isn't_ perfect, it's no worse than not partitioning at 
all.

I know you don't want the kernel to partition at all. But I don't see your 
point. 

> > Linux probably needs to handle this situation more
> > gracefully. A local police force bought a bunch of
> > these devices for Linux based forensic work. They
> > are a bit disappointed at the moment.
> 
> So, now not only theory but also practice is involved, and
> we must do something.

Why don't they just read the whole device, if that is what they want to
do?

So we have two cases:
 a) we have a bug in the partitioning code, and don't parse the partition 
    table right:
	- let's fix the bug
 b) people don't want to read the partition info at all, as it's bogus
	- use the whole-device node.

In neither case is your "the kernel shouldn't guess" argument the answer, 
as far as I can see. And in both cases you _can_ fix it up in user mode if 
you know how, so clearly the kernel was no worse off guessing.

		Linus

