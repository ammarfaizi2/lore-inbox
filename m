Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUCSCmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 21:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbUCSCmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 21:42:04 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32391
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261491AbUCSCmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 21:42:01 -0500
Date: Fri, 19 Mar 2004 03:42:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040319024251.GA31498@dualathlon.random>
References: <Pine.LNX.4.44.0403182317050.16911-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403182317050.16911-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 11:21:07PM +0000, Hugh Dickins wrote:
> +	if (!spin_trylock(&mm->page_table_lock))
> +		return 1;
> +
[..]
> +	if (down_trylock(&mapping->i_shared_sem))
> +		return 1;
> +	

those two will hang your kernel in the workload I posted to the list a
few days ago.

With previous kernels the above didn't matter, but starting with
2.6.5-rc1 it does matter, if we cannot know if it's referenced or not,
we must assume it's not and return 0 or it lives locks hard with all
tasks stuck and one must click reboot.

I recommend you to share my objrmap patch, the objrmap should be exactly
the same for both of us. It took me a while to figure out the above
issue and fix it in the objrmap patch, since it was hard to assume a
change in 2.6.5-rc1 broke objrmap (there were no rejects and objrmap was
pretty much unchanged since the 2.5.x days for an year).
