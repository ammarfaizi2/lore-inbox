Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbSAZBV1>; Fri, 25 Jan 2002 20:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbSAZBVR>; Fri, 25 Jan 2002 20:21:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30469 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281916AbSAZBVG>; Fri, 25 Jan 2002 20:21:06 -0500
Date: Fri, 25 Jan 2002 17:20:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] syscall latency improvement #1
In-Reply-To: <3C51FF0C.D3B1E2F7@zip.com.au>
Message-ID: <Pine.LNX.4.33.0201251714270.16872-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Jan 2002, Andrew Morton wrote:
> >
> > Looking at the code, I suspect that 99.9% of this "improvement" comes from
> > one thing, and one thing only: you removed the "cli" in the system call
> > return path.
>
> Before the cli was in the stock kernel, I had added it in the
> low-latency patch.  Careful testing showed that it added
> 13 machine cycles to a system call on a P3.

That sounds about right. The empty system call path is basically dominated
by the trap/iret costs, and is on the order of 200 cycles or so on most
CPU's. So 13 cycles would account for the roughly 5% improvement.

		Linus

