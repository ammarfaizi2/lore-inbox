Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVIJKUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVIJKUz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 06:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVIJKUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 06:20:55 -0400
Received: from mx1.suse.de ([195.135.220.2]:30888 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750742AbVIJKUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 06:20:54 -0400
From: Andi Kleen <ak@suse.de>
To: Borislav Petkov <petkov@uni-muenster.de>
Subject: Re: [PATCH] [2.6.13-mm2] set IBM ThinkPad extras to default n in Kconfig
Date: Sat, 10 Sep 2005 12:20:39 +0200
User-Agent: KMail/1.8
Cc: Roman Zippel <zippel@linux-m68k.org>, "Brown, Len" <len.brown@intel.com>,
       akpm@osdl.org, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <F7DC2337C7631D4386A2DF6E8FB22B30048FA292@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.61.0509091817220.3743@scrub.home> <20050910094259.GA16051@gollum.tnic>
In-Reply-To: <20050910094259.GA16051@gollum.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509101220.40008.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 September 2005 11:42, Borislav Petkov wrote:
> On Fri, Sep 09, 2005 at 06:25:00PM +0200, Roman Zippel wrote:
> > The best would be to avoid using defaults completely, unless the
> > resulting kernel is non-functional (e.g. it doesn't compile or boot).
> > So far it's still the responsibility of the user to explicitly turn
> > everything on he needs (at least until we have a functional autoconfig).
> > BTW distros are not the only users, from them I would expect how to
> > configure a kernel.
>
> Actually, this sounds pretty sane and IMHO is somehow the biggest common
> denominator concerning linux users and their kernel configuration
> recreational activities :); but seriously, going all over the menus of
> Kbuild and turning everything off is a lot of work compared to turning on
> the several things I need on my system. "default m" is also not a good
> thing since compiling of unnecessary modules is simply dumb for a system
> that's just not going to use them.

The new driver dcdbas driver in -git9 seems to have inherited that bad habit 
too. Grr ... Patch appended.

Roman - can you perhaps just forbod default m in Kconfig? I don't think it 
makes any sense.

-Andi

Don't set dcdbas driver to default m

It's nasty to set random drivers to default m because people
who just press enter on make oldconfig get these.
Remove the default m

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/drivers/firmware/Kconfig
===================================================================
--- linux.orig/drivers/firmware/Kconfig
+++ linux/drivers/firmware/Kconfig
@@ -71,7 +71,6 @@ config DELL_RBU
 config DCDBAS
 	tristate "Dell Systems Management Base Driver"
 	depends on X86 || X86_64
-	default m
 	help
 	  The Dell Systems Management Base Driver provides a sysfs interface
 	  for systems management software to perform System Management
