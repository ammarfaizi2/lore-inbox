Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316970AbSFAAVr>; Fri, 31 May 2002 20:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316972AbSFAAVq>; Fri, 31 May 2002 20:21:46 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:29146 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316970AbSFAAVq>;
	Fri, 31 May 2002 20:21:46 -0400
Date: Fri, 31 May 2002 17:21:22 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Link order madness :-(
Message-ID: <20020531172122.A27675@bougret.hpl.hp.com>
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

	I was trying to make the IrDA stack work when compiled in the
kernel in 2.5.X (as opposed to modular). In 2.4.X, it sort of work,
but whoever made changes to the IrDA init in 2.5.X obviously didn't
bother to check what he was doing and check his changes.
	So, I was trying to fix that, and I found a problem with
kernel link order.

	The IrDA stack need to be initialised :
	AFTER :
		o the networking code (done in init/main.c)
		o driver/char/random.c (done via __initcall())
	BEFORE :
		o IrDA drivers (done via module_init())
		o IrDA higher protocols (done via module_init())

	As both the random driver and the irda drivers are at the same
init level, there is no way to enforce those dependancies. Currently,
the IrDA drivers are loaded before the IrDA stack (== kaboom).
	Personally, I found it a bit strange the the random driver is
initialised so late in the game when the whole networking code (at
least) depends on it.

	Please advise...

	Jean
