Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318249AbSHZUNH>; Mon, 26 Aug 2002 16:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSHZUNH>; Mon, 26 Aug 2002 16:13:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37893 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318249AbSHZUNG>; Mon, 26 Aug 2002 16:13:06 -0400
Date: Mon, 26 Aug 2002 21:17:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG/PATCH] : bug in tty_default_put_char()
Message-ID: <20020826211721.G4763@flint.arm.linux.org.uk>
References: <20020826180749.GA8630@bougret.hpl.hp.com> <1030388224.2797.2.camel@irongate.swansea.linux.org.uk> <20020826185930.GA8749@bougret.hpl.hp.com> <1030388847.2776.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030388847.2776.15.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Aug 26, 2002 at 08:07:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 08:07:27PM +0100, Alan Cox wrote:
> On Mon, 2002-08-26 at 19:59, Jean Tourrilhes wrote:
> > 	Just check drivers/char/n_tty.c for every occurence of
> > put_char() and be scared. The problem is to find a practical solution.
> > 	For myself, I've added some clever workaround in IrCOMM to
> > accept data before full setup.
> 
> Sure making it return the right errors doesnt fix anything, but it
> allows you to fix some of it bit by bit. 

put_char() is not allowed to fail since the caller should have already
checked for buffer space via the write_room() method.

All places look adequately protected in n_tty.c, so I'm not currently
sure how Jean's users are seeing this condition; I'd need to have a
BUG() showing the call trace of such an event happening.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

