Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293206AbSBWU4q>; Sat, 23 Feb 2002 15:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293205AbSBWU4e>; Sat, 23 Feb 2002 15:56:34 -0500
Received: from ns.suse.de ([213.95.15.193]:55056 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293204AbSBWU4Z>;
	Sat, 23 Feb 2002 15:56:25 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, lord@sgi.com
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014444810.1003.53.camel@phantasy.suse.lists.linux.kernel> <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel> <3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel> <3C77F503.1060005@sgi.com.suse.lists.linux.kernel> <3C77FB35.16844FE7@zip.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 23 Feb 2002 21:56:23 +0100
In-Reply-To: Andrew Morton's message of "23 Feb 2002 21:36:17 +0100"
Message-ID: <p73y9hjq5mw.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:
> > >
> > I can tell you that Irix has just such a global counter for the amount of
> > delayed allocate pages - and it gets to be a major point of cache contention
> > once you get to larger cpu counts. So avoiding that from the start would
> > be good.
> 
> Ah, good info.  Thanks.  I'll fix it with a big "FIXME" comment for now,
> fix it for real when Rusty's per-CPU infrastructure appears.

Just curious -- how do you want to fix it for real? 
As far as I can see a delalloc counter needs to be exact to avoid OOM
deadlocks, but making it per CPU would require doing the accounting inexact.

The only way I can imagine is to use the 'cookie jar' trick by grabbing
some amount per CPU and only going back to the global counter when the 
local jar is used up, but that seems to have some drawbacks too, like 
keeping a lot of pages free with higher CPU counts.

-Andi


