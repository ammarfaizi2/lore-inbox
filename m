Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265296AbUATKCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 05:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbUATKCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 05:02:55 -0500
Received: from gprs214-67.eurotel.cz ([160.218.214.67]:11392 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265296AbUATKCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 05:02:48 -0500
Date: Tue, 20 Jan 2004 11:02:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ncunningham@users.sourceforge.net, Hugang <hugang@soulinfo.com>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: Help port swsusp to ppc.
Message-ID: <20040120100215.GA183@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost> <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux> <1074490463.10595.16.camel@gaston> <20040119204551.GB380@elf.ucw.cz> <1074555531.10595.89.camel@gaston> <20040120000435.GB837@elf.ucw.cz> <1074558590.11809.98.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074558590.11809.98.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > (1) There's routine during resume that copies pages to their old
> > locations. If you (would want to) have different kernel during resume,
> > how do you guarantee that that "kernel being resumed" does not use
> > memory ocupied by copying routine?
> 
> By having the copy routine sit elsewhere. You can have the copy routine
> be in a known location of the kernel beeing resumed (that is it uses
> its own copy routine) that is aligned on a page boundary and knows how
> to copy itself. Fairly trivial.

I said it is possible to solve. But "copy routine" becomes even more
nasty than it is already.

> > (2) Plus number of problems with devices grows with number of versions
> > squared. To guarantee it works properly you'd have to test all
> > combinations of "suspend kernel" and "resume kernel".
> 
> Why ? You aren't passing any device/driver information from the boot
> kernel and the resumed one... do you ?

I'm not passing device information, but devices *do* have internal
state. I quiesce them before booting new kernel, but there's probably
more than one way to quiesce devices...

> > [(1) Could be solved by reserving 4KB somewhere for copy routine, and
> > making sure copy routine is never bigger than 4KB etc. But I'd like to
> > keep it simple and really don't want to deal with (2).]
> 
> Then you don't wnat to do things properly...

No, I really do not want to make things more complicated in 2.6. And
you should not want to complicate it, too.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
