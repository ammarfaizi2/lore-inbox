Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbTGIPxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 11:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268383AbTGIPxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 11:53:47 -0400
Received: from 12-226-168-214.client.attbi.com ([12.226.168.214]:48779 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP id S266058AbTGIPxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 11:53:45 -0400
Date: Wed, 9 Jul 2003 12:08:23 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: modutils-2.3.15 'insmod'
Message-ID: <20030709160823.GC267@kurtwerks.com>
References: <Pine.LNX.4.53.0307091119450.470@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307091119450.470@chaos>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Richard B. Johnson:
> 
> modutils-2.3.15, and probably later, has a bug that can prevent
> modules from being loaded from initrd, this results in not
> being able to mount a root file-system. The bug assumes that
> malloc() will return a valid pointer when given an allocation
> size of zero.

This isn't a bug. The standard allow returning a non-null pointer
for malloc(0).

> When there are no modules loaded, insmod scans for modules
> and allocates data using its xmalloc() based upon the number
> of modules found. If the number was 0, it attempts to allocate
> 0 bytes (0 times the size of a structure). If malloc() returns
> NULL (and it can, probably should), xmalloc() will write an
> "out of memory" diagnostic and call exit().
> 
> The most recent `man` pages that RH 9.0 distributes states that
> malloc() can return either NULL of a pointer that is valid for
> free(). This, of course, depends upon the 'C' runtime library's
> malloc() implementation.

Perhaps, but IIRC, the rationale in the GNU C library was that
existing programs assume malloc(0) != 0, which allows you to call
realloc on the pointer. Returning NULL only makes sense if the 
malloc() call fails.

> It is likely that malloc(0) returning a valid pointer is a bug
> that has prevented this problem from being observed. Such a
> bug in malloc() is probably necessary to keep legacy software

Not a bug. Bad design perhaps, but not a bug.

> running, but new software shouldn't use such atrocious side-effects.
> An allocation of zero needs to be discovered and fixed early
> in code design.

Kurt
-- 
If you sit down at a poker game and don't see a sucker, get up.  You're
the sucker.
