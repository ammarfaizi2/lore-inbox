Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268589AbTCCVbr>; Mon, 3 Mar 2003 16:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268619AbTCCVbr>; Mon, 3 Mar 2003 16:31:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12305 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268589AbTCCVbp>; Mon, 3 Mar 2003 16:31:45 -0500
Date: Mon, 3 Mar 2003 13:39:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Nicolas Pitre <nico@cam.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] small tty irq race fix
In-Reply-To: <Pine.LNX.4.44.0303031615020.31566-100000@xanadu.home>
Message-ID: <Pine.LNX.4.44.0303031338260.12285-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Mar 2003, Nicolas Pitre wrote:
> 
> What about this one?  It just happens that tty->read_lock is actually used
> deeper in the same call instance (in n_tty.c) so this looks to be the best
> lock to use.

Looks ok. I would suggest moving the "spin_lock_irqsave()" to outside the 
'if'-statement, though, since that should make the code a lot more 
readable, and if the lock is supposed to protect tty->flip.buf_num, then 
let's do it right and protect the read as well, no?

		Linus

