Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318224AbSHZSzQ>; Mon, 26 Aug 2002 14:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318225AbSHZSzQ>; Mon, 26 Aug 2002 14:55:16 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:18884 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318224AbSHZSzO>;
	Mon, 26 Aug 2002 14:55:14 -0400
Date: Mon, 26 Aug 2002 11:59:30 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG/PATCH] : bug in tty_default_put_char()
Message-ID: <20020826185930.GA8749@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020826180749.GA8630@bougret.hpl.hp.com> <1030388224.2797.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030388224.2797.2.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 07:57:04PM +0100, Alan Cox wrote:
> On Mon, 2002-08-26 at 19:07, Jean Tourrilhes wrote:
> > 	Hi,
> > 
> > 	Bug : tty_default_put_char() doesn't check the return value of
> > tty->driver.write(). However, the later may fail if buffers are full.
> > 
> > 	Solution : It's not obvious what should be done. The attached
> > patch is certainly wrong, but gives you an idea of what the problem
> > is.
> 
> Make it an int and return the tty->driver.write value. We know that
> since its void nobody is currently checking the error code, and now they
> can where it matters

	Just check drivers/char/n_tty.c for every occurence of
put_char() and be scared. The problem is to find a practical solution.
	For myself, I've added some clever workaround in IrCOMM to
accept data before full setup.

	Regards,

	Jean
