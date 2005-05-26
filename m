Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVEZEau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVEZEau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 00:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVEZEau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 00:30:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:44520 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261195AbVEZEam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 00:30:42 -0400
Subject: Re: [RFC] Changing pci_iounmap to take 'bar' argument
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ralf@linux-mips.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
In-Reply-To: <1117081633.9076.35.camel@gaston>
References: <1117080454.9076.25.camel@gaston>
	 <Pine.LNX.4.58.0505252121290.2307@ppc970.osdl.org>
	 <1117081633.9076.35.camel@gaston>
Content-Type: text/plain
Date: Thu, 26 May 2005 14:30:14 +1000
Message-Id: <1117081814.9076.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 14:27 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2005-05-25 at 21:25 -0700, Linus Torvalds wrote:
> > 
> > On Thu, 26 May 2005, Benjamin Herrenschmidt wrote:
> > > 
> > > If it's ok with you, I'll send a patch doing it later today.
> > 
> > It's ok by me, certainly. There aren't that many users, and it sounds
> > sane. I'll just prefer the patch going through Greg..
> 
> Ok, just wanted some feedback from you. Some people prefer that I whack
> some "token" in the vitual address at map time, or that I compare the
> vaddr at unmap time with all PCI busses IO ranges or that sort of ugly
> thing, it sounds to me simpler to just pass along the bar number, but I
> wanted your and Greg's ack first.

Oh, and MIPS seems to be broken here ... it's like ppc, it's ioremap'ing
MMIO and just using an existing mapped stuff for IO, but unconditionally
iounmap's on pci_iounmap()... unless there is some arch black magic in
there, that seems broken. Ralph, should I fix it while I'm at it ?

Ben.


