Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267877AbTAMREG>; Mon, 13 Jan 2003 12:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267882AbTAMREG>; Mon, 13 Jan 2003 12:04:06 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48645 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267877AbTAMREF>;
	Mon, 13 Jan 2003 12:04:05 -0500
Date: Mon, 13 Jan 2003 09:12:56 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add module reference to struct tty_driver
Message-ID: <20030113171256.GA6875@kroah.com>
References: <20030113054708.GA3604@kroah.com> <20030113092734.C12379@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113092734.C12379@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 09:27:34AM +0000, Russell King wrote:
> On Sun, Jan 12, 2003 at 09:47:09PM -0800, Greg KH wrote:
> > In digging into the tty layer locking, I noticed that the tty layer
> > doesn't handle module reference counting for any tty drivers.  Well, I've
> > known this for a long time, just finally got around to fixing it :)
> > Here's a patch against 2.5.56 that should fix this issue (works for
> > me...)
> > 
> > Comments?  If no one objects, I'll send it on to Linus, and add support
> > for this to a number of tty drivers that commonly get built as modules.
> 
> I'd just ask whether you considered what happens when:
> 
> 1. two people open the same tty
> 2. the tty is hung up
> 3. both people close the tty
> 
> (this isn't an indication that the patch is wrong, I'm just interested
> to know.)

It "should" work with the above situation, as we only decrement the
module count when the tty device structure that is bound to a driver is
freed, and increment it when it is created.  So if those functions work
properly with regards to memory management, the module reference
counting should also work.

Hm, well I hope so at least :)

Let me know if your tests show up any problems.

thanks,

gregk -h
