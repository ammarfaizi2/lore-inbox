Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbSJXHTR>; Thu, 24 Oct 2002 03:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbSJXHTR>; Thu, 24 Oct 2002 03:19:17 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:39613 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265333AbSJXHTP>;
	Thu, 24 Oct 2002 03:19:15 -0400
Date: Thu, 24 Oct 2002 13:08:35 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: Richard J Moore <richardj_moore@uk.ibm.com>,
       Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>
Subject: Re: 2.4 Ready list - Kernel Hooks
Message-ID: <20021024130835.A30737@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <OF4A3346AB.B9CBFE3E-ON80256C5B.005B118D@portsmouth.uk.ibm.com> <20021023165009.I1421@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021023165009.I1421@almesberger.net>; from wa@almesberger.net on Wed, Oct 23, 2002 at 09:50:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Oct 23, 2002 at 09:50:15PM +0000, Werner Almesberger wrote:
> Oops, missed that one, sorry ! I was looking at the interface
> functions, but making the hooks themselves GPL-only is even
> better.
>
Yes, I have done that in the latest patch.
 
> > I don't envisage having an arbitrary set of hook points scattered
> > throughout the kernel.
> 
> Let's hope you're right :-)
> 
kernelhooks is similar to notifier lists (include/linux/notifier.h),
only much faster when there are no users. This patch does not
add any hooks itself, I am sure placement of each hook will be
critically reviewed.

> But wouldn't a small extension of kprobes get you pretty much
> the same functionality/performance:
>
> <snip nice idea>
>
Yes, this is possible, but I think using hooks is much cleaner.

> The advantage over hooks would be that users of this mechanism
> wouldn't have to choose between fast but intrusive (hooks) and
> slow but flexible (probes).
> 
As I see it, hooks should be used for allowing other kernel code
to tap into certain well defined paths in the kernel, say in
trap 3 or trap 1 handlers in the kernel to allow multiple 
kernel-level breakpointing tools. Or, certain well defined paths
(potentially fast paths) for traceing purposes, where it is 
necessary to ensure that for the most time there are no users 
of these hooks and their placement alone should place minimal 
overhead.

So, hooks are designed, placed at well thought-out locations.
Probes OTOH are mostly ad-hoc. While debugging a problem, if
you find the need to probe a specific code location for more
info, put a probe there, on the fly, with out going through 
the recompile and reboot cycle.

> Now, it's non-trivial to do a "return from caller" with
> [kd]probes. I haven't looked at that part yet. Do you have the
> infrastructure for this ?
> 
No, returning from caller will be much harder with [kd]probes.

Hope this clarifies the issue.

Thanks,
Vamsi.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
