Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWAXA3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWAXA3m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWAXA3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:29:42 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:45422 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030228AbWAXA3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:29:42 -0500
From: David Brownell <david-b@pacbell.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: EHCI + APIC errors = no usb goodness
Date: Mon, 23 Jan 2006 15:53:38 -0800
User-Agent: KMail/1.7.1
Cc: ak@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <20060123210443.GA20944@suse.de>
In-Reply-To: <20060123210443.GA20944@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601231553.38995.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 1:04 pm, Greg KH wrote:

> Any thoughts?

Not particularly; clearly the EHCI driver enabled IRQs, since that's
not done until after the "USB 2.0 started, EHCI 1.00, driver 10 Dec 2004"
message prints.  And it shouldn't be an SMI issue, as might be improved
by that patch I sent this AM.

According to arch/i386/kernel/apic.c that "0x40" APIC error bit means
it got an illegal vector ... sounds to me like IRQ setup issues, since
USB code doesn't know about such things (they're not even exposed from
the arch irq handling code).

Try sticking a message where ehci_irq() returns IRQ_NONE and see what
IRQ status is being reported to EHCI.

- Dave
