Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLGWvH>; Thu, 7 Dec 2000 17:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129465AbQLGWur>; Thu, 7 Dec 2000 17:50:47 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15635 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129319AbQLGWuh>; Thu, 7 Dec 2000 17:50:37 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: kernel BUG at buffer.c:827! and scsi modules no load at boot w/ initrd - 
 test12pre7
Date: 7 Dec 2000 14:19:40 -0800
Organization: Transmeta Corporation
Message-ID: <90p2ds$2hs$1@penguin.transmeta.com>
In-Reply-To: <3A2FF076.946076FC@haque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A2FF076.946076FC@haque.net>,
Mohammad A. Haque <mhaque@haque.net> wrote:
>
>I'm getting a BUG at boot in buffer.c:827. Oops/ksymoops at teh end of
>this message. I also noticed that the driver for my scsi card isn't
>loading at boot if compiled as a module using initrd. This is what I get
>during the boot process. 

This is a new BUG-check, where "UnlockPage()" actually verifies that the
page was locked before it unlocks it.

Trying to unlock a page that isn't locked is a nasty bug - if it happens
it probably also means that with some bad luck that unlock could have
unlocked the page that somebody _else_ had locked, and expected to stay
locked until it was unlocked properly.

(It may also be that the BUG() is due to exactly that - somebody else
who didn't have the lock unlocked the page from under you, and the
_proper_ unlocker will in that case be the one that oopses).

Do you have something special that triggers this? Can you test if it
only happens with initrd, for example?

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
