Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbULMQCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbULMQCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbULMQCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:02:19 -0500
Received: from mobileweb04.london.02.net ([193.113.235.170]:4111 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261259AbULMQBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:01:38 -0500
Subject: Re: dynamic-hz
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <20041213135820.A24748@flint.arm.linux.org.uk>
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
	 <41BD483B.1000704@suse.de>  <20041213135820.A24748@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102949565.2687.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Dec 2004 14:52:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-13 at 13:58, Russell King wrote:
> Lets take an example.  Lets say that:
> * a CPU runs at about 245mA when active
> * 90mA when inactive
> * the timer interrupt takes 2us to execute 1000 times a second
> * no other processing is occuring

Now take a real laptop and the numbers are in the 20W (15A) range.

> to eliminate the timer tick to save some power.  However, I've
> never been able to justify the extra code complexity against the
> power savings.  It really only makes sense if you can essentially
> _power off_ your system until the next timer interrupt (thereby,
> in the above example, reducing the power consumption by some 174mA)

On a PC it makes huge sense, the deeply embedded folks who do turn the
thing off for 30secs at a time (Eg cellphone) also want it as do
virtualisation people where it trashes your scaling. API wise it isn't
too hard, its just a matter of time to convert the jiffies users away
and to do relative versions of add_timer with accuracy info included.

