Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWCJRN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWCJRN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbWCJRN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:13:28 -0500
Received: from mx1.suse.de ([195.135.220.2]:19348 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751874AbWCJRN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:13:27 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [Patch 2/4] Basic reorder infrastructure - makes linking very slow
Date: Fri, 10 Mar 2006 10:45:57 +0100
User-Agent: KMail/1.9.1
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org
References: <1141053825.2992.125.camel@laptopd505.fenrus.org> <49447.194.237.142.21.1141057876.squirrel@194.237.142.21> <1141060775.2992.149.camel@laptopd505.fenrus.org>
In-Reply-To: <1141060775.2992.149.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603101045.58667.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 18:19, Arjan van de Ven wrote:
> On Mon, 2006-02-27 at 17:31 +0100, sam@ravnborg.org wrote:
> > > This patch puts the infrastructure in place to allow for a reordering of
> > > functions based inside the vmlinux.
> > 
> > Can we make this general instead of x86_64 only?
> > Then we can use Kconfig to enable it for the architectures where we want it.
> 
> Actually Linus had pretty good arguments to make this per-architecture:
> the list will be different on each architecture.
> 
> (eg my first patch had it more generic; but Linus asked it to be per
> arch, and I agree with the reasons he gave)
> 
> Also I doubt it can be enabled "blindly" for all architectures; I expect
> more to need hacks similar to the x86_64 entry.S fix before it can
> work...

Hi,

I just discovered that this patch is the reason why my compiles slowed
down so dramatically (thanks to Michael M. for the hint) 
The SUSE 10.0 ld goes from running in seconds to more than a minute.

I think I will drop this patch for now because I doubt the
runtime improvement is worth the compile slowdown.

If there is some binutils  release that handles this without dramatic
slowdown we can test for it in the Makefile, but i don't want it 
to be enabled by default.

-Andi

