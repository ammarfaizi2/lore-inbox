Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUI0PfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUI0PfN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUI0PfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:35:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:52436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266463AbUI0PfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:35:01 -0400
Date: Mon, 27 Sep 2004 08:34:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: TTY ldisc and termios locking work
In-Reply-To: <20040927143047.GA2921@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0409270832490.2317@ppc970.osdl.org>
References: <20040927143047.GA2921@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,
 this seems to be corrupted. A quick read-through found this in 
generic_serial.c:

+       ld = tty_ldisc_ref(tty);
+       if (ld != NULL) {
+               ld->flush_buffer)
+                       ld->flush_buffer(tty);
+               tty_ldisc_deref(ld);
+       }

I can see the missing "if (" in my mind, but I'm wondering what else I 
might have missed. Ie can we have this patch be tested a bit more first?

		Linus
