Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbTHYSnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbTHYSnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:43:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:52410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262004AbTHYSnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:43:07 -0400
Date: Mon, 25 Aug 2003 11:38:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] limit some config options per arch.
Message-Id: <20030825113820.135217a7.rddunlap@osdl.org>
In-Reply-To: <p73smnp4mbr.fsf@oldwotan.suse.de>
References: <20030825111854.5c4afdac.rddunlap@osdl.org.suse.lists.linux.kernel>
	<p73smnp4mbr.fsf@oldwotan.suse.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Aug 2003 20:35:36 +0200 Andi Kleen <ak@suse.de> wrote:

| "Randy.Dunlap" <rddunlap@osdl.org> writes:
| 
| 
| > diff -Naur ./drivers/char/Kconfig~itcfg ./drivers/char/Kconfig
| > --- ./drivers/char/Kconfig~itcfg	Fri Aug 22 16:51:02 2003
| > +++ ./drivers/char/Kconfig	Mon Aug 25 10:48:21 2003
| > @@ -744,6 +744,7 @@
| >  
| >  config NVRAM
| >  	tristate "/dev/nvram support"
| > +	depends on !IA64
| 
| depends on X86 would be probably better.
| (if some other archs use it too they can add themselves)

OK, I'll change it.

| >  	---help---
| >  	  If you say Y here and create a character special file /dev/nvram
| >  	  with major number 10 and minor number 144 using mknod ("man mknod"),
| > @@ -1000,6 +1001,7 @@
| >  
| >  config HANGCHECK_TIMER
| >  	tristate "Hangcheck timer"
| > +	depends on X86
| 
| AFAIK that's not x86 specific. It should work on other architecture too.

from willy@debian.org:
This looks x86-specific to me,
monotonic_clock() is in arch/i386 and arch/x86_64 only.

| >  	  say Y. Information about this driver, especially important for IBM
| > diff -Naur ./drivers/pnp/Kconfig~itcfg ./drivers/pnp/Kconfig
| > --- ./drivers/pnp/Kconfig~itcfg	Fri Aug 22 16:56:13 2003
| > +++ ./drivers/pnp/Kconfig	Mon Aug 25 11:15:37 2003
| > @@ -2,6 +2,8 @@
| >  # Plug and Play configuration
| >  #
| >  
| > +if X86 && !X86_64
| 
| This should be if ISA && X86 && !X86_64

OK (after lunch...).

--
~Randy   [mantra:  Always include kernel version.]
"Everything is relative."
