Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbUBYBPF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbUBYBPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:15:04 -0500
Received: from [66.35.79.110] ([66.35.79.110]:60385 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262561AbUBYBPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:15:00 -0500
Date: Tue, 24 Feb 2004 17:14:51 -0800
From: Tim Hockin <thockin@hockin.org>
To: Glen Turner <glen.turner@aarnet.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: report NGROUPS_MAX via a sysctl (read-only)
Message-ID: <20040225011451.GA29101@hockin.org>
References: <20040220023927.GN9155@sun.com> <20040219213028.42835364.akpm@osdl.org> <20040220063519.GP9155@sun.com> <20040219224752.44da2712.akpm@osdl.org> <20040220071028.GA4948@hockin.org> <1077670767.24730.51.camel@andromache>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077670767.24730.51.camel@andromache>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 11:29:27AM +1030, Glen Turner wrote:
> The mere existence of the value means it can be used correctly
> in application code for sanity checking.

Andrew seems to have picked it up for -mm.  I sent a patch to glibc-bugs (is
that the right place?  any libc folk?) to use the new sysctl in
sysconf(_SC_NGROUPS_MAX).  So if/when all those releases converge, you
should be able to get the kernel's idea of NGROUPS_MAX from
sysconf(_SC_NGROUPS_MAX);

> Returning INT_MAX for NGROUPS_MAX isn't wrong, but you
> then can't blame user space for making inefficient choices
> if the kernel limit is actually smaller.

Well, if the kernel HAS no limit, then NGROUPS_MAX really is INT_MAX.  There
are not many legit uses I can think of for userspace to actually care about
NGROUPS_MAX.  Just the current number of groups, which is easily gotten via
setgroups().

Now that the sysctl is in, it's a very tiny patch to make ngroups_max
actually raisable/ by sysctl, though it is debatable whether it is useful AT
ALL, and dubious whether it is safe to lower that value after any apps are
running.

-- 
Tim Hockin
thockin@hockin.org
Soon anyone who's not on the World Wide Web will qualify for a government 
subsidy for the home-pageless.
