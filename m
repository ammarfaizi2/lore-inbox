Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUARQQp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 11:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUARQQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 11:16:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40460 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261909AbUARQQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 11:16:44 -0500
Date: Sun, 18 Jan 2004 16:16:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acme@conectiva.com.br, arobinso@nyx.net, support@moxa.com.tw,
       christoph@lameter.com, pgmdsg@ibi.com, richard@sleepie.demon.co.uk,
       R.E.Wolff@BitWizard.nl, fritz@isdn4linux.de, reginak@cyclades.com,
       oli@bv.ro, jeff@uclinux.org, macro@ds2.pg.gda.pl
Subject: Re: [3/3] 2.6 broken serial drivers
Message-ID: <20040118161613.I19593@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, acme@conectiva.com.br,
	arobinso@nyx.net, support@moxa.com.tw, christoph@lameter.com,
	pgmdsg@ibi.com, richard@sleepie.demon.co.uk, R.E.Wolff@BitWizard.nl,
	fritz@isdn4linux.de, reginak@cyclades.com, oli@bv.ro,
	jeff@uclinux.org, macro@ds2.pg.gda.pl
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth> <20040113113650.A2975@flint.arm.linux.org.uk> <20040113114948.B2975@flint.arm.linux.org.uk> <20040113171544.B7256@flint.arm.linux.org.uk> <20040113174219.E7256@flint.arm.linux.org.uk> <20040113122115.50265601.akpm@osdl.org> <20040113211023.H7256@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040113211023.H7256@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Jan 13, 2004 at 09:10:23PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 09:10:23PM +0000, Russell King wrote:
> On Tue, Jan 13, 2004 at 12:21:15PM -0800, Andrew Morton wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > >
> > > --- 1.14/drivers/net/wan/pc300_tty.c	Thu Sep 11 18:40:53 2003
> > > +++ edited/drivers/net/wan/pc300_tty.c	Tue Jan 13 14:42:34 2004
> > > @@ -583,6 +583,14 @@
> > >  	CPC_TTY_DBG("%s: IOCTL cmd %x\n",cpc_tty->name,cmd);
> > >  	
> > >  	switch (cmd) { 
> > > +#error This is broken.  See comments.
> > 
> > Grumble.  This breaks allmodconfig.  #warning, please.
> 
> Probably far better to make all these drivers depend on BROKEN unless
> one of the authors speaks up.

Ok, no one spoke, so here's the patch to mark this driver broken:

===== drivers/net/wan/Kconfig 1.16 vs edited =====
--- 1.16/drivers/net/wan/Kconfig	Tue Dec 30 08:45:02 2003
+++ edited/drivers/net/wan/Kconfig	Sun Jan 18 16:15:19 2004
@@ -367,7 +367,7 @@
 
 config PC300_MLPPP
 	bool "Cyclades-PC300 MLPPP support"
-	depends on PC300 && PPP_MULTILINK && PPP_SYNC_TTY && HDLC_PPP
+	depends on PC300 && PPP_MULTILINK && PPP_SYNC_TTY && HDLC_PPP && BROKEN
 	help
 	  Say 'Y' to this option if you are planning to use Multilink PPP over the
 	  PC300 synchronous communication boards.


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
