Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264059AbTFDUhA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTFDUfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:35:10 -0400
Received: from spanner.eng.cam.ac.uk ([129.169.8.9]:10740 "EHLO
	spanner.eng.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264054AbTFDUes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:34:48 -0400
Date: Wed, 4 Jun 2003 21:48:13 +0100 (BST)
From: "P. Benie" <pjb1008@eng.cam.ac.uk>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <Pine.LNX.4.44.0306041255060.15174-100000@home.transmeta.com>
Message-ID: <Pine.HPX.4.33L.0306042133330.21092-100000@punch.eng.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003, Linus Torvalds wrote:

> On Wed, 4 Jun 2003, P. Benie wrote:
> > The problem isn't to do with large writes. It's to do with any sequence of
> > writes that fills up the receive buffer, which is only 4K for N_TTY. If
> > the receiving program is suspended, the buffer will fill sooner or later.
>
> Well, even then we could just drop the "write_atomic" lock.
>
> The thing is, I don't know what the tty atomicity guarantees are. I know
> what they are for pipes (quite reasonable), but tty's?

We don't have a PIPE_BUF-style atomicity guarantee, even though this would
be quite useful. This lock is only used to prevent simultaneous writes
from being interleaved. I've always assumed that when writes shouldn't be
interleaved, but I can't quote a source for that.

Peter

