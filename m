Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbUKGC5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbUKGC5j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 21:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbUKGC5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 21:57:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:44770 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261521AbUKGC5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 21:57:37 -0500
Date: Sat, 6 Nov 2004 18:57:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, vojtech@ucw.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [no problem] PC110 broke 2.6.9
In-Reply-To: <1099791769.5564.118.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0411061851300.2223@ppc970.osdl.org>
References: <20041106232228.GA9446@apps.cwi.nl>  <Pine.LNX.4.58.0411061529200.2223@ppc970.osdl.org>
 <1099791769.5564.118.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Nov 2004, Alan Cox wrote:
>
> On Sad, 2004-11-06 at 23:37, Linus Torvalds wrote:
> > Ahh.. Interesting. One improvement might be to make sure that this driver 
> > links in very late in the game, so that if any other drivers have 
> > allocated the IO, at least it won't override that. Also, it might make 
> > sense to say that the dang thing can share interrupts.
> 
> It can't share interrupts.

Not if it's there, no. But if the hardware doesn't actually exist on the 
machine, and you can't probe for it, it may be better to say "hey, I'll 
share interrupts, because I don't know if I actually exist or not" ;)

> > But yes, we should probably make sure to make it harder to enable the
> > driver by mistake, and try to do minimal probing of it. I have no idea how
> > to probe for the thing, though.
> 
> I never found anything. 
> 
> > Alan, Vojtech, do you have any register information on this thing? Some 
> > docs to try to realize when it's not there? Or some other way to detect 
> > the IBM PC110 hardware (BIOS strings, something?)
> 
> I have some register info, the driver is done by disassembly of the
> PC-DOS
> driver IBM shipped with the PC110. It's a pre pci, pre dmi machine so
> there aren't any obvious sane ways to probe. Its not something you'd
> want to build in as opposed to modular on any other system but the PC110

Well, that actually _is_ something we can probe for: "does this machine 
have PCI". 

IOW, we could have a trivial "if the list of PCI devices is non-empty, 
then return immediately" kind of thing, no?

That would mean that (pretty much) anybody loading that driver by mistake
wouldn't get into trouble.

		Linus
