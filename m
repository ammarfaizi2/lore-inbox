Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292555AbSCRTxy>; Mon, 18 Mar 2002 14:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292594AbSCRTxo>; Mon, 18 Mar 2002 14:53:44 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:48120 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292555AbSCRTx2>;
	Mon, 18 Mar 2002 14:53:28 -0500
Date: Mon, 18 Mar 2002 11:53:13 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Killing tasklet from interrupt
Message-ID: <20020318115313.A26490@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I'm trying to use tasklets and I've come across one problem. I
need to kill a tasklet from a timer, and I wonder if it's legal.

	Code :
	-> User close IrDA TSAP and goes away
		-> LSAP not clean, more work to do
			-> Schedule timer in one second
	-> Timer
		-> If LSAP clean and nothing to do
			-> Kill tasklet
			-> Destroy LSAP
		-> Else re-shedule timer

	The tasklet is used in the Rx path, so may be scheduled after
the user close the TSAP. The TSAP may interface to the socket code, to
the TTY code, to the Ethernet code or the PPP code, so we are not even
guaranteed that the TSAP closure is done from a user context (fun,
fun, fun).
	To be fair, the timer API is much more versatile in that
respect. What I think I need is a tasklet_try_kill()...

	Regards,

	Jean
