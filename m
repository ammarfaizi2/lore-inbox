Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbUCRQt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 11:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUCRQt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 11:49:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33197 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262701AbUCRQt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 11:49:57 -0500
Date: Thu, 18 Mar 2004 11:49:52 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
In-Reply-To: <20040318164253.GO2246@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403181144290.16728-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Andrea Arcangeli wrote:
> On Thu, Mar 18, 2004 at 10:32:58AM -0500, Rik van Riel wrote:
> > I don't think wants to use mlock, and I suspect it doesn't
> 
> for the short term it's ok, I agree longer term we may want to make them
> swappable, but we don't necessairly need to support efficient swapping
> for huge vmas (i.e. 10G, if one wants efficient swapping
> remap_file_pages shouldn't be used).

Agreed, it's definately a medium term thing to implement.
To be done before merging mainstream, but after stabilising
the current code...

> Could you tell me how you called the mlock sysctl that Wli talked about?
> (Wli mentioned the mlock sysctl in a patch from you) Thanks.

It's in the RHEL3 kernel, a patch named linux-2.4.21-mlock.patch.

Basically it allows any normal process to have up to its
current->rlim[RLIMIT_MEMLOCK].rlim_cur memory locked.
Root can configure, in /etc/security/limits.conf, how much 
memory the processes of each user are allowed to mlock.

Processes with CAP_IPC_LOCK set can mlock as much as they
want, unrestricted by the limit.

Last year at the kernel summit, Linus seemed pretty happy
with this approach.  I think Wim Coekaerts at Oracle has
ported the patch to 2.6 already...

I suspect the security paranoid will like this patch too,
because it allows gnupg to mlock the memory it wants to
have locked.

Now it just needs to be submitted to Andrew and Linus ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

