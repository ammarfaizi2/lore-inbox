Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUCBW2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbUCBW2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:28:45 -0500
Received: from gprs40-190.eurotel.cz ([160.218.40.190]:34152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261979AbUCBW2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:28:43 -0500
Date: Tue, 2 Mar 2004 23:28:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kgdb: fix kgdbeth compilation and make it init late enough
Message-ID: <20040302222827.GD1225@elf.ucw.cz>
References: <20040302112500.GA485@elf.ucw.cz> <20040302153250.GE16434@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302153250.GE16434@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > CONFIG_NO_KGDB_CPUS can not be found anywhere in the patches => its
> > probably not needd any more.
> 
> I don't know if we can do that.  There's some funky locking stuff done
> on SMP, which for some reason can't be done to NR_CPUS (or, no one has
> tried doing that).

There was no CONFIG_NO_KGDB_CPUS anywhere else in the CVS, that means
that test could not have been right.

This could be related:

+#ifndef KGDB_MAX_NO_CPUS
+#if CONFIG_NR_CPUS > 8
+#error KGDB can handle max 8 CPUs
+#endif
+#define KGDB_MAX_NO_CPUS 8
+#endif

> > init_kgdboe can't be module_initcall; in
> > such cases it initializes after tg3 network card (and that's bad).
> 
> Ah, that's an even better fix than trying to enforce link order.
> 
> > Okay to commit?
> 
> Second half, yes.

I already commited both, sorry. 

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
