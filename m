Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030781AbWKOSBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030781AbWKOSBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030783AbWKOSBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:01:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38559 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030781AbWKOSBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:01:42 -0500
Date: Wed, 15 Nov 2006 10:01:19 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: sleeping functions called in invalid context during resume
Message-ID: <20061115100119.460b7a4e@localhost.localdomain>
In-Reply-To: <20061115093354.GA30813@elte.hu>
References: <20061114223002.10c231bd@localhost.localdomain>
	<20061115012025.13c72fc1.akpm@osdl.org>
	<20061115093354.GA30813@elte.hu>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 10:33:54 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > >  [<ffffffff80215059>] vfs_write+0xce/0x174
> > >  [<ffffffff802159a5>] sys_write+0x45/0x6e
> > >  [<ffffffff802593de>] system_call+0x7e/0x83
> > > DWARF2 unwinder stuck at system_call+0x7e/0x83
> > > 
> > > Leftover inexact backtrace:
> > 
> > Could mean that someone somewhere forgot to release a spinlock.
> > 
> > Ingo had a patch which would find the culprit (preempt-tracing.patch).
> > 
> > Does it still live?
> 
> if it's really a spinlock/rwlock release that was missed, then i've got 
> good news: we already have that debugging infrastructure, it's called 
> lockdep :-)
> 
> The patch below makes use of that capability of lockdep for all 
> stackdumps that are printed to the console. Stephen, please apply this 
> patch, enable CONFIG_PROVE_LOCKING and try to trigger another message. 
> 
> 	Ingo

I tried but with CONFIG_PROVE_LOCKING, resume gets stuck in an infinite
loop backtracing to the console.  Unfortunately, the serial console isn't up
at that point so it it isn't capturable. 
