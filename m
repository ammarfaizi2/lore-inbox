Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263283AbSJaS65>; Thu, 31 Oct 2002 13:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265225AbSJaS65>; Thu, 31 Oct 2002 13:58:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14605 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263283AbSJaS6y>; Thu, 31 Oct 2002 13:58:54 -0500
Date: Thu, 31 Oct 2002 11:04:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: RE: [PATCH] fixes for building kernel 2.5.45 using Intel compiler
In-Reply-To: <1036091617.8852.108.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0210311100470.1526-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 31 Oct 2002, Alan Cox wrote:
> 
> The compiler at function entry cannot know anything about the scope of 
> objects above the return address. It could equally be a valid pointer to
> data above the stack with a global context created by a thread library.
> 
> I'm curious if the optimisation is actually legal

The optimization is not legal or illegal per se, the only thing that can
make it legal or illegal is a defined calling convention. The calling
convention can say who the "owner" of the arguments is: the caller or the
callee.

The kernel doesn't have a well-enough-defined calling convention to be
able to make a good judgement. We tend to use the same calling convention
as the native compiler in user space does, but even that's not always true
(ie it can be modified by things like -mregparm etc, on a per-architecture
basis).

I don't think the original iBCS2 calling convention (that Linux uses on
x86) is specific on this issue. That would be the thing that would decide
the legality of the optimization, I think.

Considering that Intel largely wrote iBCS2, I guess some Intel person can 
know what the standard was ;)

		Linus

