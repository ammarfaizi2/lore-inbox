Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287809AbSANR2c>; Mon, 14 Jan 2002 12:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287786AbSANR2Z>; Mon, 14 Jan 2002 12:28:25 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:57040 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S287793AbSANR2K>;
	Mon, 14 Jan 2002 12:28:10 -0500
Date: Mon, 14 Jan 2002 09:28:02 -0800
To: fabrizio.gennari@philips.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: PPP over socket?
Message-ID: <20020114092802.D26289@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <OFDAD62848.4EE45082-ONC1256B41.00314A4F@diamond.philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFDAD62848.4EE45082-ONC1256B41.00314A4F@diamond.philips.com>; from fabrizio.gennari@philips.com on Mon, Jan 14, 2002 at 10:07:22AM +0100
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 10:07:22AM +0100, fabrizio.gennari@philips.com wrote:
> (let's hope this time the mail client understands I want to send this in 
> plain text!)
> 
> I thought that, by changing the socket architecture, the result would be 
> independent to the actual implementation of the socket. For example, a 
> "PPP over generic socket" could be adapted to "PPP over AF_IRDA socket" 
> without having to tear one's hair out implementing the pretty complex 
> /dev/irnet virtual TTY. That is a good solution anyway, but it is very 
> difficult to port it to different kinds of socket.

	I agree in theory, but in practice the problem is the
connection setup. On IrDA, you need "someone" to perform the IAS query
on the right device with the right service name (if you are BlueTooth
oriented, think Inquiry + SDP query). If you look IrNET, the actual
data path is only 10% (or less) of the code, most of the code deal
with discovery and connection setup, and this is purely specific to
the PPP over IrDA solution.
	By the way, the virtual TTY is not that complex, it's more
complex in the case of IrNET because I actually use the TTY interface
for the control channel. If you remove the control channel, it's
pretty straightforward.

> What do you exactly mean with "kernel space wrapper"?

	Like IrNET. There may be way to hook on top of the socket API
from kernel space without modifications (by implementing the bottom
half of the socket layer).

> I guess "user space 
> wrapper" is something like VTun (which I tried, and it works like a dream. 
> Only, isn't it a bit inefficient to go through user space?)

	Did you measure those inefficiencies in practice ?

	Jean
