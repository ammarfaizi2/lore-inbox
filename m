Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUCMTYv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 14:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbUCMTXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 14:23:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49878 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263173AbUCMTXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 14:23:04 -0500
Date: Sat, 13 Mar 2004 14:43:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: joern@wohnheim.fh-wedel.de
Cc: Sytse Wielinga <s.b.wielinga@student.utwente.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH for testing] cow behaviour for hard links
Message-ID: <20040313134330.GC3352@openzaurus.ucw.cz>
References: <20040310193429.GB4589@wohnheim.fh-wedel.de> <200403121849.03505.s.b.wielinga@student.utwente.nl> <20040312182912.GB7087@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312182912.GB7087@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  - removed inheritance, as it's not useful in any way, not expected and breaks
> > linking of files with S_COWLINK set.
> 
> Not useful?  Without inheritance, I have to manually add the flag for
> every file/directory I add.  Each time I forget, writes go to both
> files and I notice the mess weeks later.  Naa, that's where we're now
> and why I created the patch in the first place.
> 
> What we do need, though, is a new errno.  -EMLINK is close, but still
> wrong.

I do not know your current design, but...

In ideal world there would be no COW links. System would
magically detect that you are doing cp -a, and would link
at individual block level.

Well, that would be probably too fs-specific. But introducing copyfile()
syscall, which would just link the inodes if underlying fs
supported it might be good start. On first
write into one
of linked files copy
would be done...

Only disadvantage I see is that such links would not survive
tar-backup...
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

