Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbVLFMJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbVLFMJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbVLFMJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:09:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60839 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964956AbVLFMJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:09:44 -0500
Date: Tue, 6 Dec 2005 13:09:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051206120930.GM1770@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <200512052328.01999.rjw@sisk.pl> <1133831242.6360.15.camel@localhost> <20051206013759.GI1770@elf.ucw.cz> <1133834576.3896.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133834576.3896.26.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > root@amd:~# hdparm -t /dev/hda
> > 
> > /dev/hda:
> >  Timing buffered disk reads:  108 MB in  3.01 seconds =  35.85 MB/sec
> > 
> > > > Second, IMHO, some things you are doing in suspend2, like image encryption,
> > > > or accessing ordinary files, should not be implemented in the kernel.
> > > 
> > > Image encryption is just done using cryptoapi - I just expose the
> > > parameters and optionally save them in the image; there's no nous in
> > > suspend2 regarding encryption beyond that.
> > 
> > Unfortunately all these "small things" add up.
> 
> But so does doing it from userspace - you then have to make the pages
> available to the userspace program, implement encryption there, provide
> safety nets in case userspace dies unexpectedly and so on. There is a
> cost to encryption that occurs regardless of where we do the
> compressing.

Well, doing it in userspace means that you only pay kernel complexity
once; and then you can get encryption, compression, suspend-to-file
for free. And amount of kernel changes is surprisingly small.

Userspace recovery is not big problem, btw. First, userspace should
just work. It is doing suspend to disk, so it should better not
fail. Fortunately, during debugging I found out that being userspace
has big advantages: you can still use usual recover techniques after
segfault.

> > Interesting use, but for embedded app, they can just reserve partition
> > as well. [I have seen some patches doing that.]
> 
> For swap?

Yes. And then add some hacks to swapoff as soon as image is restored.

								Pavel
-- 
Thanks, Sharp!
