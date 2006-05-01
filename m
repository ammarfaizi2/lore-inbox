Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWEAGO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWEAGO6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 02:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWEAGO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 02:14:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751280AbWEAGO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 02:14:57 -0400
Date: Sun, 30 Apr 2006 23:13:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: torvalds@osdl.org, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 004 of 11] md: Increase the delay before marking
 metadata clean, and make it configurable.
Message-Id: <20060430231303.6b2bce82.akpm@osdl.org>
In-Reply-To: <17493.42109.153523.381980@cse.unsw.edu.au>
References: <20060501152229.18367.patches@notabene>
	<1060501053019.22949@suse.de>
	<20060430224404.1060d29a.akpm@osdl.org>
	<17493.42109.153523.381980@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
>  On Sunday April 30, akpm@osdl.org wrote:
>  > NeilBrown <neilb@suse.de> wrote:
>  > >
>  > > 
>  > > When a md array has been idle (no writes) for 20msecs it is marked as
>  > > 'clean'.  This delay turns out to be too short for some real
>  > > workloads.  So increase it to 200msec (the time to update the metadata
>  > > should be a tiny fraction of that) and make it sysfs-configurable.
>  > > 
>  > > 
>  > > ...
>  > > 
>  > > +   safe_mode_delay
>  > > +     When an md array has seen no write requests for a certain period
>  > > +     of time, it will be marked as 'clean'.  When another write
>  > > +     request arrive, the array is marked as 'dirty' before the write
>  > > +     commenses.  This is known as 'safe_mode'.
>  > > +     The 'certain period' is controlled by this file which stores the
>  > > +     period as a number of seconds.  The default is 200msec (0.200).
>  > > +     Writing a value of 0 disables safemode.
>  > > +
>  > 
>  > Why not make the units milliseconds?  Rename this to safe_mode_delay_msecs
>  > to remove any doubt.
> 
>  Because umpteen years ago when I was adding thread-usage statistics to
>  /proc/net/rpc/nfsd I used milliseconds and Linus asked me to make it
>  seconds - a much more "obvious" unit.  See Email below.
>  It seems very sensible to me.

That's output.  It's easier to do the conversion with output.  And I guess
one could argue that lots of people read /proc files, but few write to
them.

Generally I don't think we should be teaching the kernel to accept
pretend-floating-point numbers like this, especially when a) "delay in
milliseconds" is such a simple concept and b) it's so easy to go from float
to milliseconds in userspace.

Do you really expect that humans (really dumb ones ;)) will be echoing
numbers into this file?  Or will it mainly be a thing for mdadm to fiddle
with?
