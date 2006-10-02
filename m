Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWJBKUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWJBKUq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWJBKUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:20:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16795 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750737AbWJBKUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:20:45 -0400
Subject: Re: CONFIG_PARPORT_PC_SUPERIO
From: David Woodhouse <dwmw2@infradead.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061002094959.GA13986@aepfle.de>
References: <20061002094959.GA13986@aepfle.de>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 11:20:24 +0100
Message-Id: <1159784424.4801.26.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-6.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 11:49 +0200, Olaf Hering wrote:
> Does aynone know if the hardware that is enabled with
> CONFIG_PARPORT_PC_SUPERIO is available on PCI devices? The functions
> detect_and_report_winbond() and detect_and_report_smsc() poke at random
> legacy IO ports. I just wonder if they may also find the hardware if
> they come from a PCI device.
> If they are i386 only, the config option should probably be i386 (or
> whatever) only. 

They're not i386 only. There's plenty of non-i386 machines with SuperIO
chips in. They're the easiest way to bolt floppy/parallel/IrDA/serial
support onto a board.

But we really shouldn't have individual drivers poking at the magic
configuration addresses to find SuperIO chips. There should be support
for those _separately_ -- and then the parport/irda/serial drivers can
all consult it as appropriate, rather than poking directly at the
hardware.

I did make a start on drivers/pnp/superio once, but didn't get very far
before I got distracted. Start with lssuperio.

-- 
dwmw2

