Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275126AbRKMP5m>; Tue, 13 Nov 2001 10:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRKMP50>; Tue, 13 Nov 2001 10:57:26 -0500
Received: from [195.63.194.11] ([195.63.194.11]:48656 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S273902AbRKMP4n>; Tue, 13 Nov 2001 10:56:43 -0500
Message-ID: <3BF14F14.21D66343@evision-ventures.com>
Date: Tue, 13 Nov 2001 17:49:24 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Merge BUG in 2.4.15-pre4 serial.c
In-Reply-To: <E161TWH-0004G9-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found the following code in serial.c aorund line 5565

#ifdef __i386__
	if (i == NR_PORTS) {
		for (i = 4; i < NR_PORTS; i++)
			if ((rs_table[i].type == PORT_UNKNOWN) &&
			    (rs_table[i].count == 0))
				break;
	}
#endif
	if (i == NR_PORTS) {
		for (i = 0; i < NR_PORTS; i++)
			if ((rs_table[i].type == PORT_UNKNOWN) &&
			    (rs_table[i].count == 0))
				break;
	}

This is supposedly the result of applying some patch twice.
Let me guess the first 8 lines of this can be deleted.

Regards!
