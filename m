Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265814AbUACBH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 20:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265848AbUACBH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 20:07:29 -0500
Received: from ns.suse.de ([195.135.220.2]:45697 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265814AbUACBH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 20:07:28 -0500
Date: Sat, 3 Jan 2004 02:07:26 +0100
From: Andi Kleen <ak@suse.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: joe.korty@ccur.com, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, albert.cahalan@ccur.com,
       jim.houston@ccur.com
Subject: Re: siginfo_t fracturing, especially for 64/32-bit compatibility
 mode
Message-Id: <20040103020726.7c4397bc.ak@suse.de>
In-Reply-To: <20040103004406.GA24876@devserv.devel.redhat.com>
References: <20040102194909.GA2990@rudolph.ccur.com>
	<20040103012433.6aa4cafb.ak@suse.de>
	<20040103004406.GA24876@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jan 2004 19:44:06 -0500
Jakub Jelinek <jakub@redhat.com> wrote:

> On Sat, Jan 03, 2004 at 01:24:33AM +0100, Andi Kleen wrote:
> > > rt_sigqueueinfo(2) subverts this by reserving a range of si_code
> > > values for users, and there is nothing about them to indicate to the
> > > kernel which fields of siginfo_t are actually in use.  This is not a
> > 
> > My understanding was that the syscall always only supports si_int/si_ptr.
> 
> No, why?

Because otherwise it cannot be supported in the 32bit emulation. Or rather you
won't get any conversion.

> 
> > > 
> > > The current conflicts are:
> > 
> > [...SI_TKILL, SI_ASYNCIO...] that's broken. We just cannot support that. This aspect of 
> > SuS just cannot be emulated in user space, glibc was misguided about attempting
> > it.
> 
> SI_ASYNCNL is -60, not -6.
> Negative si_code values are reserved for userspace, while positive ones are for
> kernel space.

Ok, if the kernel generates that that's broken too then.

-Andi
