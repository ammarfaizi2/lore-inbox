Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130847AbQLEWbh>; Tue, 5 Dec 2000 17:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130877AbQLEWb2>; Tue, 5 Dec 2000 17:31:28 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:774 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130847AbQLEWbT>; Tue, 5 Dec 2000 17:31:19 -0500
Date: Tue, 5 Dec 2000 16:00:15 -0600
To: Tigran Aivazian <tigran@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test12-pre5] optimized get_empty_filp()
Message-ID: <20001205160014.G6567@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0012051754450.1493-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012051754450.1493-100000@penguin.homenet>; from tigran@veritas.com on Tue, Dec 05, 2000 at 05:57:53PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Tigran Aivazian]
> The only reason one could think of was to "hold the lock for as short
> time as possible" but a minute's thought reveals that such reason is
> invalid (i.e. one is more likely to waste time spinning on the lock
> than to save it by dropping/retaking it, given the relative duration
> of the instructions we execute there without the lock).

If there is no contention, you do not spin, no time wasted

If there *is* contention, you deserialize the routine just a little
bit, which is generally a Good Thing.

Whether a memset of 92 bytes (on 32-bit arch), plus an atomic_set(),
are worth deserializing, I do not know.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
