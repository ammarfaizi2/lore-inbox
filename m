Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269116AbUIXUXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269116AbUIXUXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269117AbUIXUW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:22:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:43136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269116AbUIXUWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:22:51 -0400
Date: Fri, 24 Sep 2004 13:22:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040924132247.W1973@build.pdx.osdl.net>
References: <41547C16.4070301@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41547C16.4070301@pobox.com>; from jgarzik@pobox.com on Fri, Sep 24, 2004 at 03:57:10PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:
> 
> How feasible is it to create an mlock(1) utility, that would allow 
> priveleged users to execute a daemon such that none of the memory the 
> daemon allocates will ever be swapped out?

1. Doesn't require privilege, just proper rlimits ;-)
2. Problem is the execve(2) that the mlock(1) program would have to call.
This blows away the mappings which contain the locking info.  Unless you
were thinking of promoting something akin to VM_LOCKED from the ->mm
def_flags to a per task flag.

> ntp daemon does mlock(2) internally, for example, but IMHO this is 
> really a policy decision that could be moved out of the app.

Hard to say if it's a policy decision outside the scope of the app.
Esp. if the app knows it needs to not be swapped.  Either something that
has realtime needs, or more specifically, privacy needs.  Don't need to
mlock all of gpg to ensure key data never hits swap.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
