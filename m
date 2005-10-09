Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVJIACF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVJIACF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 20:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVJIACF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 20:02:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8714 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932186AbVJIACE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 20:02:04 -0400
Date: Sun, 9 Oct 2005 01:01:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, akpm@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] new serial flow control
Message-ID: <20051009000153.GA23083@flint.arm.linux.org.uk>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk> <20051008222711.GA5150@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051008222711.GA5150@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 12:27:11AM +0200, Samuel Thibault wrote:
> Hi,
> 
> I'm re-opening a somewhat old thread about serial flow control methods:
> 
> Russell King, le Wed 05 Jan 2005 23:53:01 +0000, a ?crit :
> > we have other people
> > who want to use their on-board hardware RS485 flow control options on
> > UARTs for their application, which means we need an RS485 flow control
> > method.  (They can't select it without accessing the hardware directly.)
> > 
> > So, we now seem to have:
> > 
> > 	Standard flow control
> > 	CTVB flow control
> > 	RS485 RTS flow control
> 
> Let's add a new one: Inka braille devices, which uses RTS/CTS as
> acknowledge strobes for each character.
> 
> > I still believe that flow control should be enabled by CRTSCTS, but
> > the flow control personality set by other means.
> > 
> > Therefore, I think this requires further discussion, especially with
> > Alan (who seems to be the tty layer god now) to work out some sort of
> > reasonable interface.
> 
> How could this look like in userspace? Something like
> 
> #define CRTSCTS_RS232 0
> #define CRTSCTS_RS485 1
> #define CRTSCTS_TVB 2
> #define CRTSCTS_INKA 3
> 	int method = CRTSCTS_RS485;
> 	ioctl(fd,TIOCMSFLOWCTRL,&method);
> 
> (and the converse TIOCMGFLOWCTRL)?

I think they should be termios settings - existing programs know how
to handle termios to get what they want.  Why make the situation more
complex for them?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
