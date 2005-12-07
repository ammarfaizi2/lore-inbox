Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVLGPWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVLGPWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVLGPWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:22:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34477 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751124AbVLGPWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:22:41 -0500
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from
	spin lock to atomic_t.
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       Eduardo Pereira Habkost <ehabkost@mandriva.com>,
       Greg KH <gregkh@suse.de>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0512071000120.21143-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0512071000120.21143-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 16:22:23 +0100
Message-Id: <1133968943.2869.26.camel@laptopd505.fenrus.org>
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


> On the other hand, Oliver needs to be careful about claiming too much.  In 
> general atomic_t operations _are_ superior to the spinlock approach.

No they're not. Both are just about equally expensive cpu wise,
sometimes the atomic_t ones are a bit more expensive (like on parisc
architecture). But on x86 in either case it's a locked cycle, which is
just expensive no matter which side you flip the coin... 

>   If 
> they weren't, atomic_t wouldn't belong in the kernel at all.

there's different usage patterns where either makes sense. 
In this case it looks just disgusting on very first sight; the atomic
are used to implement a lock, and that lock itself is then implemented
with a spinlock again. For me, again on first sight, the real solution
appears to be to use a linux primitive for the higher level lock in the
first place, instead of reimplementing <your own thing> with <another
own thing>.



