Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbTDUXhc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTDUXhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:37:32 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:41478 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S262728AbTDUXhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:37:31 -0400
Date: Tue, 22 Apr 2003 01:49:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, <Andries.Brouwer@cwi.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new system call mknod64
In-Reply-To: <Pine.LNX.4.44.0304211117260.3101-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304220057080.5042-100000@serv>
References: <Pine.LNX.4.44.0304211117260.3101-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 21 Apr 2003, Linus Torvalds wrote:

> > Not anymore for blockdevices.  And now that Al's back not anymore soon
> > for charater devices, too :)
> 
> Actually, we still do it for both block _and_ character devices.
> 
> Look at "nfs*xdr.c" to see what's up.

This is actually a good example to show how problematic the major/minor 
split is. It depends very much on the nfs server which bits you actually 
get back and it requires some guessing from the client side which bits it 
can use. A linux-2.2 server will happilly truncate that value to 16 bit, 
BSD will give you a 8:24 value back.
It's very unlikely that you can use a 64bit dev_t reliably with nfs in the 
foreseeable future.

bye, Roman


