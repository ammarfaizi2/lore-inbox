Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312076AbSDSXmV>; Fri, 19 Apr 2002 19:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313102AbSDSXmU>; Fri, 19 Apr 2002 19:42:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32786 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312076AbSDSXmT>; Fri, 19 Apr 2002 19:42:19 -0400
Date: Fri, 19 Apr 2002 16:41:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, <andrea@suse.de>, <ak@suse.de>,
        <linux-kernel@vger.kernel.org>, <jh@suse.cz>
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <3CC0A447.8020906@didntduck.org>
Message-ID: <Pine.LNX.4.44.0204191637570.20973-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Apr 2002, Brian Gerst wrote:
>
> Here's a patch to do just that.  It initializes the saved state in the
> task struct and falls through to restore_fpu().

One issue is whether we _can_ restore a "generated" image like this: it's
entirely possible that Intel might save away internal CPU shadow data in
the save-state structure, and future CPU's might be unhappy about loading
data that doesn't conform to what the CPU would save.

That said, the same issue is certainly true for just doing "xorps", since
that will not clear any potential future CPU state.

I get this feeling that Intel screwed up on specifying how to initialize
this whole state.

		Linus

