Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbVKCPTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbVKCPTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbVKCPTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:19:20 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:24480 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030293AbVKCPTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:19:19 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0511030658tb23cecds2ed8cc63570a68d5@mail.gmail.com>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <58cb370e0511030658tb23cecds2ed8cc63570a68d5@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Nov 2005 15:49:34 +0000
Message-Id: <1131032974.18848.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-03 at 15:58 +0100, Bartlomiej Zolnierkiewicz wrote:
> On 11/3/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Core Features Fixed
> > - Per drive tuning
> > - Filter quirk lists
> > - Single channel support
> 
> Are these the same changes that have been recently pushed into
> Linus' tree without any previous public review or some new ones?

Some of the changes have gone to Jeff Garzik others are pending
improvments/driver fixes for existing drivers and testing before Jeff
accepts them. Beyond that its up to Jeff what is merged into -mm and on.

> > Drivers so far written for the libata parallel work I'm doing
> 
> Are the patches available somewhere?

Yes. I'll post updated sets at some point soon. The patch I posted
pointers to before is now well out of date.

> > AMD
> > Driver written, given basic testing and equivalent to current
> > drivers/ide
> 
> Functionality can't be the same as drivers/ide because libata
> lacks some core features.

Well duh, other than core differences. Functionality is indeed different
- CRC errors dont crash SMP boxes for example ;)

> > CS5520
> > Driver written, some debug work to do. Works unlike the drivers/ide one
> 
> Please fix drivers/ide also if not a big problem.

I started this work in part because it was impossible to work with you.
I've no interest in fixing drivers/ide and in fact I'm now running as
much as I can with CONFIG_IDE=n, because the only way to really test
code is to use it all the time.

The things I've fixed however if you want to go fix them in drivers/ide
are

CS5520 is totally broken. You want the fixes I sent you over a year ago
and maybe more. Its probably best left as I doubt anyone else has a 5520
any more 8)

Serverworks runs the wrong cable detect routine in some cases
(conditions ordered wrongly)

I think the HPT366 driver contains several bugs looking at it in
comparison with hpts driver and the data sheets I can get hold of. It's
hard to be sure however because at times all three disagree with each
other. In particular it doesn't know about 302N but think its a 37x and
the PLL tune code appears to be unrelated to either data sheet or hpt
code. Can't be sure yet on the PLL until I've got PLL modes working in
the libata driver.


Alan (drivers/ide elimination department)

