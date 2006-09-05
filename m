Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWIEGov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWIEGov (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 02:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWIEGov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 02:44:51 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:46319 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750708AbWIEGot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 02:44:49 -0400
Date: Tue, 5 Sep 2006 08:40:42 +0200
From: Voluspa <lista1@comhem.se>
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, arjan@linux.intel.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: [PATCH] lockdep: disable lock debugging when kernel state
 becomes untrusted
Message-Id: <20060905084042.20966381.lista1@comhem.se>
In-Reply-To: <20060813184159.b536736f.akpm@osdl.org>
References: <20060814030954.c3a57e05.lista1@comhem.se>
	<20060813184159.b536736f.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 18:41:59 -0700 Andrew Morton wrote:
> On Mon, 14 Aug 2006 03:09:54 +0200
> Voluspa wrote:
> 
> > On 2006-07-10 21:02:59 git-commits-head received:
> > > commit 2c16e9c888985761511bd1905b00fb271169c3c0
> > > tree e17756b3ed27b0f4953547c39cf46864cdd6f818
> > > parent e54695a59c278b9ff48cd4b263da7a1d392f5061
> > > author Arjan van de Ven Mon, 10 Jul 2006
> > > 18:45:42 -0700 committer Linus Torvalds Tue, 11
> > > Jul 2006 03:24:27 -0700
> > >
> > > [PATCH] lockdep: disable lock debugging when kernel state becomes
> > > untrusted
> > >
> > > Disable lockdep debugging in two situations where the integrity
> > > of the kernel no longer is guaranteed: when oopsing and when
> > > hitting a tainting-condition.  The goal is to not get weird
> > > lockdep traces that don't make sense or are otherwise
> > > undebuggable, to not waste time.
> > >
> > > Lockdep assumes that the previous state it knows about is valid to
> > > operate, which is why lockdep turns itself off after the first
> > > violation it reports, after that point it can no longer make that
> > > assumption.
> > >
> > > A kernel oops means that the integrity of the kernel compromised;
> > > in addition anything lockdep would report is of lesser importance
> > > than the oops.
> > >
> > > All the tainting conditions are of similar integrity-violating
> > > nature and also make debugging/diagnosing more difficult.
> > 
> > On my x86_64 notebook I need ndiswrapper. No but-s, if-s or
> > anything-s. Period. I also have to work outside of X in a clean
> > terminal (console).
> > 
> > This patch unfortunately creates a 'pipe' directly from
> >  /var/log/messages to the screen. So if I work in a textbased
> > program, and something happens in the log, the program gets a
> > broken interface. Programs that simultaniously output to the log
> > becomes unusable.
> > 
> > It is also darn irritating when text strings materializes at the
> > shell prompt...
> > 
> > Once the 'pipe' is established (by tainting) it can not be reverted
> > by eg rmmod ndiswrapper.
> > 
> > I haven't even enabled any lockdep debugging:
> 
> That would appear to be a bug.  debug_locks_off() is running
> console_verbose() waaaay after the locking selftest code has
> completed.

The possibly final -rc6 is likewise broken. What would it take to incur
some respect for us, the millions of users effected by this shit?
Should we all become quasi-developers and bombard lkml with patches
that taint the kernel whenever some of the Intel binary blobs are
loaded?

Would that cluebat Arjan off of his high horse?

Mvh
Mats Johannesson
