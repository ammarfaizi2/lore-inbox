Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTFDXvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTFDXvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:51:25 -0400
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:3089
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id S264308AbTFDXvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:51:24 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33EBD@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Davide Libenzi'" <davidel@xmailserver.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [2.5] Non-blocking write can block
Date: Wed, 4 Jun 2003 17:04:46 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, June 04, 2003 at 4:47 PM, Davide Libenzi wrote:
> 
> On Thu, 5 Jun 2003, Russell King wrote:
> 
> > On Wed, Jun 04, 2003 at 08:46:51PM +0100, P. Benie wrote:
> > > The problem isn't to do with large writes. It's to do 
> with any sequence of
> > > writes that fills up the receive buffer, which is only 4K 
> for N_TTY. If
> > > the receiving program is suspended, the buffer will fill 
> sooner or later.
> >
> > If the tty drivers buffer fills, we don't sleep in 
> tty->driver->write,
> > but we return zero instead.  If we are in non-blocking mode, and we
> > haven't written any characters, we return -EAGAIN.  If we have, we
> > return the number of characters which the tty driver accepted.
> >
> > However, the problem you are referring to is what happens 
> if you have
> > a blocking process blocked in write_chan() in n_tty.c, and we have
> > a non-blocking process trying to write to the same tty.
> >
> > Reading POSIX, it doesn't seem to be clear about our area 
> of interest,
> > and I'd even say that it seems to be unspecified.
> 
> Given that a problem exist for certain apps, and given that 
> the proposed
> fix will *at least* have existing apps to behave funny, couldn't this
> implemented as a feature of the fd (default off).
> Something like O_REALLYNONBLOCK :)
> 

Davide,

Do you mean something like the separate O_NDELAY flag under Solar*s? IIRC
they also use return code EWOULDBLOCK to differentiate the "could not get
resource" cases from the "no room for more data" cases when O_NONBLOCK is
used.

Cheers,
Ed
