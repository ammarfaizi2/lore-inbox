Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274866AbTHFF74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 01:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274868AbTHFF74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 01:59:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:62084 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274866AbTHFF7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 01:59:55 -0400
Message-Id: <200308060559.h765xhI05860@mail.osdl.org>
From: OSDL <torvalds@osdl.org>
Subject: Re: 2.5/2.6 PCMCIA Issues
To: Misha Nasledov <misha@nasledov.com>, linux-kernel@vger.kernel.org
Reply-To: torvalds@osdl.org
Date: Tue, 05 Aug 2003 22:59:43 -0700
References: <20030804232204.GA21763@nasledov.com> <20030805144453.A8914@flint.arm.linux.org.uk> <20030806045627.GA1625@nasledov.com>
Organization: OSDL
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Misha Nasledov wrote:
> 
> I am attaching the dmesg output after booting 2.6.0-test2; this does
> not include the insertion of the Orinoco card as the console freezes
> immediately after the event. I inspected my logs after a reboot and
> there were no messages whatsoever regarding the event of the insertion
> of the Orinoco card.

Can you try with PnP and the i82365 support _disabled_. I find this sequence
very suspicious:

        Intel PCIC probe: PNP <6>pnp: Device 00:17 activated.
        invalid resources ?
        pnp: Device 00:17 disabled.
        not found.

and I bet it messes up some of the register state that the yenta probe had
just set up.

You should try with just CONFIG_YENTA - the 82365 stuff is for the old
16-bit only controllers.

                Linus
