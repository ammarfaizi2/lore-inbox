Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVA0M4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVA0M4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 07:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVA0M4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 07:56:15 -0500
Received: from holomorphy.com ([66.93.40.71]:26092 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262603AbVA0MxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 07:53:05 -0500
Date: Thu, 27 Jan 2005 04:52:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050127125254.GZ10843@holomorphy.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <20050126172538.GN10843@holomorphy.com> <20050127050927.GR10843@holomorphy.com> <16888.46184.52179.812873@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16888.46184.52179.812873@alkaid.it.uu.se>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>> There's a long discussion here, in which no one appears to have noticed
>> that SHLIB_BASE does not exist in mainline. Is anyone else awake here?

On Thu, Jan 27, 2005 at 10:29:12AM +0100, Mikael Pettersson wrote:
> About the only kernel-level enforcement I would feel comfortable with is
> to have non-fixed mmap()s refuse to grab the _page_ at address 0. Any range
> larger than this is policy, and hence needs a user-space override mechanism.
> Also, if user-space wants to catch accesses in a larger region above 0 then
> it can do that itself, by checking the result of mmap(), or by doing a fixed
> mmap() at address 0 with suitable size and rwx protection disabled.

FIRST_USER_PGD_NR is a matter of killing the entire box dead where it
exists, not any kind of process' preference. Userspace should be
prevented from setting up vmas below FIRST_USER_PGD_NR. It has zero to
do with what userspace's own concerns, but rather the kernel trying to
avoid system-critical data from being stomped on by userspace. It would
be like accidentally allowing userspace to use the IDT for malloc() on
x86, destroying one's ability to handle interrupts, page faults, etc.,
to allow userspace to go below FIRST_USER_PGD_NR on ARM.


-- wli
