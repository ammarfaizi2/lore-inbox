Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131613AbRACPDX>; Wed, 3 Jan 2001 10:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131135AbRACPDN>; Wed, 3 Jan 2001 10:03:13 -0500
Received: from hera.cwi.nl ([192.16.191.1]:7119 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131501AbRACPDG>;
	Wed, 3 Jan 2001 10:03:06 -0500
Date: Wed, 3 Jan 2001 15:32:38 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101031432.PAA136866.aeb@texel.cwi.nl>
To: linux-kernel@vger.kernel.org, sfr@gmx.net
Subject: Re: Timeout: AT keyboard not present?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Jan  2 21:20:33 asterix kernel: keyboard: unknown scancode e0 12
	Jan  2 21:20:33 asterix kernel: keyboard: unknown scancode e0 71
	Jan  2 21:20:33 asterix kernel: keyboard: unknown scancode e0 70
	Jan  2 21:20:33 asterix kernel: keyboard: unrecognized scancode (71) - ignored
	Jan  2 21:20:33 asterix kernel: keyboard: unknown scancode e0 70
	Jan  2 21:20:34 asterix kernel: keyboard: unrecognized scancode (70) - ignored
	Jan  2 21:20:47 asterix last message repeated 13 times

This sounds very much as if you got your keyboard into scancode mode 1.

(Ordinarily a key-up event gets scancode of key-down but with
high-order bit set. In scancode set 1, a key-up event get the
scancode of key-down prefixed by 0xf0. Since the high-order bit
is masked here, this 0xf0 would show up as 0x70.
Moreover, the key-up for a sequence like e0 71 is e0 f0 71,
again what you see here.)

How you got into scancode mode 1 I don't know
(maybe by sending the command f0 01 to the keyboard).
Do things improve if you rip this strange messy AUX_RECONNECT
stuff out of drivers/char/pc_keyb.c?

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
