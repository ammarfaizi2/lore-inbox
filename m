Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUF0PTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUF0PTm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 11:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUF0PTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 11:19:42 -0400
Received: from netrider.rowland.org ([192.131.102.5]:29959 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S263019AbUF0PTk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 11:19:40 -0400
Date: Sun, 27 Jun 2004 11:19:38 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: Andries Brouwer <aebr@win.tue.nl>, Pete Zaitcev <zaitcev@redhat.com>,
       <greg@kroah.com>, <arjanv@redhat.com>, <jgarzik@redhat.com>,
       <tburke@redhat.com>, <linux-kernel@vger.kernel.org>,
       <mdharm-usb@one-eyed-alien.net>, <david-b@pacbell.net>
Subject: Re: drivers/block/ub.c
In-Reply-To: <200406271624.18984.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0406271108190.10134-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004, Oliver Neukum wrote:

> Am Sonntag, 27. Juni 2004 16:08 schrieb Andries Brouwer:
> > On Sun, Jun 27, 2004 at 07:04:36AM +0200, Oliver Neukum wrote:
> > > > >> Yes, we have macros. Using those macros would not at all be an improvement here.
> > > > > 
> > > > > How do you arrive at that unusual conclusion?
> > > > 
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

My favorite approach has always been:

	put_be32(cmd->cdb + 2, block);

Unfortunately there is no such function or macro!  It's easy to define an
inline function that would carry out the series of four single-byte
assignments that originally started this discussion.  A more sophisticated
implementation would expand to Andries' unspeakably ugly code on
big-endian platforms that don't impose a large penalty for non-aligned
4-byte accesses.  I leave it up to others to decide which is best on
little-endian platforms that can do unaligned accesses.

I think it would be great if some such utility routine were added to a
standard header in the kernel, together with its siblings put_le32(),
put_be16(), put_le16(), and the corresponding get_xxxx() functions.

Alan Stern

