Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262647AbTCPKYh>; Sun, 16 Mar 2003 05:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbTCPKYh>; Sun, 16 Mar 2003 05:24:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43791 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262644AbTCPKYf>; Sun, 16 Mar 2003 05:24:35 -0500
Date: Sun, 16 Mar 2003 10:35:18 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Fowler <cfowler@outpostsentinel.com>,
       Robert White <rwhite@casabyte.com>, Ed Vance <EdV@macrolink.com>,
       "'Linux PPP'" <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: RS485 communication
Message-ID: <20030316103517.B14404@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chris Fowler <cfowler@outpostsentinel.com>,
	Robert White <rwhite@casabyte.com>, Ed Vance <EdV@macrolink.com>,
	'Linux PPP' <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org,
	'linux-kernel' <linux-kernel@vger.kernel.org>
References: <PEEPIDHAKMCGHDBJLHKGGECKCDAA.rwhite@casabyte.com> <1047598241.5292.2.camel@hp.outpostsentinel.com> <1047732394.20703.10.camel@imladris.demon.co.uk> <1047776160.1327.0.camel@irongate.swansea.linux.org.uk> <1047809131.22070.33.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1047809131.22070.33.camel@imladris.demon.co.uk>; from dwmw2@infradead.org on Sun, Mar 16, 2003 at 10:05:31AM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 10:05:31AM +0000, David Woodhouse wrote:
> Note you don't need any separate lines for this. If someone else is
> transmitting a zero while you are also transmitting a zero, that's fine
> and you didn't stomp on each other. If someone else is transmitting a
> zero while you are transmitting a one, you won and a one was
> transmitted, and they back off. If they transmit a one while you
> transmit a zero, then they won :)

No - that's not how RS485 works.  With a balanced line, the result
that any one receiver will see will depend on it's position on the
line and the relative distance to each transmitter, the resistance
of the line, and the manufacturer/type of the RS485 transceiver.
In other words, the state you see is indeterminent.

Also, a correctly terminated RS485 has no way to tell if someone is
transmitting other than yourself receiving characters since the
termination resistors bias the line into the mark state.

If you don't have a correctly biased RS485 line, you can end up with
framing errors with validly transmitted data, and given the right
data pattern, it could be an undetectable without checksums and the
like. What's worse is that this type of error can occur each time
you retransmit.  Naturally, there are certain tricks you can pull to
ensure that the receiver is properly synchronised before you transmit
real data.

Been there, seen the problem, diagnosed it, and modified embedded
software on both master and slave ends to work around it.  After
you've dealt with equipment with 20 RS485 buses internally with up
to 50 transceivers on a line, and around 50 RS485 buses running
around large buildings to various sensors, you end up understanding
some of these problems fairly well. 8/

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

