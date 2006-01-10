Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWAJVSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWAJVSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWAJVSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:18:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:50852 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932263AbWAJVSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:18:46 -0500
From: Andi Kleen <ak@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Console debugging wishlist was: Re: oops pauser.
Date: Tue, 10 Jan 2006 22:18:30 +0100
User-Agent: KMail/1.8.2
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <20060105045212.GA15789@redhat.com> <200601102145.53967.ak@suse.de> <Pine.LNX.4.61.0601102200410.1000@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601102200410.1000@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601102218.30998.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 22:06, Jan Engelhardt wrote:

> If you now had a kernel-level pager that would jump in everytime an oops
> happened, control would normally not be given back to userspace unless we quit
> the pager. kdb has a similar behavior: it "stops" userspace until someone
> chooses to "c"ontinue.
> Therefore this pager would not be too good. In a panic, yes, it would be 
> perfect.

First for an recoverable oops there is no reason you couldn't use
schedule_timeout(). And for those you don't need it anyways
because you can as well use dmesg. For others you can use poll loops.

But it wasn't actually my point. If you get 
an problem during bootup - not necessarily an oops, but could
be also a no root panic or your SCSI controller not working or 
something else - and you can reproduce it it's a PITA to examine
the kernel output before because there is no way to get
enough scrollback.  For the oops itself it's not needed - it typically
fits on the screen. But if it happens every boot it would be nice
if you could just boot with "more" and then page through
the kernel output and check what's going on.

The feature would be mainly useful for problems during kernel bootup,
although it might be sometimes useful too e.g. when user space
hangs, but you want to page through the hotkey process dump
which might be longer than console scrollback.

Just more scrollback does not necessarily replace this because
sometimes youe end up with so much output so quickly (e.g. some errors
are very verbose) that any scrollback buffer would be overflown.

Now the only issue would be to work out when to use schedule_timeout
and when to use a delay, but that can be all distingushed with some code.

Anyways mind you - i suspect actually implementing this would be somewhat
ugly, so the chances of it actually getting in would be likely slim.
Still it would be often useful.

-Andi

