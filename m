Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVI3IA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVI3IA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 04:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVI3IA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 04:00:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36272 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030253AbVI3IA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 04:00:57 -0400
Date: Fri, 30 Sep 2005 10:00:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Problems with CF bluetooth (fwd) (fwd)
Message-ID: <20050930080034.GB5598@elf.ucw.cz>
References: <20050929223736.GF2180@elf.ucw.cz> <1128066195.4955.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128066195.4955.5.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thanks, Russell. Marcel, this is probably solution to that oops.
> 
> cool that you worked something out. Do you have a patch for me?

Well, I have that ugly workaround that helps me, but is wrong (as rmk
confirmed). His comment was:

|> Sep 29 15:42:34 amd kernel: Call Trace:
|> Sep 29 15:42:34 amd kernel:  [<c03f9df6>] hci_uart_flush+0x66/0x80
|> Sep 29 15:42:34 amd kernel:  [<c03f9e27>] hci_uart_close+0x17/0x20
|> Sep 29 15:42:34 amd kernel:  [<c03f9f86>]
|> hci_uart_tty_close+0x26/0x60
|> Sep 29 15:42:34 amd kernel:  [<c02a5ed7>] release_dev+0x587/0x670
|
|Looking at release_dev(), it does things in the following order:
|
|1. various sanity checks
|2. close the driver
|3. more sanity checks and other housekeeping
|4. close the ldisc
|5. reset the ldisc for the tty to N_TTY
|
|This means that bluetooth is calling into a TTY driver with a tty
|for which the driver has already shut down.  No surprise it oopses.
|Bluetooth should not call the driver during it's closedown.
|
|(There also appears to be an interesting race condition between the
|driver shutting down and the ldisc write functions getting to know
|about it... Alan?)

But no, I do not have patch for that.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
