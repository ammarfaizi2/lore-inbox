Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265185AbSJOXMc>; Tue, 15 Oct 2002 19:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265186AbSJOXMc>; Tue, 15 Oct 2002 19:12:32 -0400
Received: from zero.aec.at ([193.170.194.10]:4115 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S265185AbSJOXMb>;
	Tue, 15 Oct 2002 19:12:31 -0400
Date: Wed, 16 Oct 2002 01:18:22 +0200
From: Andi Kleen <ak@muc.de>
To: John Levon <levon@movementarian.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [4/7] oprofile - NMI hook
Message-ID: <20021015231822.GA32749@averell>
References: <20021015223319.GD41906@compsoc.man.ac.uk> <m33cr7l3ab.fsf@averell.firstfloor.org> <20021015230106.GA43030@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015230106.GA43030@compsoc.man.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 01:01:06AM +0200, John Levon wrote:
> On Wed, Oct 16, 2002 at 12:56:28AM +0200, Andi Kleen wrote:
> 
> > > This patch provides a simple api to let oprofile hook into
> > > the NMI interrupt for the perfctr profiler.
> > 
> > I would suggest using a notifier list instead (include/linux/notifier.h) 
> > This would handle multiple users cleanly.
> 
> How ? The only safe way I can see would be to spin lock around the NMI
> (and try lock when an NMI arrives).  This would either make every NMI
> contend on a single spinlock, or require a NR_CPUS-sized array of
> spinlocks, which is just ugly. And that wouldn't solve the
> power-management problem - any NMI users need to collaborate to disable
> NMI generation on a suspend.

The locking issues could be fixed with read-copy-update, but you're
right that it's not a good solution right now. I take the objection
back then.

-Andi
