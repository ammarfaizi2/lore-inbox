Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265704AbSJXWbm>; Thu, 24 Oct 2002 18:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265697AbSJXWbm>; Thu, 24 Oct 2002 18:31:42 -0400
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:25241 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265704AbSJXWbl>;
	Thu, 24 Oct 2002 18:31:41 -0400
Date: Thu, 24 Oct 2002 23:37:49 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Dan Maas <dmaas@maasdigital.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: sendfile(2) behaviour has changed?
Message-ID: <20021024223749.GA852@bjl1.asuk.net>
References: <20021020055020.A3289@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020055020.A3289@morpheus>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Maas wrote:
> >> It really needs a new interface for recvfile/copyfile/whatever
> >> anyway, as you can only specify an off_t for the from fd at
> >> present.
> >   
> > Ummm, you can use lseek() on the 'to' fd perhaps?
> 
> Wouldn't that be non-atomic and therefore likely to cause problems
> with concurrent writes?

sendfile() from a mapped tmpfs file is a nice way to get zero-copy
writes of program-generated data, for example HTTP headers.

If it were possible to recvfile() _to_ a tmpfs file, you could use
this to implement zero-copy forwarding between sockets, in userspace,
while still having a program inspect part of the data and possibly
change it.  There are lots of proxy services that could potentially
use this.

This is an example of when you'd want many concurrent writes to the
same file.  (Naturally, for performance, you'd want to use one large
tmpfs file and allocate portions of it on the fly, rather then
multiple opens or lots of small files).

enjoy,
-- Jamie
