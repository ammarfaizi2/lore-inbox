Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUF0PXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUF0PXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 11:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUF0PXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 11:23:30 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:61195 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263095AbUF0PX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 11:23:26 -0400
Date: Sun, 27 Jun 2004 17:23:21 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Oliver Neukum <oliver@neukum.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Pete Zaitcev <zaitcev@redhat.com>,
       greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-ID: <20040627152321.GH5526@pclin040.win.tue.nl>
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406270704.36063.oliver@neukum.org> <20040627140847.GG5526@pclin040.win.tue.nl> <200406271624.18984.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200406271624.18984.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 04:24:18PM +0200, Oliver Neukum wrote:

> > > > The above writes clearly and simply what one wants.
> > > > I expect that you propose writing
> > > > 
> > > >         *((u32 *)(cmd->cdb + 2)) = cpu_to_be32(block);
> > > > 
> > > > or some similar unspeakable ugliness.
> > > > If you had something else in mind, please reveal what.
> > > 
> > > That "ugliness" has the unspeakable advantage of producing sane code
> > > on big endian architectures.
> > 
> > I am not so sure. It tells the compiler to do a 4-byte access
> > on an address that possibly is not 4-byte aligned.
> 
> We also have the unaligned family of macro. Probably the cleanest
> solution would be a union to do away with the ugly casts that would
> be needed.

You see what is happening. Pete writes simple straightforward correct
code.  You want to replace it by ugly code that is perhaps not 100%
correct.  Then the ugliness spreads - not only a local cast, but
globally the data structures must be adapted. And would it help? What
padding do you get in that union? Do the details depend on the gcc
version? On the compilation flags?

Always write simple direct obvious code. Avoid all casts.
Uglifying code burdens maintenance. It endangers correctness.
It is reasonable only when efficiency is really important,
when every nanosecond counts (and the ugly code is really faster).
That is not the case here.


Andries

