Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTFDXgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTFDXgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:36:15 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:47759 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264305AbTFDXgN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:36:13 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 4 Jun 2003 16:47:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Russell King <rmk@arm.linux.org.uk>
cc: "P. Benie" <pjb1008@eng.cam.ac.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <20030605004246.H22460@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.55.0306041645060.3655@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0306041050250.14593-100000@home.transmeta.com>
 <Pine.HPX.4.33L.0306041937290.18475-100000@punch.eng.cam.ac.uk>
 <20030605004246.H22460@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jun 2003, Russell King wrote:

> On Wed, Jun 04, 2003 at 08:46:51PM +0100, P. Benie wrote:
> > The problem isn't to do with large writes. It's to do with any sequence of
> > writes that fills up the receive buffer, which is only 4K for N_TTY. If
> > the receiving program is suspended, the buffer will fill sooner or later.
>
> If the tty drivers buffer fills, we don't sleep in tty->driver->write,
> but we return zero instead.  If we are in non-blocking mode, and we
> haven't written any characters, we return -EAGAIN.  If we have, we
> return the number of characters which the tty driver accepted.
>
> However, the problem you are referring to is what happens if you have
> a blocking process blocked in write_chan() in n_tty.c, and we have
> a non-blocking process trying to write to the same tty.
>
> Reading POSIX, it doesn't seem to be clear about our area of interest,
> and I'd even say that it seems to be unspecified.

Given that a problem exist for certain apps, and given that the proposed
fix will *at least* have existing apps to behave funny, couldn't this
implemented as a feature of the fd (default off).
Something like O_REALLYNONBLOCK :)



- Davide

