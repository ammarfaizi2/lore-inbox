Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbWJ1FJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWJ1FJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 01:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWJ1FJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 01:09:09 -0400
Received: from colo.lackof.org ([198.49.126.79]:11210 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751791AbWJ1FJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 01:09:07 -0400
Date: Fri, 27 Oct 2006 23:09:05 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Message-ID: <20061028050905.GB5560@colo.lackof.org>
References: <20061027012058.GH5591@parisc-linux.org> <20061026182838.ac2c7e20.akpm@osdl.org> <20061026191131.003f141d@localhost.localdomain> <20061027170748.GA9020@kroah.com> <20061027172219.GC30416@elf.ucw.cz> <20061027113908.4a82c28a.akpm@osdl.org> <20061027114144.f8a5addc.akpm@osdl.org> <20061027114237.d577c153.akpm@osdl.org> <1161989970.16839.45.camel@localhost.localdomain> <20061027160626.8ac4a910.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027160626.8ac4a910.akpm@osdl.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 04:06:26PM -0700, Andrew Morton wrote:
> On Fri, 27 Oct 2006 23:59:30 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Ar Gwe, 2006-10-27 am 11:42 -0700, ysgrifennodd Andrew Morton:
> > > IOW, we want to be multithreaded _within_ an initcall level, but not between
> > > different levels.
> > 
> > Thats actually insufficient. We have link ordered init sequences in
> > large numbers of driver subtrees (ATA, watchdog, etc). We'll need
> > several more initcall layers to fix that.
> > 
> 
> It would be nice to express those dependencies in some clearer and less
> fragile manner than link order.  I guess finer-grained initcall levels
> would do that, but it doesn't scale very well.

Would making use of depmod data be a step in the right direction?
ie nic driver calls extern function (e.g. pci_enable_device())
and therefore must depend on module which provides that function.

My guess is this probably isn't 100% sufficient to replace all initcall
levels.  But likely sufficient within a given initcall level.
My main concern are circular dependencies (which are rare).

> But whatever.  I think multithreaded probing just doesn't pass the
> benefit-versus-hassle test, sorry.   Make it dependent on CONFIG_GREGKH ;)

Isn't already? :)

I thought parallel PCI and SCSI probing on system with multiple NICs and
"SCSI" storage requires udev to create devices with consistent naming.

thanks,
grant
