Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVFFVqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVFFVqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVFFVq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:46:29 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:44173 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261702AbVFFVqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:46:04 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] Re: swsusp: Not enough free pages
Date: Mon, 6 Jun 2005 23:46:08 +0200
User-Agent: KMail/1.8.1
Cc: linux-pm@lists.osdl.org, "Yu, Luming" <luming.yu@intel.com>,
       Andrew Morton <akpm@zip.com.au>,
       ACPI devel <acpi-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403> <200506061902.34304.rjw@sisk.pl> <20050606171417.GB2230@elf.ucw.cz>
In-Reply-To: <20050606171417.GB2230@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506062346.09503.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 6 of June 2005 19:14, Pavel Machek wrote:
> Hi!
> 
> > > > > > > So far, yes. I just tried 2 times.
> > > > > >
> > > > > > always. (I check that swap dev is on)
> > > > > >
> > > > > > Sometimes, my ia32 laptop free 0 pages too.
> > > > > > I think we should always free some pages
> > > > > > from various caches.
> > > > >
> > > > > Try this hack... it is basically mm problem I don't know how to fix,
> > > > > but this seems to help.
> > > > > 								Pavel
> > > > 
> > > > Thanks Pavel, this hack works.
> > > > ..
> > > > Freeing memory...  ^Hdone (0 pages freed)
> > > > Freeing memory...  ^H-^Hdone (4636 pages freed)
> > > > Freeing memory...  ^Hdone (0 pages freed)
> > > > Freeing memory...  ^H-^Hdone (914 pages freed)
> > > > Freeing memory...  ^Hdone (0 pages freed)
> > > > Freezing CPUs (at 0)...ok
> > > > 
> > > > Any mm guru know how to fix this?
> > > 
> > > Andrew, can you help? It seems free_some_memory does not really free
> > > all reclaimable memory in recent kernels. In fact, it likes to free
> > > nothing on first invocations....
> > 
> > Actually, on (my) x86-64 it seems to work.  It frees even more memory than
> > I'd like it to (there's 80-90% of RAM free after it's finished). ;-)
> > 
> > If I had to guess, I'd say the problem is related to PAGE_SIZE !=
> >4096.
> 
> No, I see it on i386, too. Try patch below; if it frees some after
> first pass, you have that problem, too.

I've run it once and the result is this:

Freeing memory... done (75876 pages freed)
Freeing memory... done (1536 pages freed)
Freeing memory... done (0 pages freed)
Freeing memory... done (1792 pages freed)
Freeing memory... done (0 pages freed)

It does free some pages after the first pass, but this is only a small fraction
of all pages freed.  I wouldn't call it a bad result ...

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
