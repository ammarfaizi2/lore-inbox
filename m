Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVCONb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVCONb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVCONb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:31:57 -0500
Received: from [81.2.110.250] ([81.2.110.250]:40872 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261225AbVCONbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:31:18 -0500
Subject: Re: User mode drivers: part 1, interrupt handling (patch for
	2.6.11)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Peter Chubb <peterc@gelato.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110861150.15588.44.camel@mindpipe>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	 <1110568448.15927.74.camel@localhost.localdomain>
	 <9e47339105031218035f323d68@mail.gmail.com>
	 <1110861150.15588.44.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110893338.15927.175.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Mar 2005 13:28:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-03-15 at 04:32, Lee Revell wrote:
> This seems sufficient for the simplest devices, that just have an
> IRQ_PENDING and an IRQ_ACK register.  But what about a device like the
> emu10k1 where you have a half loop and loop interrupt for each of 64
> channels, plus about 10 other interrupt sources?  The IPR just tells you
> there's a channel loop interrupt pending, in order to properly ACK it
> you need to set a bit in one of 4 registers depending on whether it's a
> loop or half loop interrupt, and whether the channel is 0-31 or 32-64.

Do we need to solve it for all such devices in one go and can we write
custom code for the hard cases. Peter solved the simple unshared-IRQ
case. I'd like to solve the simple shared IRQ cases too (because X can
use this).

I'm wondering where the right line is ?

