Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965287AbWKDKfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbWKDKfe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 05:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbWKDKfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 05:35:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13023 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965287AbWKDKfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 05:35:33 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Subject: CTL_UNNUMBERED and killing sys_sysctl
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
Date: Sat, 04 Nov 2006 03:35:00 -0700
In-Reply-To: <20061103134633.a815c7b3.akpm@osdl.org> (Andrew Morton's message
	of "Fri, 3 Nov 2006 13:46:33 -0800")
Message-ID: <m1wt6bts8b.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> That has several typos and grammatical mistakes.
>
>> +	VM_MIN_INTERLEAVE=39,	/* Limit for interleave */
>
> I think we recently decided to set all new sysctl number to CTL_UNNUMBERED.
>  Eric, can you remind us of the thinkin there please?

Sure.  Sorry for the delay you buried the question well.

The basic thinking goes as follows.  To properly allocate the
numbers for the binary sysctl interface requires a lot of discipline that
we have proven that we don't always have.  Essentially no one uses
the binary sysctl interface anyway.  Therefore CTL_UNNUMBERED was
introduced so we don't need to allocate a binary sysctl number
to add a sysctl to the /proc/sys, interface.

This avoids approach patch decay before the patch is merged upstream.

So in general if you really need a new binary sysctl number the approach
should be first get your patch merged into Linus's tree and then get
an additional 3 line patch merged into Linus's tree to get your number.

I probably need to wake the conversation up again to see if we can make
the final determinate if we want to drop the binary sysctl interface
after having a long grace period, or simply commit to maintain it.  Linus's
tree still has the binary interface slated for removal in January 2007,
that was only appropriate when we believed there were no users in user space
that cared.

The big maintenance problem has been the bit rot of patches where
people allocate the next number and their patches take a long time to
get into Linus's tree.  So by the time they are merged the patches
conflict over which number they get, and by that time the code has
shipped with a binary interface in a distro kernel.

CTL_UNNUMBERED by freeing us from allocating the binary interface
and just using the file based one gives us a mechanism to solve that
maintenance problem.  I have not heard of a conflict of file names
under /proc/sys.

Andrew can we get the CTL_UNNUMBERED patches pushed up to Linus?

Eric
