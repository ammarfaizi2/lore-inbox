Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315315AbSDWTWJ>; Tue, 23 Apr 2002 15:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315316AbSDWTWI>; Tue, 23 Apr 2002 15:22:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1810 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315315AbSDWTWI>; Tue, 23 Apr 2002 15:22:08 -0400
Date: Tue, 23 Apr 2002 12:21:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <ak@suse.de>, <linux-kernel@vger.kernel.org>, <jh@suse.cz>
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <20020420201205.M1291@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0204231218540.19326-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Apr 2002, Andrea Arcangeli wrote:
>
> I mean, if they change the registers layout, and so if they require a
> different empty FPU state, they must as well add yet another bitflag to
> enable SSE3, if they don't the chip isn't backwards compatible.

I have unofficial confirmation from Intel that the way to architecturally
initialize the FPU state is indeed something like

        memset(&fxsave, 0, sizeof(struct i387_fxsave_struct));
        fxsave.cwd = 0x37f;
        fxsave.mxcsr = 0x1f80;
        fxrstor(&fxsave);

and the person in question is trying to make sure this is documented so
that we won't be bitten by this in the future.

			Linus

