Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLSJNZ>; Tue, 19 Dec 2000 04:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLSJNP>; Tue, 19 Dec 2000 04:13:15 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:18441 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129370AbQLSJNE>; Tue, 19 Dec 2000 04:13:04 -0500
Date: Tue, 19 Dec 2000 09:42:05 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Pavel Machek <pavel@suse.cz>, Chris Lattner <sabre@nondot.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <20001219012714.B26127@athlon.random>
Message-ID: <Pine.LNX.3.96.1001219092835.20423A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2000, Andrea Arcangeli wrote:

> On Mon, Dec 18, 2000 at 10:57:44PM +0100, Mikulas Patocka wrote:
> > You have small posibility that interrupt will eat up memory - interrupt in
> > process that has PF_MEMALLOC. Patch: 
> 
> this is not the point of getblk, to fix the getblk deadlock the only way is to
> implement a fail path in each caller and allow getblk to return NULL (as every
> other memory allocation function can do).

Failing getblk would likely introduce filesystem corruption. Look at
getblk in 2.0 - when allocating new page fails it tries to reuse existing
clean buffers or wakes up bdflush and waits until it writes them. This is
the right thing to do. 

Mikulas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
