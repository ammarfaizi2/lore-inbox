Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262756AbSJCGtU>; Thu, 3 Oct 2002 02:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262757AbSJCGtU>; Thu, 3 Oct 2002 02:49:20 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:35851 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262756AbSJCGtU>;
	Thu, 3 Oct 2002 02:49:20 -0400
Date: Wed, 2 Oct 2002 23:52:09 -0700
From: Greg KH <greg@kroah.com>
To: Martin Diehl <lists@mdiehl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: calling context when writing to tty_driver
Message-ID: <20021003065209.GA18481@kroah.com>
References: <20021001183400.GA8959@kroah.com> <Pine.LNX.4.21.0210012150300.485-100000@notebook.diehl.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0210012150300.485-100000@notebook.diehl.home>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 11:10:34PM +0200, Martin Diehl wrote:
> 
> Another question/suggestion: do we need to acquire port->sem in usbserial?
> Couldn't this be done with a spinlock - at least when called from_user?

It used to be a spinlock, but too many drivers did bad things with the
spinlock held, so I changed it to a semaphore so they could sleep while
it is held.  I think in 2.5, all of the nasty drivers can be easily
fixed (the usb core now can be told not to sleep when submitting an
urb), so this might be able to be changed back to a spinlock.

> If we agree serial drivers shouldn't sleep in write_room()/write() my
> impression is this needs to be addressed somehow, regardless whether
> usbserial uses the new serial core or not. Anybody tried this with a
> bluetooth dongle over usbserial?

I don't know, do we agree that you can't sleep in those functions?  If
so, I'll look into fixing the usbserial drivers up.

thanks,

greg k-h
