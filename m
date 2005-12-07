Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVLGQE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVLGQE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVLGQE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:04:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:481 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751170AbVLGQE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:04:28 -0500
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from
	spin lock to atomic_t.
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       Eduardo Pereira Habkost <ehabkost@mandriva.com>,
       Greg KH <gregkh@suse.de>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0512071059420.21143-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0512071059420.21143-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 17:04:16 +0100
Message-Id: <1133971457.2869.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 11:01 -0500, Alan Stern wrote:
> On Wed, 7 Dec 2005, Arjan van de Ven wrote:
> 
> > > On the other hand, Oliver needs to be careful about claiming too much.  In 
> > > general atomic_t operations _are_ superior to the spinlock approach.
> > 
> > No they're not. Both are just about equally expensive cpu wise,
> > sometimes the atomic_t ones are a bit more expensive (like on parisc
> > architecture). But on x86 in either case it's a locked cycle, which is
> > just expensive no matter which side you flip the coin... 
> 
> You're overgeneralizing.

to some degree yes.

> 
> Sure, a locked cycle has a certain expense.  But it's a lot less than the 
> expense of a contested spinlock. 

the chances that *this* spinlock ends up being contested are near zero,
and.. in that scenario a locked cycle does the same thing, just in
hardware..... (eg the other cpu will busy wait until this locked cycle
is done)

