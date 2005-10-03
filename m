Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVJCODA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVJCODA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVJCODA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:03:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2058 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932236AbVJCOC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:02:59 -0400
Date: Mon, 3 Oct 2005 15:02:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CMD7 failing on ATP & Transcend MMC cards
Message-ID: <20051003140252.GG16717@flint.arm.linux.org.uk>
Mail-Followup-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>,
	linux-kernel@vger.kernel.org
References: <20051003135445.GA6560@angel.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003135445.GA6560@angel.research.nokia.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 04:54:45PM +0300, Jarkko Lavinen wrote:
> So far, the problem occured only on ATP and Transcend cards when the card 
> have already been detected and then mmc_detect_change() is called to
> check if any new cards have been inserted.  After CMD2 the next card 
> select command CMD7 fails due to illegal command error.

I'm not surprised.  CMD2 is part way through the initialisation
sequence, so no one should be sending a CMD7.

After a CMD2, the next expected command is a CMD3 for MMC cards (maybe
not SD cards).

Given the code, I don't see how you can possibly be sending a CMD7
before the initialisation has completed.  You need to find out why
a CMD7 is being sent after CMD2.

> I got rid of the problem by simply adding call to mmc_check_cards()
> at and of mmc_setup() function, which is perhaps an overkill. One could do
> it also in mmc_rescan() after switching back to higher clock.

This is not a fix.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
