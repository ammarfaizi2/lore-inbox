Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWJ0XU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWJ0XU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWJ0XU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:20:28 -0400
Received: from mo-p04-ob.rzone.de ([81.169.146.178]:36832 "EHLO
	mo-p04-ob.rzone.de") by vger.kernel.org with ESMTP id S1750775AbWJ0XU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:20:27 -0400
Date: Sat, 28 Oct 2006 01:12:03 +0200 (MEST)
From: Olaf Hering <olaf@aepfle.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Message-ID: <20061027231200.GA16102@aepfle.de>
References: <20061027010252.GV27968@stusta.de> <20061027012058.GH5591@parisc-linux.org> <20061026182838.ac2c7e20.akpm@osdl.org> <20061026191131.003f141d@localhost.localdomain> <20061027170748.GA9020@kroah.com> <20061027172219.GC30416@elf.ucw.cz> <20061027113908.4a82c28a.akpm@osdl.org> <20061027114144.f8a5addc.akpm@osdl.org> <20061027114237.d577c153.akpm@osdl.org> <1161989970.16839.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1161989970.16839.45.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, Alan Cox wrote:

> Ar Gwe, 2006-10-27 am 11:42 -0700, ysgrifennodd Andrew Morton:
> > IOW, we want to be multithreaded _within_ an initcall level, but not between
> > different levels.
> 
> Thats actually insufficient. We have link ordered init sequences in
> large numbers of driver subtrees (ATA, watchdog, etc). We'll need
> several more initcall layers to fix that.

Is it time for something better?
True dependencies, an addition to or as replacement for module_init()?
random example: hfs/super.c:
depends_on_initialized(init_hfs_fs: init_hfsplus_fs,kmem_cache_thingie,core_filesystem_thingie,foo,bar,worldpeace);
If init_hfsplus_fs() does not exist it should be no error.

Whatever the sytax will be and however its parsed during build, that link order
requirement bites every other month.
