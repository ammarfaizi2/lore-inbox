Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266082AbUALIhQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 03:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266084AbUALIhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 03:37:16 -0500
Received: from mail1.kontent.de ([81.88.34.36]:52876 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266082AbUALIhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 03:37:12 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: USB hangs
Date: Mon, 12 Jan 2004 09:37:19 +0100
User-Agent: KMail/1.5.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <40021E8E.3010709@pacbell.net> <20040112073905.GA8580@one-eyed-alien.net>
In-Reply-To: <20040112073905.GA8580@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401120937.19131.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 12. Januar 2004 08:39 schrieb Matthew Dharm:
> On Sun, Jan 11, 2004 at 08:11:58PM -0800, David Brownell wrote:
> > 
> > >>>	 Plus I'd
> > >>>argue PF_MEMALLOC is a better solution anyway.
> > >>
> > >>It certainly seems like a more comprehensive fix for that
> > >>particular class of problems!  :)
> > >
> > >
> > >Is it really more comprehensive?  As I see it, it will only affect code
> > >executed in the context of the usb-storage thread.  But, what about code
> > >which is invoked in tasklets or other contexts?
> > 
> > Isn't it true that only that thread is allowed to
> > submit usb-storage i/o requests?
> 
> That's very true.
> 
> What I'm concerned about is the downstream effects of a usb_submit_urb() or
> the corresponding scatter-gather equivalents.

In 2.4 they all run in interrupt or thread context IIRC.
Problematic is the SCSI error handling thread. It can call usb_reset_device()
which calls down and does allocations.
Does that thread also do the PF_MEMALLOC trick?

	Regards
		Oliver


