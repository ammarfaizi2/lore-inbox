Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285507AbRLNUtu>; Fri, 14 Dec 2001 15:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285501AbRLNUtk>; Fri, 14 Dec 2001 15:49:40 -0500
Received: from peace.netnation.com ([204.174.223.2]:39076 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S285507AbRLNUt0>; Fri, 14 Dec 2001 15:49:26 -0500
Date: Fri, 14 Dec 2001 12:49:25 -0800
From: Simon Kirby <sim@netnation.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill(-1,sig)
Message-ID: <20011214124925.A18819@netnation.com>
In-Reply-To: <20011214123628.A22506@netnation.com> <Pine.LNX.4.33.0112141237470.3063-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.33.0112141237470.3063-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 14, 2001 at 12:40:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 12:40:16PM -0800, Linus Torvalds wrote:

> I do agree, I've used "kill -9 -1" myself.
> 
> However, let's see how problematic it is to try to follow it (in 2.5.x,
> not 2.4.x) and if people really complain.

Doesn't init use kill -15 -1, kill -9 -1, etc., to terminate all
processes?  Hmm.  Yes, it does, but the kernel checks for (pid > 1).

By removing the single compare in the kernel, we're potentially
increasing the size of userspace applications from a single syscall to a
whole walking of /proc just to kill other running processes.  Ugh.

"kill -STOP -1" is also great for freezing forkbombs which would no
longer possible with the /proc method.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
