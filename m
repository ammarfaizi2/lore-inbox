Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTDPLmi (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 07:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbTDPLmi 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 07:42:38 -0400
Received: from [195.39.17.254] ([195.39.17.254]:8452 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id S264305AbTDPLmh 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 07:42:37 -0400
Date: Wed, 16 Apr 2003 13:52:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
       kernel list <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: PATCH: MTRR save and restore.
Message-ID: <20030416115250.GA241@elf.ucw.cz>
References: <20030407201311.GA177@elf.ucw.cz> <Pine.LNX.4.44.0304151313260.912-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304151313260.912-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'd like to see the rest of this thread ;)
> 
> > > > > We could add it to suspend scripts, but wouldn't mtrrs fit into the
> > > > > driver model idea? Would you say the same thing about implementing S3
> > > > > support?
> > > > 
> > > > I think going through the driver model is the right thing to
> > > > do.
> > > 
> > > It's useless bloat.
> 
> What exactly is useless bloat? Based on the level of indentation, I'd 
> assume that Richard said that...care to elaborate? 

Richard claims that MTRR save/restore is "useless bloat" and that it
can be don in userspace. He wants userland daemon to do it. I believe
that's bad idea (for reasons like suspend when battery low).

[This is what I said]
> > There's no helper daemon, nor I plan to make one. Notice that mtrr
> > stuff is shared between S3 (== suspend to ram) and swsusp. Both S3 and
> > swsusp can be used to do some pretty important stuff (machine
> > overheats or battery critically low -> suspend somewhere), so I do not
> > think userland daemon is good idea.
> > 
> > It can be dependend on CONFIG_PM; if you still think that's too much
> > bloat, it could be dependend on CONFIG_SLEEP which could be only
> > compiled when S3 or swsusp is selected (but I feel that would be
> > overdesign).
> 
> Yes, that's too much. 
> 
> MTRRs are one interface to an x86 CPU. CPUs are already represented in the
> device tree. The proper thing to do would be to have the CPU suspend/ 
> resume methods save and restore the MTRRs. It still requires an #ifdef in 
> the CPU code, but with a little work, could be massaged down a ways. 

Yep, agreed, mtrrs need in-kernel save/restore support.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
