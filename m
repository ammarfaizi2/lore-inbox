Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312579AbSDYFAE>; Thu, 25 Apr 2002 01:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312917AbSDYFAD>; Thu, 25 Apr 2002 01:00:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7432 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312579AbSDYFAC>; Thu, 25 Apr 2002 01:00:02 -0400
Date: Wed, 24 Apr 2002 21:59:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Anton Blanchard <anton@samba.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc 3.1 breaks wchan
In-Reply-To: <20020425014325.GA22384@krispykreme>
Message-ID: <Pine.LNX.4.44.0204242158140.6714-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Apr 2002, Anton Blanchard wrote:
>
> I noticed on a ppc64 kernel compiled with gcc 3.1 that context_switch
> was left out of line. It ended up outside of the
> scheduling_functions_start_here/end_here placeholders which breaks
> wchan.
>
> This is one place where we require the code to be inline, so we should use
> extern.

ABSOLUTELY NOT!

"extern inline" does not guarantee inlining. It only guarantees that _if_
the code isn't inlined, it also won't be compiled as a static function.

Complain to the gcc guys, they've made up some not-backwards-compatible
thing called "always_inline" or something, apparently without any way to
know whether it is supported or not.

		Linus

