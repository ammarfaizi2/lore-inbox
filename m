Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319285AbSHGTgw>; Wed, 7 Aug 2002 15:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319286AbSHGTgw>; Wed, 7 Aug 2002 15:36:52 -0400
Received: from 12-235-88-76.client.attbi.com ([12.235.88.76]:57613 "EHLO
	mail.wine.dyndns.org") by vger.kernel.org with ESMTP
	id <S319285AbSHGTgu>; Wed, 7 Aug 2002 15:36:50 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, mingo@elte.hu,
       <linux-kernel@vger.kernel.org>, <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.30-A1
References: <Pine.LNX.4.44.0208071149030.5194-100000@home.transmeta.com>
From: Alexandre Julliard <julliard@winehq.com>
Date: 07 Aug 2002 12:40:04 -0700
In-Reply-To: <Pine.LNX.4.44.0208071149030.5194-100000@home.transmeta.com>
Message-ID: <87sn1qlap7.fsf@mail.wine.dyndns.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> Ok, sounds like that one ends up having to be a fixed segment (I wonder if
> Wine can take advantage of it? looks like it is hardcoded to base 0x400,
> which is probably fine for Wine anyway - just map something at the right
> address - but it looks CPL0 only? Might be ok to just make it available to
> user space).

Base 0x400 should work just fine for Wine, we already need to have the
BIOS data mapped there anyway, so simply making the selector available
to user space would work completely transparently for us. We are
currently trapping and emulating accesses to that selector so it
doesn't matter much whether it is protected or not, except for a small
performance gain. What would break Wine is if that selector was made
accessible to user space with a different base address, so this should
be avoided.

-- 
Alexandre Julliard
julliard@winehq.com
