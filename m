Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbTLLOAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 09:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265235AbTLLOAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 09:00:12 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:7607 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265149AbTLLN60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:58:26 -0500
Date: Fri, 12 Dec 2003 14:56:09 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Rob Landley <rob@landley.net>
Cc: Hua Zhong <hzhong@cisco.com>, "'Andy Isaacson'" <adi@hexapodia.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031212135609.GE6112@wohnheim.fh-wedel.de>
References: <20031211125806.B2422@hexapodia.org> <200312111432.12683.rob@landley.net> <20031212125513.GC6112@wohnheim.fh-wedel.de> <200312120739.25162.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200312120739.25162.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 December 2003 07:39:25 -0600, Rob Landley wrote:
> On Friday 12 December 2003 06:55, Jörn Engel wrote:
> >
> > Yes, the obvious and stupid implementation has a ton of problems.
> > Most likely the right approach is some sort of background deamon
> > (garbage collector, defragmenter, journald, whatever you may call it)
> > that does exacly this even after the fact for the last unchecked
> > writes.  Asyncronous under load, possibly even synchronous when almost
> > idle.
> 
> Actually, I'd planned on implementing a cron job that could do it.  We're 
> talking a dozen lines of Python code (which can be optimized to only look at 
> files with timestamps since the last time it ran).  And doesn't need anything 
> from the kernel but the syscall...

...and it sucks.  Same problem as with updatedb - 99% of all work is
bogus, but you don't know which 99%, because the one knowing about it,
the kernel, doesn't tell you a thing.

Maybe a simple notification mechanism would sufficiently solve this as
well, so all the rest can be done in userspace.  Basically a file with
a simple format like this:
#path	offset	len
/tmp/foo	0	12

Meaning that bytes 0-11 of /tmp/foo have changed in whatever way.

Something like that, the details don't matter too much.

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon
