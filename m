Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265783AbUACAoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 19:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUACAoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 19:44:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31169 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265783AbUACAoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 19:44:18 -0500
Date: Fri, 2 Jan 2004 19:44:06 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Joe Korty <joe.korty@ccur.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, albert.cahalan@ccur.com,
       jim.houston@ccur.com
Subject: Re: siginfo_t fracturing, especially for 64/32-bit compatibility mode
Message-ID: <20040103004406.GA24876@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040102194909.GA2990@rudolph.ccur.com> <20040103012433.6aa4cafb.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040103012433.6aa4cafb.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 01:24:33AM +0100, Andi Kleen wrote:
> > rt_sigqueueinfo(2) subverts this by reserving a range of si_code
> > values for users, and there is nothing about them to indicate to the
> > kernel which fields of siginfo_t are actually in use.  This is not a
> 
> My understanding was that the syscall always only supports si_int/si_ptr.

No, why?

> > 
> > The current conflicts are:
> 
> [...SI_TKILL, SI_ASYNCIO...] that's broken. We just cannot support that. This aspect of 
> SuS just cannot be emulated in user space, glibc was misguided about attempting
> it.

SI_ASYNCNL is -60, not -6.
Negative si_code values are reserved for userspace, while positive ones are for
kernel space.

	Jakub
