Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268957AbRHNV0d>; Tue, 14 Aug 2001 17:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270652AbRHNV0X>; Tue, 14 Aug 2001 17:26:23 -0400
Received: from hera.cwi.nl ([192.16.191.8]:2805 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268957AbRHNV0K>;
	Tue, 14 Aug 2001 17:26:10 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 14 Aug 2001 21:26:22 GMT
Message-Id: <200108142126.VAA107411@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, Gunther.Mayer@t-online.de
Subject: Re: [PATCH] make psaux reconnect adjustable
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> PS/2 mouse protocol was designed to easily re-synchronize

Not very easily. The Microsoft protocol synchronizes after
a single packet, but the PS/2 protocol has packets of three
bytes, two of which have completely arbitrary contents,
while the first byte has arbitrary contents except that
bit 3 is always set. No doubt it takes only a few packets
to resynchronize in practice, but in theory one could have
arbitrarily long strings of ..., 8, 8, 8, 8, 8, 12, 8, 8, 8, ...
and nobody knows whether the 12 was a mouse button.

> _This_ shows, user-mode must be notified of the re-connect!

Yes, we agree completely: this AUX_RECONNECT stuff should
be ripped out of the kernel, no sysctl, no ioctl, no boot param,
just out. Now gpm can handle the sequence AA 00 as it sees fit,
possibly by reinitializing the mouse, and if X gets its mouse
events via gpm it doesnt need the same code itself.

Andries
