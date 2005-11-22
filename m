Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVKVLN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVKVLN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVKVLN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:13:56 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:7111 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S964915AbVKVLNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:13:55 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1132611631.11842.83.camel@localhost.localdomain>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
	 <24299.1132571556@warthog.cambridge.redhat.com>
	 <20051121121454.GA1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	 <20051121190632.GG1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	 <20051121194348.GH1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
	 <20051121211544.GA4924@elte.hu>
	 <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
	 <1132611631.11842.83.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 11:13:11 +0000
Message-Id: <1132657991.15117.76.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 22:20 +0000, Alan Cox wrote:
> > Yes, G5 powermacs have the SATA controller on irq 0.  So if we can't
> > use irq 0, I can't get to my hard disk. :)  Other powermacs also use
> > irq 0 for various things, as do embedded PPC machines.
> 
> G5 powermacs have the SATA controller on physical IRQ value 0. Linux IRQ
> values don't need to exactly map. One of the x86 ports handles 'real IRQ
> 0' exactly this way. Its a cookie. Sure would benefit from a function
> for turning an IRQ into a description as a cleanup.

Remapping in that way sounds like a half-arsed hack to work around the
problem which Matthew is trying to fix properly by using NO_IRQ == -1.

Yes, there are drivers which are currently broken and assume irq 0 is
'no irq'. They are broken. Let's just fix them and not continue the
brain-damage.

-- 
dwmw2


