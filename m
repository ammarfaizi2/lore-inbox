Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314496AbSDXAdW>; Tue, 23 Apr 2002 20:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314499AbSDXAdV>; Tue, 23 Apr 2002 20:33:21 -0400
Received: from [195.223.140.120] ([195.223.140.120]:48392 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314496AbSDXAdT>; Tue, 23 Apr 2002 20:33:19 -0400
Date: Wed, 24 Apr 2002 02:32:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        ak@suse.de, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
Message-ID: <20020424023249.B2756@dualathlon.random>
In-Reply-To: <20020420201205.M1291@dualathlon.random> <Pine.LNX.4.44.0204231218540.19326-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 12:21:29PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 20 Apr 2002, Andrea Arcangeli wrote:
> >
> > I mean, if they change the registers layout, and so if they require a
> > different empty FPU state, they must as well add yet another bitflag to
> > enable SSE3, if they don't the chip isn't backwards compatible.
> 
> I have unofficial confirmation from Intel that the way to architecturally
> initialize the FPU state is indeed something like
> 
>         memset(&fxsave, 0, sizeof(struct i387_fxsave_struct));
>         fxsave.cwd = 0x37f;
>         fxsave.mxcsr = 0x1f80;
>         fxrstor(&fxsave);
> 
> and the person in question is trying to make sure this is documented so
> that we won't be bitten by this in the future.

Ok, thanks for the info. The advantage (now that it is documented! :) is
that they can add the xmm8-15 reigsters of x86-64 to x86 too without
requiring any change to linux. On the linux side we obviously don't care
if they document it retroactive as an errata of sse docs, so for us it
doesn't matter even if they don't add an additional bitflag before
adding the xmm8-15 registers.  Basically they should only deal with the
other operative systems now.

Andrea
