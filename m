Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWAWQuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWAWQuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWAWQuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:50:18 -0500
Received: from mail.shareable.org ([81.29.64.88]:29072 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S964773AbWAWQuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:50:16 -0500
Date: Mon, 23 Jan 2006 16:50:02 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Diego Calleja <diegocg@gmail.com>, Ram Gupta <ram.gupta5@gmail.com>,
       mloftis@wgops.com, barryn@pobox.com, a1426z@gawab.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060123165002.GA6140@mail.shareable.org>
References: <20060123162624.5c5a1b94.diegocg@gmail.com> <Pine.LNX.4.61.0601231058200.11299@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601231058200.11299@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Mon, 23 Jan 2006, Diego Calleja wrote:
> > However, I doubt the approach is really useful. If you need that much
> > swap space, you're going well beyond the capabilities of the machine.
> > In fact, I bet that most of the cases of machines needing too much
> > memory will be because of bugs in the programs and OOM'ing would be
> > a better solution.
> 
> You have roughly 2 GB of dynamic address-space avaliable to each
> task (stuff that's not the kernel and not the runtime libraries).
> You can easily have 500 tasks, even RedHat out-of-the-box creates
> about 60 tasks. That's 1,000 GB of potential swap-space required
> to support this.

And how many machines is it useful to use that much swap-space on?

> This is not beyond the capabilites of a 32-bit
> machine with a fast front-side bus and fast I/O (like wide SCSI).

Anything but the most expensively RAM-equipped machine would be stuck
in a useless swap-storm, if it's got 1000GB of GB of active swap space
and only a relatively tiny amount of physical RAM (e.g. 16GB).  The
same is true if only, say, 10% of the swap space is in active use.

Wide SCSI isn't fast enough to make that useful.

I think that was the point Diego was making: you can use that much
swap space, but by the time you do, whatever task you hoped to
accomplish won't get anywhere due to the swap-storm.

> Some persons tend to forget that 32-bit address space is available
> to every user, some is shared, some is not. A reasonable rule-of-
> thumb is to provide enough swap-space to duplicate the address-
> space of every potential task.

I think that's a ridiculous rule of thumb.  Not least because (a) even
the biggest drive available (e.g. 1TB) doesn't provide that much
swap-space, and (b) if you're actively using only a tiny fraction of
that, your machine has already become uselessly slow - even root
logins and command prompts don't work under those conditions.

-- Jamie
