Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWBHAPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWBHAPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 19:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWBHAPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 19:15:20 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:60087 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030306AbWBHAPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 19:15:19 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 8 Feb 2006 01:16:12 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <nigel@suspend2.net>, Lee Revell <rlrevell@joe-job.com>,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602080027.09305.rjw@sisk.pl> <20060207235011.GB10520@elf.ucw.cz>
In-Reply-To: <20060207235011.GB10520@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602080116.12992.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 00:50, Pavel Machek wrote:
> 
> > > > themselves 
> > > > (and then have their patches rejected by you) is no way to maintain a part 
> > > > of the kernel. Stop being a liability instead of an asset!
> > > 
> > > Ugh?
> > > 
> > > Lee is a programmer. He wants faster swsusp, and improving uswsusp is
> > > currently best way to get that. It may be alpha/beta quality, but
> > > someone has to start testing, and Lee should be good for that (played
> > > with realtime kernels etc...). Actually it is in good enough state
> > > that I'd like non-programmers to test it, too.
> > 
> > I'd rather like to wait with that until there's a howto. :-)
> 
> Attached, now Lee or anyone can start hacking.
> 
> Suspend-to-disk HOWTO
> ~~~~~~~~~~~~~~~~~~~~
> Copyright (C) 2006 Pavel Machek <pavel@suse.cz>
> 
> 
> You'll need /dev/snapshot for these to work:
> 
> crw-r--r--  1 root root 10, 231 Jan 13 21:21 /dev/snapshot
> 
> Then compile userspace tools in usual way. You'll need an -mm kernel
> for now. To suspend-to-disk, run
> 
> ./suspend /dev/<your_swap_partition>
> 
> . (There should be just one, for now.) Suspend is easy, resume is
> slightly harder. Resume application has to be ran without any
> filesystems mounted rw, and without any journalling filesystems
> mounted at all, preferably from initrd (but read-only ext2 should do
> the trick, too). Resume is then as easy as running
> 
> ./resume /dev/<your_swap_partition>
> 
> . You probably want to create script that attempts to resume with
> above command, and if that fails, fall back to init.

If it's run fron an initrd, it'll fall back automatically.  Also you can set
the name of the resume partition in the header file swsusp.h and
you'll be able to use the tools without any command line
parameters (useful if you want to start resume from an initrd).

Besides, an -mm kernel is needed for this to work (preferrably
2.6.16-rc1-mm5, for now), and the CVS changes on a daily basis.

Greetings,
Rafael
