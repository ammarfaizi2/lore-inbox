Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbTKFVY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 16:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTKFVY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 16:24:27 -0500
Received: from nevyn.them.org ([66.93.172.17]:2531 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263843AbTKFVYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 16:24:06 -0500
Date: Thu, 6 Nov 2003 16:24:05 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: KML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Message-ID: <20031106212405.GA1049@nevyn.them.org>
Mail-Followup-To: KML <linux-kernel@vger.kernel.org>
References: <1068140199.12287.246.camel@nosferatu.lan> <20031106093746.5cc8066e.davem@redhat.com> <1068143563.12287.264.camel@nosferatu.lan> <1068144179.12287.283.camel@nosferatu.lan> <20031106113716.7382e5d2.davem@redhat.com> <1068149368.12287.331.camel@nosferatu.lan> <20031106120548.097ccc7c.davem@redhat.com> <1068150552.12287.349.camel@nosferatu.lan> <20031106122723.5cbe1b6d.davem@redhat.com> <1068153535.12287.355.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068153535.12287.355.camel@nosferatu.lan>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 11:18:55PM +0200, Martin Schlemmer wrote:
> On Thu, 2003-11-06 at 22:27, David S. Miller wrote:
> > On Thu, 06 Nov 2003 22:29:12 +0200
> > Martin Schlemmer <azarah@gentoo.org> wrote:
> > 
> > > If you look at asm/types.h, u64 is kernel only namespace, so in
> > > theory that code will not be in userspace.
> > 
> > Replace u64 with __u64 in my examples, the point still stances.
> > 
> > 
> > > #else
> > > <code without __u64>
> > > ..
> > > #endif
> > 
> > This may not be possible.  You cannot account for every internal
> > thing that kernel header routines might need to do or work with.
> > Many structures, which the userspace can't control the layout
> > of etc., makes use of the __u64 type, and we can't just turn off
> > all those things just because -ansi was specified.
> > 
> > We're talking about things like structures that define the userspace
> > ABI into the kernel, they use things like __u64.  So what effectively
> > this means is that when you compile with -ansi you are effectively
> > turning off access to several userspace ABIs into the kernel.
> > 
> > And this isn't going to be only some obscrure feature like some
> > CDROM ioctl or whatever, things like "struct stat" use the 64-bit types
> > either directly or indirectly.
> 
> Ok - say for instance then you were to write the abi headers - how would
> you handle a case like this that -ansi forbid type long long, but it
> have to be in the struct userspace uses to pass data to the
> kernel/device ?

As someone else mentioned, you can use __extension__ if GNUC is
defined.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
