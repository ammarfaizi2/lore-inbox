Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284955AbRLZWHM>; Wed, 26 Dec 2001 17:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284950AbRLZWHC>; Wed, 26 Dec 2001 17:07:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26126 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284955AbRLZWGz>; Wed, 26 Dec 2001 17:06:55 -0500
Date: Wed, 26 Dec 2001 14:04:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre2 forces ramfs on
In-Reply-To: <E16JFbk-00028a-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112261402130.1791-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Dec 2001, Alan Cox wrote:
> > Because it's small, and if it wasn't there, we'd have to have the small
> > "rootfs" anyway (which basically duplicated ramfs functionality).
>
> Can ramfs=N longer term actually come back to be "use __init for the RAM
> fs functions". That would seem to address any space issues even the most
> embedded fanatic has.

Hmm.. That might work, but at the same time I suspect that the most
fanatic embedded users are actually the ones that may benefit most from
ramfs in the first place. That was certainly why it came to be..

We'll see. We'll end up using ramfs for the initial init bootup (ie the
"tar.gz->ramfs" stage of bootup), so making it __init may not be practical
for other reasons. We'd have to unload it not after the __init stage, but
after the first root filesystem is unused (which may be later, depending
on what people put in the filesystem).

		Linus

