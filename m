Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264556AbTLMW2N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 17:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbTLMW2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 17:28:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:929 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264556AbTLMW2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 17:28:08 -0500
Date: Sat, 13 Dec 2003 14:28:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nicolai Lissner <nlissne@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: test11: fd0 with msdos showing garbage
In-Reply-To: <200312132302.36999.nlissne@linux01.gwdg.de>
Message-ID: <Pine.LNX.4.58.0312131420350.1855@home.osdl.org>
References: <200312132302.36999.nlissne@linux01.gwdg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Dec 2003, Nicolai Lissner wrote:
>
> While doing a BIOS-Update for my board, I have tried to read/write an
> msdos-formatted disk with kernel 2.6.0-test11. It can be mounted without
> errors - but "ls" shows only garbage. The disk is 100% ok - and can be readed
> with kernel 2.4.x without problems.
>
> I have done some more investigation with that. I can format a disk with e2fs,
> even with msdos - both *seem* to work correct - data can be stored and readed
> - but if the disk have been formatted with msdos on another system it cannot
> be readed with test11.
> So I started to do a diskimage with "dd if=/dev/fd0 of=disk.image"
> - and found some interesting differences:
> While kernel 2.4 produces a file of  1474560 bytes,
> test11 produces a file of 737280 bytes only.

Sounds like test11 mis-identified the floppy format.

> Comparing these files I found:
>
> from offset 0x00000000 to 0x000013FF  -- no difference.
> but... surprise !
> The diskimage done with kernel 2.6.0-test11 shows the directory of the disk -
> beginning at offset 0x00001400

Can you try using /dev/fd0H1440 instead of /dev/fd0?

Also, please set the FP_DEBUG flag in the floppy driver flags - something
like "floppy=debug" should do that for you. That should tell more about
the autoprobing..

		Linus
