Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSIXENB>; Tue, 24 Sep 2002 00:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261546AbSIXENB>; Tue, 24 Sep 2002 00:13:01 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:59098 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S261545AbSIXENA>; Tue, 24 Sep 2002 00:13:00 -0400
Date: Tue, 24 Sep 2002 00:05:28 -0400
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nanosecond resolution for stat(2)
Message-ID: <20020924040528.GA22618@pimlott.net>
Mail-Followup-To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <20020923214836.GA8449@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020923214836.GA8449@averell>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 11:48:36PM +0200, Andi Kleen wrote:
> The kernel internally always keeps the nsec (or rather 1ms) resolution
> stamp. When a filesystem doesn't support it in its inode (like ext2) 
> and the inode is flushed to disk and then reloaded then an application
> that is nanosecond aware could in theory see a backwards jumping time.
> I didn't do anything anything against that yet, because it looks more
> like a theoretical problem for me.

I assume you mean "theoretical" that an application would care, not
that it would happen.  (Unless I misunderstand, it is nearly
guaranteed to happen every time an inode is evicted after a
[mac]time update.)

I fear that there are applications that will be harmed by any
spurious change in [mac]time, even if it's not backwards.  Apps that
trigger on any change in mtime may trigger twice for every change.
Eg, I suspect there is some scenario in which an rsync-like
application that supports nanoseconds could suffer (just in
performance, but still).

> If it should be one in practice 
> it could be fixed by rounding the time up in this case.

This would mean that even "legacy" programs that only use second
resolution would be affected, which seems worse.  At least programs
that recognize the nanosecond field are more likely to know about
the issue.

Andrew
