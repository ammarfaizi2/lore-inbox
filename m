Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUAKA3I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 19:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbUAKA3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 19:29:08 -0500
Received: from hera.cwi.nl ([192.16.191.8]:51174 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265502AbUAKA3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 19:29:05 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 11 Jan 2004 01:28:51 +0100 (MET)
Message-Id: <UTC200401110028.i0B0SpL08329.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, sven.kissner@consistencies.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: with 2.6.x:
: Loading /etc/console/boottime.kmap.gz
: KDSKBENT: Invalid argument
: failed to bind key 265 to value 638

You must be using a non-standard loadkeys, or an old loadkeys
compiled against new kernel headers.

The 2.6 situation is broken in several respects and one of
the bugs is a NR_KEYS that is 512, which the keys involved
are unsigned characters and cannot be larger than 255.

My opinion is that NR_KEYS must be decreased to 256, and maybe
I have seen patches by Vojtech somewhere that already did this,
but looking at current bk source it seems that they have not been
applied yet.

Anyway, I released kbd-1.10 last week or so, and it ignores the
kernel NR_KEYS but tries to adapt dynamically to the kernel.
It would not come with this error message, I suppose.

: with 2.4.20 & 2.4.22-ck2 the value is increasing from 128 to 511

: failed to bind key 128 to value 512

2.4 has NR_KEYS equal to 128, so key 128 and higher do not exist.

So, so far all is well understood.

: atkbd.c: Unknown key pressed (translated set 2, code 0x91 on isa0060/serio0)
: atkbd.c: Unknown key released (translated set 2, code 0x91 on isa0060/serio0)
: atkbd.c: Unknown key pressed (translated set 2, code 0x92 on isa0060/serio0)
: atkbd.c: Unknown key released (translated set 2, code 0x92 on isa0060/serio0)

This is something different, a key without associated keycode.
That is normal. If it really has high bit set it is a bit unusual.
(What does showkey -s show?)

Maybe you can make this addressable using setkeycodes.

Andries
