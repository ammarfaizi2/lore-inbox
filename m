Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSLBJ3V>; Mon, 2 Dec 2002 04:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbSLBJ3V>; Mon, 2 Dec 2002 04:29:21 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34977 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261859AbSLBJ3U>; Mon, 2 Dec 2002 04:29:20 -0500
Date: Mon, 2 Dec 2002 04:36:45 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Start of compat32.h (again)
Message-ID: <20021202043645.Q27455@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com.suse.lists.linux.kernel> <1038804400.4411.4.camel@rth.ninka.net.suse.lists.linux.kernel> <p737kesu9bt.fsf@oldwotan.suse.de> <20021202.002815.58826951.davem@redhat.com> <20021202090756.GA26034@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021202090756.GA26034@wotan.suse.de>; from ak@suse.de on Mon, Dec 02, 2002 at 10:07:56AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 10:07:56AM +0100, Andi Kleen wrote:
> > The data is where I'd say the bloat would be, and lo and behold is a
> > nearly 7-fold increase for the sample you give us _only_ in the .data
> > section.
> 
> .data is normally not a significant part of programs, because few programs
> use global variables that heavily (yes, there are exceptions, like that emacs 
> thing, but it's not common) 

.data is significant, that is e.g. something that cannot be shared
between processes.
The fastest model on x86-64 would IMHO be a 32-bit model using all
registers, rip relative addressing and register passing conventions
(ie. a 3rd ABI).

> > BTW, I bet your dynamic relocation tables are a bit larger too.
> 
> Somewhat, but does it matter?  They are not kept in memory anyways.

Surely it does, for startup time (unless prelinking) the 3 times bigger .rel*
sections mean significantly more data needs to be loaded into RAM and
caches, for short-lived processes it matters a lot.

	Jakub
