Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbULTDaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbULTDaN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 22:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbULTDaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 22:30:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:27293 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261401AbULTDaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 22:30:07 -0500
Date: Sun, 19 Dec 2004 19:30:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] back out CPU clock additions to posix-timers
In-Reply-To: <200412182202.iBIM2RaZ030987@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0412191923360.1580@schroedinger.engr.sgi.com>
References: <200412182202.iBIM2RaZ030987@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2004, Roland McGrath wrote:

> > Roland McGrath <roland@redhat.com> wrote:
> > >
> > > I really think we should not let the
> > > existing clockid_t encoding change get out in 2.6.10.
> >
> > So.. could you please send a patch which disables the userspace-visibility
> > of Christoph's changes?

I am not sure what the point of these is? The userspace visibility of the
regular posix clocks (positive clockid's) does not change. The way we
encode process cputime clocks as negative values changes but there is
nothing that supports my encoding yet (apart from my test code) since
the glibc patch was never accepted.

I would like to keep the support for all 4 standard posix clocks through
clockids 0-3 as listed in the kernel headers and simply have the cputime
clocks redirect to your code appropriately to get the current values for
each process. IMHO that makes the interface cleaner, is cleaner for glibc
since it allows simply to pass positive clockids through  and also
maintains compatibility for positive clockids to the existing situation.

