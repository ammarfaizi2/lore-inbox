Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTKFUcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 15:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTKFUcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 15:32:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51113 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263740AbTKFUck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 15:32:40 -0500
Date: Thu, 6 Nov 2003 12:27:23 -0800
From: "David S. Miller" <davem@redhat.com>
To: azarah@gentoo.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
Message-Id: <20031106122723.5cbe1b6d.davem@redhat.com>
In-Reply-To: <1068150552.12287.349.camel@nosferatu.lan>
References: <1068140199.12287.246.camel@nosferatu.lan>
	<20031106093746.5cc8066e.davem@redhat.com>
	<1068143563.12287.264.camel@nosferatu.lan>
	<1068144179.12287.283.camel@nosferatu.lan>
	<20031106113716.7382e5d2.davem@redhat.com>
	<1068149368.12287.331.camel@nosferatu.lan>
	<20031106120548.097ccc7c.davem@redhat.com>
	<1068150552.12287.349.camel@nosferatu.lan>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Nov 2003 22:29:12 +0200
Martin Schlemmer <azarah@gentoo.org> wrote:

> If you look at asm/types.h, u64 is kernel only namespace, so in
> theory that code will not be in userspace.

Replace u64 with __u64 in my examples, the point still stances.


> #else
> <code without __u64>
> ..
> #endif

This may not be possible.  You cannot account for every internal
thing that kernel header routines might need to do or work with.
Many structures, which the userspace can't control the layout
of etc., makes use of the __u64 type, and we can't just turn off
all those things just because -ansi was specified.

We're talking about things like structures that define the userspace
ABI into the kernel, they use things like __u64.  So what effectively
this means is that when you compile with -ansi you are effectively
turning off access to several userspace ABIs into the kernel.

And this isn't going to be only some obscrure feature like some
CDROM ioctl or whatever, things like "struct stat" use the 64-bit types
either directly or indirectly.
