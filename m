Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318272AbSHZT1P>; Mon, 26 Aug 2002 15:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSHZT1P>; Mon, 26 Aug 2002 15:27:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46596 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318272AbSHZT1N>; Mon, 26 Aug 2002 15:27:13 -0400
Date: Mon, 26 Aug 2002 20:31:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, tytso@mit.edu,
       Andrew Morton <andrewm@uow.edu.eu>, irda-users@lists.sourceforge.net
Subject: Re: [BUG/PATCH] : bug in tty_default_put_char()
Message-ID: <20020826203126.C4763@flint.arm.linux.org.uk>
References: <20020826180749.GA8630@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020826180749.GA8630@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Mon, Aug 26, 2002 at 11:07:49AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 11:07:49AM -0700, Jean Tourrilhes wrote:
> 	Bug : tty_default_put_char() doesn't check the return value of
> tty->driver.write(). However, the later may fail if buffers are full.

Hmm.

> 	Solution : It's not obvious what should be done. The attached
> patch is certainly wrong, but gives you an idea of what the problem
> is.

Every invocation of the put_char() method should be preceded by a check
to ensure that there is sufficient space in the drivers buffer (via the
drivers write_room() call.)  Could you add a BUG() on this condition
and get some call traces please?

> 	I'll try to workaround that in IrCOMM.

I don't think that should be necessary.  The tty layer is obviously
doing something it shouldn't (trying to stuff characters into a buffer
of zero size) so it should get fixed.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

