Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUHJJhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUHJJhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUHJJhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:37:38 -0400
Received: from mail1.kontent.de ([81.88.34.36]:61359 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262837AbUHJJhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:37:36 -0400
Date: Tue, 10 Aug 2004 11:37:34 +0200
From: Sascha Wilde <wilde@sha-bang.de>
To: "David N. Welton" <davidw@eidetix.com>
Cc: jamesl@appliedminds.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Message-ID: <20040810093734.GA1089@kenny.sha-bang.local>
References: <auto-000000462036@appliedminds.com> <411735BD.3000303@eidetix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411735BD.3000303@eidetix.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 10:28:45AM +0200, David N. Welton wrote:

> The shutdown sequence is not hanging, though, as far as I can tell.

Yes, I think I pointed out before, that not any code of the kernel,
but the hardware itself hangs during the reboot.

> You can triple fault the machine immediately after the first WCTR
> command during initialization (triple fault reboots it just fine
> just before the same command) and it doesn't cause a reboot, and yet
> it's no longer executing instructions from the kernel (or at least
> not printk's or anything meaningful).  I don't think it's the
> parameters that it's passing to the WCTR command either, because if
> you look in the previous batch of printk's, it's putting back in
> exactly what it got out.

Right, in fact the problem occures from the first writing to the i8042
register.  When you comment out all of the lines sending a
"I8042_CMD_CTL_WCTR" from i8042.c the resulting kernel will reboot
under al conditions (at least it does here) -- but unfortunatly that
renders the local Keyboard unusable...

Putting only one of them back in, (for example the one in
i8042_activate_port(), which brings the keyboard back to life) the
reboot hangs again.

Big question:  how was the initialisation of the PS/2 ports managed in
2.4.x?  Ther seems to be no similar code to i8042.c in it[0], and all I
have found till now is a bunch ob obscure jump-rables in
arch/i386/kernel/setup.c ...

cheers
sascha

[0] In fact, the only code mentioning the i8042 in 2.4 is related to
    HP HIL devices...
-- 
Sascha Wilde : "Lies, was ich meine, nicht, was ich schreibe."
             : (Urs Traenkner in de.alt.admin)
