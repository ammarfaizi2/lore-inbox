Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTDOUID (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 16:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264062AbTDOUID 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 16:08:03 -0400
Received: from air-2.osdl.org ([65.172.181.6]:733 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264061AbTDOUIC 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 16:08:02 -0400
Date: Tue, 15 Apr 2003 13:18:17 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
       kernel list <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: PATCH: MTRR save and restore.
In-Reply-To: <20030407201311.GA177@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0304151313260.912-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd like to see the rest of this thread ;)

> > > > We could add it to suspend scripts, but wouldn't mtrrs fit into the
> > > > driver model idea? Would you say the same thing about implementing S3
> > > > support?
> > > 
> > > I think going through the driver model is the right thing to
> > > do.
> > 
> > It's useless bloat.

What exactly is useless bloat? Based on the level of indentation, I'd 
assume that Richard said that...care to elaborate? 

> > > Userspace should not need to know about mtrrs,
> > 
> > It's a swsuspend helper daemon, not some random application. There
> > *should* be a helper daemon, if not, the design is flawed.

Care to elaborate on that one, too? What does a userland daemon add to 
make it a sane design? 

> There's no helper daemon, nor I plan to make one. Notice that mtrr
> stuff is shared between S3 (== suspend to ram) and swsusp. Both S3 and
> swsusp can be used to do some pretty important stuff (machine
> overheats or battery critically low -> suspend somewhere), so I do not
> think userland daemon is good idea.
> 
> It can be dependend on CONFIG_PM; if you still think that's too much
> bloat, it could be dependend on CONFIG_SLEEP which could be only
> compiled when S3 or swsusp is selected (but I feel that would be
> overdesign).

Yes, that's too much. 

MTRRs are one interface to an x86 CPU. CPUs are already represented in the
device tree. The proper thing to do would be to have the CPU suspend/ 
resume methods save and restore the MTRRs. It still requires an #ifdef in 
the CPU code, but with a little work, could be massaged down a ways. 


	-pat

