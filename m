Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317918AbSFSQFW>; Wed, 19 Jun 2002 12:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317919AbSFSQFV>; Wed, 19 Jun 2002 12:05:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38672 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317918AbSFSQFU>; Wed, 19 Jun 2002 12:05:20 -0400
Date: Wed, 19 Jun 2002 09:05:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andries.Brouwer@cwi.nl, Alexander Viro <viro@math.psu.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH+discussion] symlink recursion
In-Reply-To: <E17KghU-0000oC-00@starship>
Message-ID: <Pine.LNX.4.44.0206190900560.2053-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Jun 2002, Daniel Phillips wrote:
>
> It's the recursive trip through the filesystem that causes the problem.

Actually, the trip to the filesystem itself is not recursive. We only have
one lookup _active_ at a time, so the stack depth is fairly well bounded.
I think at some point it was on the order of 64 bytes per invocation on
x86. It really isn't as bad as people have made it out to be.

(But yes, the x86 is denser on the stack than many architectures)

Note that I'm absolutely not adverse to have people test Andries patch,
and I don't _mind_ it. I'm really arguing not so much against the patch
itself, as against the _religious_ and unthinking reaction against a
perfectly fine programming construct (limited recursion).

		Linus

PS. Yes, a filesystem can do stupid things, and make the actual single
level function have a huge stack-frame: the example was for the normal
"page_symlink" thing.

