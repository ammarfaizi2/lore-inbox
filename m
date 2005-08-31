Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVHaHBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVHaHBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVHaHBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:01:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:11238 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932399AbVHaHBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:01:35 -0400
Date: Wed, 31 Aug 2005 09:01:32 +0200
From: Juergen Quade <quade@hsnr.de>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: inotify and IN_UNMOUNT-events
Message-ID: <20050831070132.GA10327@hsnr.de>
References: <20050830194632.GA13346@hsnr.de> <1125459207.32272.114.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125459207.32272.114.camel@phantasy>
User-Agent: Mutt/1.5.6+20040907i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:62881f34614f951289f18c8df869d6ac
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ...
> > results in two events:
> > 1. IN_DELETE_SELF (mask=0x0400)
> > 2. IN_IGNORED     (mask=0x8000)
> > 
> > Any ideas?
> 
> "/mnt" is not unmounted, stuff inside of it is.
> 
> Watch, say, "/mnt/foo/bar" and when /dev/hda1 is unmounted, you will get
> an IN_UNMOUNT on the watch.

I tried that too. Seems not to work (at least for me):

	root@mobil:/tmp/inotify-utils-0.25 # mount /dev/hda6 /mnt
	root@mobil:/tmp/inotify-utils-0.25 # ls /mnt/foo/bar
	/mnt/foo/bar
	root@mobil:/tmp/inotify-utils-0.25 # ./inotify_test /mnt/foo/bar &
	inotify device fd = 3
	/mnt/foo/bar WD=1
	[1] 8454
	root@mobil:/tmp/inotify-utils-0.25 # umount /dev/hda6
	read = 32
	sizeof inotify_event = 16
	pevent->len = 0
	pevent->len = 0
	EVENT ON WD=1
	DELETE_SELF (file) 0x00000400

	EVENT ON WD=1
	IGNORED (file) 0x00008000

	root@mobil:/tmp/inotify-utils-0.25 #

  Juergen.
