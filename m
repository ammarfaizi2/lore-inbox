Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbVI1Wfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbVI1Wfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbVI1Wfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:35:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56554 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750998AbVI1Wfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:35:52 -0400
Date: Thu, 29 Sep 2005 00:35:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [discuss] Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Message-ID: <20050928223535.GA2010@elf.ucw.cz>
References: <200509281624.29256.rjw@sisk.pl> <200509282224.43397.rjw@sisk.pl> <200509282233.54446.ak@suse.de> <200509290011.41335.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200509290011.41335.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > The following patch fixes Bug #4959.  For this purpose it creates
> > > > > temporary page translation tables including the kernel mapping (reused)
> > > > > and the direct mapping (created from scratch) and makes swsusp switch
> > > > > to these tables right before the image is restored.
> > > > >
> > > > > The code that generates the direct mapping is based on the code in
> > > > > arch/x86_64/mm/init.c.
> > > >
> > > > Looks much better than before, but is there any reason you cannot
> > > > share the code with the mm/init.c code?
> > >
> > > I think so.  I have to make the temporary page tables nosavedata or set
> > > PG_nosave on them, so that swsusp doesn't overwrite them.  I'm not
> > > sure if I could do this cleanly if I used the code from mm/init.c directly.
> > 
> > Just pass a flag for that.
> 
> Well, the code in mm/init.c is only executed really early, before zones
> are initialized, and it uses alloc_low_page() to map memory.  Thus it seems
> I only could make my code be executed next to init_memory_mapping(),
> in which case I wouldn't be able to use page flags.  Apparently I'm missing
> something but now I'm too tired to think efficiently.

I guess Andi meant "add a parameter to those mm/init.c functions".

(Otoh, you have reserved area, anyway, just set all of it PG_nosave,
and you'll not need to modify mm/init.c stuff).
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
