Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312972AbSDTR1z>; Sat, 20 Apr 2002 13:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314664AbSDTR1y>; Sat, 20 Apr 2002 13:27:54 -0400
Received: from [195.223.140.120] ([195.223.140.120]:59742 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312972AbSDTR1x>; Sat, 20 Apr 2002 13:27:53 -0400
Date: Sat, 20 Apr 2002 19:27:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        ak@suse.de, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
Message-ID: <20020420192729.I1291@dualathlon.random>
In-Reply-To: <20020420070713.H1291@dualathlon.random> <Pine.LNX.4.33.0204200919080.11450-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 09:27:11AM -0700, Linus Torvalds wrote:
> If Intel makes the SSE3 registers twice as wide (or creates new ones), the 
> xorps trick simply will not work.

Then the thing is different, I expected SSE3 not to mess the xmm layout.
If you just know SSE3 would break with the xorps the fxrestor way is
better. Anyways the problems I have about the implementation remains
(memset and duplicate efforts with ptrace in creating the empty fpu
state).

If they tell you the xmm registers won't change with SSE3 instead I
still prefer the xorps, that's 3bytes x 8 registers = 24 bytes of
icachce, compared to throwing away 512bytes/32 = 16 dcache cachelines so
it should be significantly faster.

Andrea
