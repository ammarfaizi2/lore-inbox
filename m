Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbUKIPX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbUKIPX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 10:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbUKIPX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 10:23:59 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:26125 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261557AbUKIPWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 10:22:50 -0500
Date: Tue, 9 Nov 2004 15:22:46 +0000
From: John Levon <levon@movementarian.org>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/11] oprofile: arch-independent code for stack trace sampling
Message-ID: <20041109152246.GD43366@compsoc.man.ac.uk>
References: <1099996668.1985.783.camel@hole.melbourne.sgi.com> <20041109030557.1de3f96a.akpm@osdl.org> <1100000147.1985.839.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100000147.1985.839.camel@hole.melbourne.sgi.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CRXpX-000CGx-5a*DDJajprgYLQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 10:35:48PM +1100, Greg Banks wrote:

> > oprofile is currently doing suspicious things with smp_processor_id() in
> > premptible reasons.  Is this patch compounding things?
> 
> It's not changing the contexts where smp_processor_id() is called,
> just pushing it down one level from a bunch of interrupt handlers
> to the 2 oprofile sampling functions they call.  If it was busted
> before it's no more nor less busted now.
> 
> I presume the perceived problem is that with CONFIG_PREEMPT=y the
> thread can be pre-empted onto another CPU?  If it makes everyone
> happier I can sprinkle a few preempt_disable()s around, but I'd
> prefer to do it in a subsequent patch rather than respin this.

Andrew: basically the warning is false, there is no bug in this code.

we don't want to use preempt_disable(). Instead we want some way to get
a CPU ID and then carry on in pre-emptible fashion. It's only used to
index into an array, and if we get pre-empted onto another CPU it's not
a major deal.

(Yes, this breaks with CPU hotplug, but so does the rest of OProfile and
I've yet to see a sensible API for handling this, that is a ctor/dtor
style API)

regards
john
