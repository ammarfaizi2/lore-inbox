Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUI0VGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUI0VGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 17:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUI0VFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 17:05:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:47016 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267378AbUI0VD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 17:03:57 -0400
Date: Mon, 27 Sep 2004 14:03:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch for comment: setuid core dumps
Message-ID: <20040927140353.Z1973@build.pdx.osdl.net>
References: <20040927202616.GA22228@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040927202616.GA22228@devserv.devel.redhat.com>; from alan@redhat.com on Mon, Sep 27, 2004 at 04:26:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@redhat.com) wrote:
>  
> +suid_dumpable:
> +
> +This value can be used to query and set the core dump mode for setuid
> +or otherwise protected/tainted binaries. The modes are
> +
> +0 - (default) - traditional behaviour. Any process which has changed
> +	privilege levels or is execute only will not be dumped
> +1 - (debug) - all processes dump core when possible. The core dump is
> +	owned by the current user and no security is applied. This is
> +	intended for system debugging situations only.

This looks alright, since it keeps 0 and 1 with same meaning (for any
user of prctl).

> +2 - (suidsafe) - any binary which normally not be dumped is dumped
> +	readable by root only. This allows the end user to remove
> +	such a dump but not access it directly. For security reasons
> +	core dumps in this mode will not overwrite one another or 
> +	other files. This mode is appropriate when adminstrators are
> +	attempting to debug problems in a normal environment.
> +

But, in general, did you double check how this plays with /proc
(task_dumpable) and ptrace_attach type stuff?  That seems sketchy.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
