Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280531AbRKSSS0>; Mon, 19 Nov 2001 13:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRKSSSR>; Mon, 19 Nov 2001 13:18:17 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:46211 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S280531AbRKSSSE>;
	Mon, 19 Nov 2001 13:18:04 -0500
Date: Mon, 19 Nov 2001 10:18:03 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
Message-ID: <20011119101803.A25117@netnation.com>
In-Reply-To: <200111141243.fAEChS915731@neosilicon.transmeta.com> <Pine.LNX.4.33.0111140821120.17217-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111140821120.17217-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 08:34:12AM -0800, Linus Torvalds wrote:

> That's normal and usually good. It's supposed to swap stuff out if it
> really isn't needed, and that improves performance. Cache _is_ more
> important than swap if the cache is active.

We have to remember that swap can be much slower to read back in than
rereading data from files, though.  I guess this is because files tend to
be more often read sequentially.  A freshly-booted box loads up things it
hasn't seen before much faster than a heavily-swapped-out box swaps the
things it needs back in...window managers and X desktop backgrounds, for
example, are awfully slow.  I would prefer if it never swapped them out.

This is an annoying situation, though, because I would like some of my
unused daemons to be swapped out.  mlocking random stuff would be worse,
though.

> HOWEVER, there's probably something in your system that triggers this too
> easily. Heavy NFS usage will do that, for example - as mentioned in
> another thread on linux-kernel, the VM doesn't really understand
> writebacks and asynchronous reads from filesystems that don't use buffers,
> and so sometimes the heuristics get confused simply because NFS activity
> can _look_ like page mapping to the VM.

I've been copying about 40 GB of stuff back and forth over NFS over
switched 100Mbit Ethernet lately, so I can say I'm definitely seeing
this. :)  It also seems to happen when I "pull" over NFS rather than
"push" (eg: I ssh to a remote machine and "cp" with the source being an
NFS mount of the local machine)...the 2.4.15pre1 local machine tends to
swap out while this happens as well.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
