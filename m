Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUKKSr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUKKSr4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUKKSpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:45:46 -0500
Received: from mail2.bluewin.ch ([195.186.4.73]:49657 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S262356AbUKKSno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 13:43:44 -0500
Date: Thu, 11 Nov 2004 19:43:38 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Brian Jackson <notiggy@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 vs 2.4: pxe booting system won't restart
Message-ID: <20041111184338.GC9771@k3.hellgate.ch>
Mail-Followup-To: Brian Jackson <notiggy@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <fb20c214041110103647fc6b51@mail.gmail.com> <1100111849.20555.23.camel@localhost.localdomain> <fb20c214041110123615f89230@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb20c214041110123615f89230@mail.gmail.com>
X-Operating-System: Linux 2.6.10-rc1-bk17 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[BCC'ed the people at VNTEK who are on the case]

On Wed, 10 Nov 2004 14:36:50 -0600, Brian Jackson wrote:
> > > Then the bios tries to fallback to other means of booting, and there
> > > are none. Anybody got any clues where to start looking for fixes?
> > 
> > Remove the kernel code that powers down the ethernet chip. If that works
> 
> Yay, looks like this bit near line 1950 of via-rhine.c:
> 	/* Hit power state D3 (sleep) */
> 	writeb(readb(ioaddr + StickyHW) | 0x03, ioaddr + StickyHW);
> 
> I removed that, and it works like a charm now. Thank you very much.

I'm sorry, I should posted a warning earlier. This problem has been
reported before.

> > then poke VIA.
> 
> Poke them to fix the driver or to fix the bios?

BIOS. I can't fix this in the driver. Some hardware requires D3 for WOL.

Roger
