Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbSIXMFP>; Tue, 24 Sep 2002 08:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261652AbSIXMFP>; Tue, 24 Sep 2002 08:05:15 -0400
Received: from ns.suse.de ([213.95.15.193]:2062 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261651AbSIXMFO>;
	Tue, 24 Sep 2002 08:05:14 -0400
To: Andrew Pimlott <andrew@pimlott.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nanosecond resolution for stat(2)
References: <20020923214836.GA8449@averell.suse.lists.linux.kernel> <20020924040528.GA22618@pimlott.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Sep 2002 14:10:27 +0200
In-Reply-To: Andrew Pimlott's message of "24 Sep 2002 06:19:13 +0200"
Message-ID: <p731y7jtwp8.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Pimlott <andrew@pimlott.net> writes:
> 
> I assume you mean "theoretical" that an application would care, not
> that it would happen.  (Unless I misunderstand, it is nearly
> guaranteed to happen every time an inode is evicted after a
> [mac]time update.)

Only when you use an old file system. I tguess even ext2 and ext3 will
learn about nsec timestamps eventually (e.g. by increasing the inode to
the next power of two because there are many other contenders for new
inode fields too) 

> 
> I fear that there are applications that will be harmed by any
> spurious change in [mac]time, even if it's not backwards.  Apps that

When they only look at the second part nothing will change for them.

If applications that do look at nsecs have serious problems with this
backwards jumping it's still possible to add upwards rounding. I didn't
want to do this for the first cut to avoid over engineering.
> 
> > If it should be one in practice 
> > it could be fixed by rounding the time up in this case.
> 
> This would mean that even "legacy" programs that only use second
> resolution would be affected, which seems worse.  At least programs
> that recognize the nanosecond field are more likely to know about
> the issue.

Well, there is some change in behaviour. You have to live with that.

-Andi
