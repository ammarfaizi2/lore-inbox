Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWAKRam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWAKRam (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWAKRam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:30:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:645 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932351AbWAKRal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:30:41 -0500
Date: Wed, 11 Jan 2006 09:30:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: bos@pathscale.com, hch@infradead.org, rdreier@cisco.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
Message-Id: <20060111093019.097d156a.akpm@osdl.org>
In-Reply-To: <20060111172216.GA18292@mars.ravnborg.org>
References: <adaslrw3zfu.fsf@cisco.com>
	<1136909276.32183.28.camel@serpentine.pathscale.com>
	<20060110170722.GA3187@infradead.org>
	<1136915386.6294.8.camel@serpentine.pathscale.com>
	<20060110175131.GA5235@infradead.org>
	<1136915714.6294.10.camel@serpentine.pathscale.com>
	<20060110140557.41e85f7d.akpm@osdl.org>
	<1136932162.6294.31.camel@serpentine.pathscale.com>
	<20060110153257.1aac5370.akpm@osdl.org>
	<1137000032.11245.11.camel@camp4.serpentine.com>
	<20060111172216.GA18292@mars.ravnborg.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Wed, Jan 11, 2006 at 09:20:32AM -0800, Bryan O'Sullivan wrote:
> > On Tue, 2006-01-10 at 15:32 -0800, Andrew Morton wrote:
> > 
> > > Unless someone can think of a problem with attribute(weak), I think you'll
> > > find that it's the simplest-by-far solution.
> > 
> > The only problem I can see with this is that on x86_64 and other
> > platforms that reimplement the routine as an inline function, I think
> > we'll be left with a small hunk of dead code in the form of the
> > out-of-line version in lib/ that never gets referenced.

Sure, attribute(weak) assumes that nobody want to implement the thing as an
inline.  Are yu sure that we want to do that?  After all, copying memory is
sloooooow, and copying IO memory probably has even more "o"'s.

> If it is not referenced the linker should not pull it in from lib.a -
> no?

If it's in it's own .o file.  But it might be referenced from modules, so
we must always include it in vmlinux if we compiled it.
