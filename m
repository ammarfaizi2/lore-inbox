Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286230AbRLJLgp>; Mon, 10 Dec 2001 06:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286233AbRLJLgg>; Mon, 10 Dec 2001 06:36:36 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47314 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286230AbRLJLgR>;
	Mon, 10 Dec 2001 06:36:17 -0500
Date: Mon, 10 Dec 2001 06:36:15 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for idiocy in mount_root cleanups.
In-Reply-To: <20011209235621.C117@elf.ucw.cz>
Message-ID: <Pine.GSO.4.21.0112100632360.12421-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Dec 2001, Pavel Machek wrote:

> [Calling sys_mount is indeed right way to do this. Ouch, and look 4
> lines above that. Do I see "mount()" without checking error return?]

Yes, you do and yes, it is the right thing.  It is called only if we know
that fs is there and the only possible error here is -ENOMEM.  And in
that case we will die since mount() attempts in the loop will also fail.
Resulting in immediate panic().  Well deserved-one, at that - if you
manage to OOM before starting init...

