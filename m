Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267968AbUJHG2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267968AbUJHG2k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 02:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUJHG2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 02:28:40 -0400
Received: from [69.25.196.29] ([69.25.196.29]:26780 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267968AbUJHG2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 02:28:38 -0400
Date: Fri, 8 Oct 2004 02:26:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] TTY flip buffer SMP changes
Message-ID: <20041008062650.GC2745@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Fulghum <paulkf@microgate.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097179099.1519.17.camel@deimos.microgate.com> <1097177830.31768.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097177830.31768.129.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 08:37:12PM +0100, Alan Cox wrote:
> 
> Now that networking is not a kernel option it seems slightly dumb that
> the tty layer doesn't just use the sk_buff model (probably not code).
> kmalloc is very fast and it kills TTY_DONT_FLIP because every buffer is
> owned by _one_ person at a time. (sk_buff's dont direclty fit too well
> because we push both error and bits per byte and don't last time I
> checked support recycling).

Suggestion: use two skbuff's for the data bytes and the error flags,
and make the error skbufs be optional --- sometimes the line discpline
won't care about the error bytes at all (example: raw mode).

Even if kmalloc() isn't as fast using two ring buffers which we flip
back and forth, CPU's have gotten a lot faster since when I
implemented the flip buffers some 12 years ago (i.e., 8 Moore law's
doublings ago).  If you nuke flip buffers, I'm not going to take it
personally.  :-)

> Another nice effect is simplifying the ldisc and driver level locking.
> Drivers queue buffers, ldiscs eat buffers. If the driver queues a buffer
> and there is temporarily no ldisc it does not get lost. 

Agreed.

						- Ted
