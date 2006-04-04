Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWDDJl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWDDJl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWDDJl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:41:26 -0400
Received: from ns2.suse.de ([195.135.220.15]:60899 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932433AbWDDJl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:41:26 -0400
Date: Tue, 4 Apr 2006 11:41:24 +0200
From: Olaf Hering <olh@suse.de>
To: John Mylchreest <johnm@gentoo.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060404094124.GA22332@suse.de>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de> <20060402105859.GN16917@getafix.willow.local> <20060402111002.GA30017@suse.de> <20060402112002.GA3443@getafix.willow.local> <20060402114215.GA30491@suse.de> <20060404085729.GH3443@getafix.willow.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060404085729.GH3443@getafix.willow.local>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Apr 04, John Mylchreest wrote:

> On Sun, Apr 02, 2006 at 01:42:15PM +0200, Olaf Hering <olh@suse.de> wrote:
> >  On Sun, Apr 02, John Mylchreest wrote:
> > 
> > > Going from that, I can push a patch for gcc upstream to remove the
> > > __KERNEL__ dep, but gcc4.1 ships with ssp by standard, and the semantics
> > > between the IBM patch for SSP applied to gcc-3 and ggc-4 have changed.
> > 
> > gcc4.1 has no obvious problems with --enable-ssp
> > 
> > > -fno-stack-protector would work for gcc4, but for gcc3 it could still be
> > > patially enabled, and requires -fno-stack-protector-all. Mind If I ask
> > > whats incorrect about defining __KERNEL__ for the bootcflags?
> > 
> > arch/powerpc/boot is no kernel code, its supposed to be selfcontained.
> > Prepare a patch which uses the cc-option macro.
> 
> As requested, please see attached a small patch which rectifies this
> with negating cflags. The cc-option macro won't always work, and as such
> I have declared a new macro to honour $(CROSS32CC).

I think this should go into the main makefile, HOSTCFLAGS or similar. If
you look around quickly in the gentoo bugzilla, all non-userland
packages (grub, xen, kernel etc.) require the -fno-feature.
