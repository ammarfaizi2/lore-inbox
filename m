Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVKVOE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVKVOE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVKVOE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:04:29 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:30673 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964942AbVKVOE3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:04:29 -0500
Date: Tue, 22 Nov 2005 07:04:25 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
Message-ID: <20051122140425.GK1598@parisc-linux.org>
References: <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org> <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org> <20051121194348.GH1598@parisc-linux.org> <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org> <20051121211544.GA4924@elte.hu> <17282.15177.804471.298409@cargo.ozlabs.ibm.com> <1132611631.11842.83.camel@localhost.localdomain> <1132657991.15117.76.camel@baythorne.infradead.org> <1132668939.20233.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132668939.20233.47.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 02:15:39PM +0000, Alan Cox wrote:
> On Maw, 2005-11-22 at 11:13 +0000, David Woodhouse wrote:
> > Yes, there are drivers which are currently broken and assume irq 0 is
> > 'no irq'. They are broken. Let's just fix them and not continue the
> > brain-damage.
> 
> 0 in the Linux kernel has always meant 'no IRQ' and it makes it natural
> to express in C (and on some cpus more efficient too).
> 
> What if my hardware has an IRQ -1 ;)

Then it falls off the bottom of the irq_desc array.  Already tried that,
hence patch 1/5.

That was a great one to debug, btw.  "The machine hangs when I select
processor type PA8000 but works with processor type PA7200".  Why?
synchronize_irq() spins waiting for a bit to become clear ... for some
reason that bit was always set with PA8000 and always clear with PA7200.
http://lists.parisc-linux.org/pipermail/parisc-linux/2005-October/027485.html
