Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWBGXui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWBGXui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWBGXui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:50:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7572 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030290AbWBGXuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:50:37 -0500
Date: Wed, 8 Feb 2006 00:50:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, Lee Revell <rlrevell@joe-job.com>,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207235011.GB10520@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602071940.53843.nigel@suspend2.net> <20060207230245.GD2753@elf.ucw.cz> <200602080027.09305.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602080027.09305.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > themselves 
> > > (and then have their patches rejected by you) is no way to maintain a part 
> > > of the kernel. Stop being a liability instead of an asset!
> > 
> > Ugh?
> > 
> > Lee is a programmer. He wants faster swsusp, and improving uswsusp is
> > currently best way to get that. It may be alpha/beta quality, but
> > someone has to start testing, and Lee should be good for that (played
> > with realtime kernels etc...). Actually it is in good enough state
> > that I'd like non-programmers to test it, too.
> 
> I'd rather like to wait with that until there's a howto. :-)

Attached, now Lee or anyone can start hacking.

Suspend-to-disk HOWTO
~~~~~~~~~~~~~~~~~~~~
Copyright (C) 2006 Pavel Machek <pavel@suse.cz>


You'll need /dev/snapshot for these to work:

crw-r--r--  1 root root 10, 231 Jan 13 21:21 /dev/snapshot

Then compile userspace tools in usual way. You'll need an -mm kernel
for now. To suspend-to-disk, run

./suspend /dev/<your_swap_partition>

. (There should be just one, for now.) Suspend is easy, resume is
slightly harder. Resume application has to be ran without any
filesystems mounted rw, and without any journalling filesystems
mounted at all, preferably from initrd (but read-only ext2 should do
the trick, too). Resume is then as easy as running

./resume /dev/<your_swap_partition>

. You probably want to create script that attempts to resume with
above command, and if that fails, fall back to init.


-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
