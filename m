Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWE1RRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWE1RRs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWE1RRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:17:47 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:59841 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S1750811AbWE1RRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:17:47 -0400
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Christer Weinigel <christer@weinigel.se>, Nathan Laredo <laredo@gnu.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>
	<m3slmui1cr.fsf@zoo.weinigel.se> <4479D167.4020203@gmail.com>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 28 May 2006 19:17:46 +0200
In-Reply-To: <4479D167.4020203@gmail.com>
Message-ID: <m3odxihxvp.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:

> Christer Weinigel napsal(a):
> > fixed in the driver.  If the card doesn't have a subvendor/subdevice,
> > is there some way of doing a sanity check on the board to see if it
> > actually is a stradis card and then release the board if it isn't?
> Unfortunately not.

Why not?  There's an I2C bus with a bunch of devices on it.  Isn't it
possible to do an I2C scan and if it doesn't match what's supposed to
be on the card fail the probe and release the PCI resources?

If there is no FPGA or the FPGA fails to respond, that should also be
a fairly good indicator that it is not a stradis board.

And it seems that at least some of the cards have a value in the
subvendor field since the driver says "SDM2xx found" if
pdev->subsystem_vendor is nonzero.  So how common are the rev1 boards
(which I assume have zeroes in the subvendor/subdevice fields) and
what does "lspci -vn" for the SDM2xx boards say?

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
