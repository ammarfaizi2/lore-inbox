Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263816AbTKFVVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 16:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTKFVVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 16:21:25 -0500
Received: from nevyn.them.org ([66.93.172.17]:227 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263816AbTKFVVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 16:21:23 -0500
Date: Thu, 6 Nov 2003 16:21:20 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Message-ID: <20031106212119.GA835@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1068140199.12287.246.camel@nosferatu.lan> <20031106093746.5cc8066e.davem@redhat.com> <1068143563.12287.264.camel@nosferatu.lan> <1068144179.12287.283.camel@nosferatu.lan> <20031106113716.7382e5d2.davem@redhat.com> <1068149368.12287.331.camel@nosferatu.lan> <20031106120548.097ccc7c.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031106120548.097ccc7c.davem@redhat.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 12:05:48PM -0800, David S. Miller wrote:
> On Thu, 06 Nov 2003 22:09:29 +0200
> Martin Schlemmer <azarah@gentoo.org> wrote:
> 
> > On Thu, 2003-11-06 at 21:37, David S. Miller wrote:
> > > Let's say that you end up using some inline function
> > > that takes u32 arguments, and internally it uses
> > > u64 types to speed up the calculation or make it more
> > > accurate or something like that.
> > 
> > So basically only in cases where the stuff in byteorder.h
> > was not inlined ... ?
> 
> No, exactly in the cases where it _IS_ inlined.  Imagine
> this:
> 
> static inline u32 swab_foo(u32 a, u32 b)
> {
> 	u64 tmp = ((u64)a<<32) | ((u64)b);
> 	u32 retval;
> 
> 	retval = compute(tmp);
> 
> 	return retval;
> }
> 
> If that's in a kernel header somewhere, and you build with -ansi,
> you lose.

In general the inlines should be __KERNEL__'d anyway.  In any case, the
prior art in <linux/types.h> is:

#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
typedef         __u64           uint64_t;
typedef         __u64           u_int64_t;
typedef         __s64           int64_t;
#endif

Or did I miss something at the beginning of this conversation?


[Debian is already using similar patches, which disable the 64-bit
swabbing in __STRICT_ANSI__.]

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
