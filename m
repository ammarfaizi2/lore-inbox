Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265972AbTIKBri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbTIKBri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:47:38 -0400
Received: from ns.suse.de ([195.135.220.2]:51344 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265972AbTIKBrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:47:17 -0400
Date: Thu, 11 Sep 2003 03:47:16 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030911014716.GG3134@wotan.suse.de>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com> <20030911012708.GD3134@wotan.suse.de> <20030910184414.7850be57.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910184414.7850be57.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 06:44:14PM -0700, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> >  +static int is_prefetch(struct pt_regs *regs, unsigned long addr)
> 
> Can we make this code go away if the configured CPU is, say, Intel?
> (I couldn't find a sane CONFIG_ setting to use for this).

It could be done but ... we are moving more and more to generic kernels
(e.g. see the alternative patch code which is enabled unconditionally)
So that when you have a kernel it will boot on near all modern CPUs.
Currently Athlon and P4 kernels run on each other for example.

I would hate to break this again just to save a few hundred bytes in 
this function. Also the overhead is very low so it is also not 
interesting to make it conditional for speed reasons.

> 
> It might be vaguely interesting to add a user-visible counter for this
> event? If someone somehow comes up with an application which hits the fault
> frequently they will take a big performance hit.

In that case they can just profile the kernel. is_prefetch should
show it then.

Of course someone can still add the counter if they want, I'm not
opposed to it.

-Andi

