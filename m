Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVJQQx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVJQQx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbVJQQx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:53:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750747AbVJQQxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:53:55 -0400
Date: Mon, 17 Oct 2005 09:53:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] libata: fix broken Kconfig setup
In-Reply-To: <Pine.LNX.4.64.0510170930420.23590@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0510170946250.23590@g5.osdl.org>
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org>
 <4353C42A.3000005@pobox.com> <Pine.LNX.4.64.0510170848180.23590@g5.osdl.org>
 <4353CF7E.1090404@pobox.com> <Pine.LNX.4.64.0510170930420.23590@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Linus Torvalds wrote:
> 
> >  And then with the quirk issue out of
> > the way, CONFIG_SCSI_SATA becomes purely a boolean enable/disable-this-menu
> > switch.
> 
> No it does not. You continue to ignore the fact that it's not an 
> enable/disable thing. It's a "can we enable SATA drivers" vs "can we 
> enable SATA drivers as modules" vs "do we do any SATA drivers at all?" 
> thing.
> 
> A tristate.

Btw, if you want to have the _question_ always be y/n only, that's easy 
enough to do, just make that one do

	config SATA_MENU
		bool "Want to see SATA drivers"
		depends on SCSI != n

	config SCSI_SATA
		tristate
		depends on SCSI && SATA_MENU
		default y

and now you have a totally sensible setup, where the low-level drivers can 
depend on something sane. 

I don't think it _buys_ you anything, but hey, at least it's logical. 

Btw, wouldn't it be much nicer to also have this all in a totally separate 
Kconfig file? That SCSI Kconfig file is one of the biggest ones (yeah, 
drivers/net/Kconfig is bigger, but hey, that's not a surprise, is it ;)

		Linus
