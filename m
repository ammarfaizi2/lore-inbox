Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTJAUkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 16:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTJAUkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 16:40:21 -0400
Received: from hockin.org ([66.35.79.110]:19721 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262190AbTJAUkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 16:40:17 -0400
Date: Wed, 1 Oct 2003 13:29:10 -0700
From: Tim Hockin <thockin@hockin.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Many groups patch.
Message-ID: <20031001202910.GA30014@hockin.org>
References: <20031001184610.GA25716@hockin.org> <Pine.LNX.4.44.0310011216530.24564-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310011216530.24564-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 12:22:03PM -0700, Linus Torvalds wrote:
> Augh. It also makes code even uglier than it used to be:
> 
> 	...
> 
> 	+               u16 group;
> 	+               if (copy_from_user(&group, grouplist+i, sizeof(group)))
> 	+                       return  -EFAULT;

I can change it to do a copy_from_user one block at a time, if you prefer...

> 	if (nr > TASK_SIZE / sizeof(group))
> 		return -EFAULT;
> 	if (!access_ok(grouplist, nr*sizeof(group))
> 		return -EFAULT;
> 	...
> 
> 		if (__get_user(group, grouplist + i))
> 			return -EFAULT;
> 	...

Or change it to this, which is the same 1-gid-at-a-time copy.  This code is
definitely SIMPLER than the 1-block-at-a-time copy.  I'll go with that.

> which really is so common that it _really_ should be in kernel/uid16.c
> (or, actually create a new kernel/gid16.c file) rather than copied 
> (incorrectly) to a lot of architectures. Then things like the above can be 
> done right once, rather than merging this that does the nasty thing over 
> and over.

I'd love to put it in uid16.c, but uid16.c is not used by the 64-bit
architectures.  I remember proposing a simple fix at one point and being
shot down.  I'd love to fix that up, but it's a separate patch.  If I
fix it up as suggested above, will you take it with the promise that I'll
find some way to do uid16 properly for the 64-bit arches and clean it up in
a followup patch?

> Sorry to just complain all the time,

I'm just glad it's getting attention - I'm dying to take this off my todo
list.

Tim
