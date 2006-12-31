Return-Path: <linux-kernel-owner+w=401wt.eu-S933113AbWLaJqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933113AbWLaJqj (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 04:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933111AbWLaJqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 04:46:39 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42369
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933110AbWLaJqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 04:46:38 -0500
Date: Sun, 31 Dec 2006 01:46:30 -0800 (PST)
Message-Id: <20061231.014630.130845911.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: torvalds@osdl.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061231092318.GA1702@flint.arm.linux.org.uk>
References: <20061230224604.GA3350@flint.arm.linux.org.uk>
	<20061230.212338.92583434.davem@davemloft.net>
	<20061231092318.GA1702@flint.arm.linux.org.uk>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Sun, 31 Dec 2006 09:23:18 +0000

> We do this on ARM - if page_mapping() is NULL, we flush the kernel
> alias unconditionally.  However, we have no view where the user
> mapping of that page is, which is where the problem is.  Cache lines
> remain allocated for the user mapping and data contained within is
> not visible via the kernel mapping.

You can walk the RMAP list.

> However, it's not only FUSE which is suffering - direct-IO also doesn't
> work.  If my analysis is correct, only _two_ users of get_user_pages()
> with the current process actually does the right thing and that's ptrace
> and ELF core dumping.  All other users are buggy.

I do not argue that these cases need work, in fact I am aware
of the direct-IO bit.
