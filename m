Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbUKVUmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbUKVUmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbUKVUlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:41:19 -0500
Received: from fmr01.intel.com ([192.55.52.18]:42656 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262354AbUKVUjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:39:19 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411221137200.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de>
	 <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
	 <1101151780.20006.69.camel@d845pe>
	 <Pine.LNX.4.58.0411221137200.20993@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1101155893.20007.125.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Nov 2004 15:38:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 15:02, Linus Torvalds wrote:
> 
> On Mon, 22 Nov 2004, Len Brown wrote:
> >
> > When we enable a link, we must set the ELCR.
> > When we disable a link, we must clear the ELCR.
> > We need to be able to enable and disable all links in the system.
> >
> > The bug was that while we were were setting the ELCR
> > when we enabled a link, we were not clearing it when we disabled
> one.
> 
> Fair enough. ...

> But feel free to send me a patch that doesn't just clear ELCR totally,
> but clears the bits we are disabling. I just don't believe in the
> "let's just clear everything" approach.

Will do.

> 
> > But if you're more comfortable with disabling the associated ELCR
> bit> only when we disable links directed at that entry, we can do that
> too.
> > The complication with that approach is that links are many to one,
> so
> > clearing the bit without disabling all links directed to that entry
> > would result in a failure.  Also, the SCI uses the ELCR too, and it
> > isn't described by links at all.
> 
> Wouldn't it be nicer to take the _reverse_ approach: let's assume that
> any PCI interrupts that we have already enabled are fine and should
> not be disabled? Mark them in the ELCR, and _report_ when the ELCR
> seems to be incorrect (let's make a wild guess here, and realize that
> the screaming VIA interrupts you talk about are exactly because the
> ELCR was wrong).

I think the VIA case is more complicated than that, but I'll take
another look at it.


thanks,
-Len


