Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbSKBUcJ>; Sat, 2 Nov 2002 15:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbSKBUcI>; Sat, 2 Nov 2002 15:32:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40617 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261403AbSKBUbR>;
	Sat, 2 Nov 2002 15:31:17 -0500
Date: Sat, 2 Nov 2002 15:37:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Matt Porter <porter@cox.net>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
In-Reply-To: <3DC3C1AA.7060602@zytor.com>
Message-ID: <Pine.GSO.4.21.0211021526320.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Nov 2002, H. Peter Anvin wrote:

> Probably not to kinit, but to early userspace, yes.  There is no real 
> reason to put everything into kinit, and a lot of these things we have 
> already written up as part of the klibc bundle.

s/probably/definitely/

There is a lot of reasons for _not_ putting everything into one binary -
if nothing else, it allows to deal with situations like
	/* do a lot of things that are OK for userland */
	/* do ugly magic */
	/* do a lot of things that are OK for userland */
without exporting ugly crap.

It's much better to have several userland helpers called from init sequence
to do sane stuff in userland and leave remaining crap where it is, than
to add user-visible interfaces that don't make sense.

