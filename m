Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUKFXhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUKFXhm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 18:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUKFXhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 18:37:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:55737 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261500AbUKFXhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 18:37:24 -0500
Date: Sat, 6 Nov 2004 15:37:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: alan@lxorguk.ukuu.org.uk, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [no problem] PC110 broke 2.6.9
In-Reply-To: <20041106232228.GA9446@apps.cwi.nl>
Message-ID: <Pine.LNX.4.58.0411061529200.2223@ppc970.osdl.org>
References: <20041106232228.GA9446@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Nov 2004, Andries Brouwer wrote:
>
> Yesterday I muttered that 2.6.9 had a mouse problem, and soon
> afterwards I also noticed that my ADSL didnt work.
> 
> I just looked at what was wrong, and the reason turns out to be
> a correct fix in the pc110pad_init() call of request_region().
> 
> Before 2.6.9 the test there was wrong, so that the region was
> seen as unavailable and pc110pad.c did not do anything.
> 
> In 2.6.9 the test is correct, the region and irq are reserved and my
> ethernet card can no longer reserve its irq and ADSL fails.
> Moreover, now pc110pad.c does I/O causing my mouse problems.
> 
> Easy solution: CONFIG_MOUSE_PC110PAD=n
> 
> I write this in some detail in the hope that this inspires somebody
> to figure out whether it is possible to probe & detect this PC110.

Ahh.. Interesting. One improvement might be to make sure that this driver 
links in very late in the game, so that if any other drivers have 
allocated the IO, at least it won't override that. Also, it might make 
sense to say that the dang thing can share interrupts.

But yes, we should probably make sure to make it harder to enable the
driver by mistake, and try to do minimal probing of it. I have no idea how
to probe for the thing, though.

Alan, Vojtech, do you have any register information on this thing? Some 
docs to try to realize when it's not there? Or some other way to detect 
the IBM PC110 hardware (BIOS strings, something?)

		Linus
