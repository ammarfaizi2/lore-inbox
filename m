Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWH3Ukb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWH3Ukb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWH3Ukb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:40:31 -0400
Received: from 1wt.eu ([62.212.114.60]:46097 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751509AbWH3Ukb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:40:31 -0400
Date: Wed, 30 Aug 2006 22:40:12 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andi Kleen <ak@suse.de>
Cc: pageexec@freemail.hu, davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] exception processing in early boot
Message-ID: <20060830204012.GB496@1wt.eu>
References: <20060830063932.GB289@1wt.eu> <200608302136.54624.ak@suse.de> <20060830200354.GA496@1wt.eu> <200608302206.46898.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608302206.46898.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 10:06:46PM +0200, Andi Kleen wrote:
> On Wednesday 30 August 2006 22:03, Willy Tarreau wrote:
> > On Wed, Aug 30, 2006 at 09:36:54PM +0200, Andi Kleen wrote:
> > > 
> > > > Andi, if you remove the HLT here, some CPUs will spin at full speed. This
> > > > is nasty during boot because some of them might not have enabled their
> > > > fans yet for instance
> > > 
> > > That would be a severe bug in the platform. Basically always the fans are managed
> > > by SMM code.
> > 
> > It was just an example. Other examples include virtual machines never
> > stopping because they will see the guest is working and not halted.
> 
> They have to deal with that anyways because the machine can just
> crash with a busy loop. And BTW -- take a look at the normal panic.

OK, generic multi-platform code, blinking keyboard leds, etc...
I don't get your point, what are you trying to demonstrate ?
If you want to explain your reject of the HLT instruction just
because other places in the kernel don't use it, that's rather
counter-evolutive and another approach might be to ask if it
would not be appropriate to add a few others at some places.

But you justified your removal of this instruction by your fear
of a potential problem caused by a but pointed out by some poorly
commented field in one struct, and left open a small window for a
change in case someone else confirmed it. We took time to explain
why this bug was even in our advantage. If you really didn't want
the HLT in the first place for your own reasons, we would have all
saved some time by neither searching info on it nor talking about
it.

I don't really mind whether the CPU really halts or not, it's just
that I find it stupid to make it spin for nothing when we know we
can avoid it. That's all.

Regards,
Willy

