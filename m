Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUKILjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUKILjt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbUKILh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:37:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28596 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261477AbUKILf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:35:57 -0500
Subject: Re: [PATCH 2/11] oprofile: arch-independent code for stack trace
	sampling
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041109030557.1de3f96a.akpm@osdl.org>
References: <1099996668.1985.783.camel@hole.melbourne.sgi.com>
	 <20041109030557.1de3f96a.akpm@osdl.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1100000147.1985.839.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 22:35:48 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 22:05, Andrew Morton wrote:
> Greg Banks <gnb@melbourne.sgi.com> wrote:
> >
> > +	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[smp_processor_id()];
> 
> oprofile is currently doing suspicious things with smp_processor_id() in
> premptible reasons.  Is this patch compounding things?

It's not changing the contexts where smp_processor_id() is called,
just pushing it down one level from a bunch of interrupt handlers
to the 2 oprofile sampling functions they call.  If it was busted
before it's no more nor less busted now.

I presume the perceived problem is that with CONFIG_PREEMPT=y the
thread can be pre-empted onto another CPU?  If it makes everyone
happier I can sprinkle a few preempt_disable()s around, but I'd
prefer to do it in a subsequent patch rather than respin this.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


