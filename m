Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTJOXwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 19:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbTJOXwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 19:52:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:20157 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262115AbTJOXwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 19:52:08 -0400
Date: Wed, 15 Oct 2003 16:52:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-Id: <20031015165205.0cc40606.akpm@osdl.org>
In-Reply-To: <20031015232440.GU17986@fs.tum.de>
References: <20031015225055.GS17986@fs.tum.de>
	<20031015161251.7de440ab.akpm@osdl.org>
	<20031015232440.GU17986@fs.tum.de>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> On Wed, Oct 15, 2003 at 04:12:51PM -0700, Andrew Morton wrote:
> >...
> > They are small concerns really, but it does make one wonder why we should
> > not make this change unconditional: just switch the kernel to -Os?
> > 
> > Does anyone have any (non-micro-)benchmark results which say this is a bad
> > idea?
> 
> No benchmarks, only arguments:
> 
> - it's less tested (there might be miscompilations in some part of the 
>   kernel with some supported compilers)

Testing is not a problem.

> - there might be fast path code somewhere in the kernel that becomes
>   significantely slower with -Os

I really doubt it.  Kernel CPU footprint is dominated by dcache misses.  If
-Os reduces icache footprint it may even be a net win; people tend to
benchmark things in tight loops, which favours fast code over small code.

> - I've already seen a report for an ICE in gcc 2.95 of a user compiling
>   kernel 2.4 with -Os [1]

Well there's only one way to find out if we'll hit that.  How's about you
cook me a patch which switches to -Os unconditionally and we'll see how it
goes?

