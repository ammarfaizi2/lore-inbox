Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbTBLSnO>; Wed, 12 Feb 2003 13:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267574AbTBLSnO>; Wed, 12 Feb 2003 13:43:14 -0500
Received: from thunk.org ([140.239.227.29]:7833 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S267573AbTBLSnN>;
	Wed, 12 Feb 2003 13:43:13 -0500
Date: Wed, 12 Feb 2003 13:52:52 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: struct tty_driver
Message-ID: <20030212185252.GA16353@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <UTC200302111444.h1BEi7106413.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200302111444.h1BEi7106413.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 03:44:07PM +0100, Andries.Brouwer@cwi.nl wrote:
> Ted, I wondered:
> 
> Looking at 2.5.60 I see
> 
> struct tty_struct {
> 	int     magic;
> 	struct tty_driver driver;
> ...
> 
> and it looks like this struct tty_driver is never modified.
> Since it is rather large, why not replace it by
> 	struct tty_driver *driver;
> ?
> 
> As it is now, the initialization in init_dev() does
> 	tty->driver = *driver;
> just duplicating constant data.
> 
> Is this a historical relict, or does this duplication have a function?

Nope.  The tty->ldisc should also be made into a pointer as well.
It's a historic relict; it's been a very, very long time since there's
been any variable data in the driver or ldisc structures.  

						- Ted
