Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWI1X0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWI1X0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWI1X0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:26:42 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:52743 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S1750851AbWI1X0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:26:41 -0400
Subject: Re: Tiny error in printk output for clocksource : a3:<6>Time:
	acpi_pm clocksource has been installed.
From: Joe Perches <joe@perches.com>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Greg KH <greg@kroah.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200609281819.43712.vda.linux@googlemail.com>
References: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com>
	 <200609281256.23175.vda.linux@googlemail.com>
	 <1159459694.5015.19.camel@localhost>
	 <200609281819.43712.vda.linux@googlemail.com>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 16:26:34 -0700
Message-Id: <1159485994.5015.95.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 18:19 +0200, Denis Vlasenko wrote:
> Actually, I think it makes sense to have both: yours for complicated
> cases (printk with lots of other %something) and mine for simple ones
> (no local variable, smaller code).
> > Strictly, not all MAC addresses are 6 byte.
> > Maybe all the Ethernet/TR addresses should use the
> > IEEE EUI48 designation?  That feels a bit like the
> > KiB/KB distinction, but it is technically correct.
> > Would a patch with an DEV6_ADDR->EUI48 substitution
> > be acceptable?
> Maybe. Doesn't look obvious, but if it is in standards...

I brought the RFC patch from several months ago forward
using the implicit stack var in DECLARE_EUI48.

It's quite large, > 300k.

The patches also use single printks for more messages so
that when CONFIG_PCI_MULTITHREAD_PROBE is set, message
lines won't be split.

I separated the patches into groups where the output is:
1-identical, 2-changed but likely harmless, and 3-other.

In some cases, mac addresses are formatted for use in
/proc and seq_printf either in lower case or with just
a "%x" instead of "%02X", or not colon separated.
It's not good to change those formats.

I'd like to agree on the form before posting.

implicit DECLARE_EUI48; and EUI48(address)
or
explicit DECLARE_EUI48(name) and EUI48(name, address)

Warts:

There are some new non-debug warnings that are generated
when using the stack automatic because some of the debug
printks don't get compiled and you get "unused variable"
warnings.

It's possible to remove the DECLARE_EUI48 completely
by not indirecting the formatting string
"%02X:%02X:%02X:%02X:%02X:%02X" to "%s" and a function,
but it increases the kernel or module size.

