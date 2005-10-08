Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVJHW1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVJHW1e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 18:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVJHW1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 18:27:34 -0400
Received: from mailfe14.tele2.fr ([212.247.155.172]:24999 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932182AbVJHW1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 18:27:33 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sun, 9 Oct 2005 00:27:11 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] new serial flow control
Message-ID: <20051008222711.GA5150@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Russell King <rmk@arm.linux.org.uk>, akpm@osdl.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050105235301.B26633@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm re-opening a somewhat old thread about serial flow control methods:

Russell King, le Wed 05 Jan 2005 23:53:01 +0000, a écrit :
> we have other people
> who want to use their on-board hardware RS485 flow control options on
> UARTs for their application, which means we need an RS485 flow control
> method.  (They can't select it without accessing the hardware directly.)
> 
> So, we now seem to have:
> 
> 	Standard flow control
> 	CTVB flow control
> 	RS485 RTS flow control

Let's add a new one: Inka braille devices, which uses RTS/CTS as
acknowledge strobes for each character.

> I still believe that flow control should be enabled by CRTSCTS, but
> the flow control personality set by other means.
> 
> Therefore, I think this requires further discussion, especially with
> Alan (who seems to be the tty layer god now) to work out some sort of
> reasonable interface.

How could this look like in userspace? Something like

#define CRTSCTS_RS232 0
#define CRTSCTS_RS485 1
#define CRTSCTS_TVB 2
#define CRTSCTS_INKA 3
	int method = CRTSCTS_RS485;
	ioctl(fd,TIOCMSFLOWCTRL,&method);

(and the converse TIOCMGFLOWCTRL)?

Regards,
Samuel
