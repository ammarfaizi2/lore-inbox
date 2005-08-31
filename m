Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVHaUb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVHaUb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 16:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbVHaUb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 16:31:59 -0400
Received: from styx.suse.cz ([82.119.242.94]:22952 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964939AbVHaUb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 16:31:59 -0400
Date: Wed, 31 Aug 2005 22:32:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mark Lord <mlord@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: APs from the Kernel Summit run Linux
Message-ID: <20050831203211.GA13752@midnight.suse.cz>
References: <20050830093715.GA9781@midnight.suse.cz> <4315E0F0.6060209@pobox.com> <20050831205319.A6385@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831205319.A6385@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 08:53:19PM +0100, Russell King wrote:
> On Wed, Aug 31, 2005 at 12:55:12PM -0400, Mark Lord wrote:
> > I'll try loading the works into another ARM
> > system I have here, and see (1) if it runs as-is,
> > and (2) what the disassembly shows.
> 
> You can identify ARM code quite readily - look for a large number of
> 32-bit words naturally aligned and grouped together whose top nibble
> is 14 - ie 0xE.......
> 
> The top nibble is the conditional execution field, and 14 is "always".
 
Didn't find that. Anyway:

The firmware has four parts. Each starts at a nice round number and is 
padded to the next one with zeros.

        0x000000-0x0fffff 560 kB
        0x100000-0x15ffff 316 kB
        0x160000-0x1bffbf 331 kB
        0x1bffc0-0x1bffff  64 bytes ASCII identificatoin

Each of the first three large parts starts with this sequence of bytes:

        00 10 00 00 03 00 00 00 ED

The first and third parts contain a repeating 7-byte sequence

        81 40 20 10 08 04 02

near the beginning, while part 2 is padded with zeroes in the same
place.

There are no strings except in the last part. Most likely it's
some kind of compressed data, although the repeating parts would appear
in regular compressed blobs.

Anyone, does this ring a bell?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
