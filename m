Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbUKWCv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbUKWCv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUKWCuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:50:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:53997 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262463AbUKWCqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:46:17 -0500
Date: Mon, 22 Nov 2004 18:45:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Stian Jordet <stian_web@jordet.nu>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
In-Reply-To: <1101155893.20007.125.camel@d845pe>
Message-ID: <Pine.LNX.4.58.0411221815460.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>  <1100819685.987.120.camel@d845pe>
 <20041118230948.W2357@build.pdx.osdl.net>  <1100941324.987.238.camel@d845pe>
 <20041120124001.GA2829@stusta.de>  <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
  <1101151780.20006.69.camel@d845pe>  <Pine.LNX.4.58.0411221137200.20993@ppc970.osdl.org>
 <1101155893.20007.125.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Len Brown wrote:
> 
> I think the VIA case is more complicated than that, but I'll take
> another look at it.

Ok, having looked at the bugzilla entry, I have to concur. Looks like we 
do need to disable the PCI interrupts and re-enable them. Mea culpa.

So what's the right way to get ELCR into a useful state? I'm starting to
lean towards your "just clear it all" after all, but that does the wrong
thing for SCI (which is _usually_ level-triggered), and I worry that there
are other cases too.

Any reasonably simple patch that likely gets it right?

		Linus
