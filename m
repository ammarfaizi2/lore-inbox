Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbUDFKDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 06:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbUDFKDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 06:03:17 -0400
Received: from witte.sonytel.be ([80.88.33.193]:63437 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263745AbUDFKDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 06:03:16 -0400
Date: Tue, 6 Apr 2004 12:03:14 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: {put,get}_user() side effects
Message-ID: <Pine.GSO.4.58.0404061159330.4158@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On most (all?) architectures {get,put}_user() has side effects:

#define put_user(x,ptr)                                                 \
  __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))


E.g. drivers/char/ip2main.c seems to be completely broken due to constructs
like:

    rc = put_user(i2Input, pIndex++ );

I only noticed these because the compiler gave some warnings due to other
reasons.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
