Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbSLSWDF>; Thu, 19 Dec 2002 17:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbSLSWDF>; Thu, 19 Dec 2002 17:03:05 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:27112 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266809AbSLSWDE>;
	Thu, 19 Dec 2002 17:03:04 -0500
Date: Thu, 19 Dec 2002 22:10:43 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: bart@etpmod.phys.tue.nl, davej@codemonkey.org.uk, hpa@transmeta.com,
       terje.eggestad@scali.com, drepper@redhat.com, matti.aarnio@zmailer.org,
       hugh@veritas.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021219221043.GA18562@bjl1.asuk.net>
References: <20021219135517.7E78051FB6@gum12.etpnet.phys.tue.nl> <Pine.LNX.4.44.0212191134180.2731-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212191134180.2731-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> For _zero_ gain.  The jump to the library address has to be indirect 
> anyway, and glibc has several places to put the information without any 
> mmap's or anything like that.

This is not true, (but your overall point is still correct).

The jump to the magic page can be direct in statically linked code, or
in the executable itself.  The assembler and linker have no problem
with this, I have just tried it.

What people (not Linus) have said about static binaries is moot,
because a static binary is linked at an absolute address itself, and
so can use the standard "call relative" instruction directly to the
fixed magic page address.

Dynamic binaries or libraries can use the indirect call or relocate
the calls at load time, or if they _really_ want a magic page at a
position relative to the library, they can just _copy_ the magic page
from 0xfffe0000.  It is not all that magic.

-- Jamie
