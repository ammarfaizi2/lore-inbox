Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967711AbWLEHtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967711AbWLEHtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 02:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967725AbWLEHtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 02:49:00 -0500
Received: from twin.jikos.cz ([213.151.79.26]:44907 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967711AbWLEHs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 02:48:59 -0500
Date: Tue, 5 Dec 2006 08:48:30 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Neil Brown <neilb@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm2
In-Reply-To: <17780.61551.896455.157225@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0612050844110.28502@twin.jikos.cz>
References: <20061128020246.47e481eb.akpm@osdl.org>
 <Pine.LNX.4.64.0611290147400.28502@twin.jikos.cz> <17780.52337.767875.963882@cse.unsw.edu.au>
 <17780.61551.896455.157225@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006, Neil Brown wrote:

> As Andrew correctly pointed out, this bit error is not a RAM problem. It 
> is actually the low bit of a counter a spinlock that was decremented 
> just before the WARN_ON.  So it simply indicates that the inode had 
> already been freed, which I think we knew already. Unfortunately I still 
> have no idea why that inode had been freed but was still referenced by a 
> dentry.... How repeatable as this bug?  How did you narrow it down to 
> that patch? Did you use git-bisect or something else?

When this happened, I just looked at the broken-out patches in -mm, which 
ones touch the md subsystem, found your patch, reverse-applied it, and 
this stopped happening.

It seemed to be 100% reproducible - happened on every boot of FC6 system, 
so it was probably triggered by some raid/lvm command executed from init 
scripts after boot, but I didn't examine it further.

As soon as I get to the machine where this happens, I will try to narrow 
it down to the exact userspace command that triggers it and will let you 
know (probably this evening).

-- 
Jiri Kosina
