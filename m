Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUGENhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUGENhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 09:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266086AbUGENhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 09:37:36 -0400
Received: from outmx001.isp.belgacom.be ([195.238.3.51]:3768 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S266085AbUGENhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 09:37:34 -0400
Subject: Re: question about /proc/<PID>/mem in 2.4
From: FabF <fabian.frederick@skynet.be>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0407051422240.18740-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0407051422240.18740-100000@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1089034642.2129.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 05 Jul 2004 15:37:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-05 at 15:27, Tigran Aivazian wrote:
> Hello,
> 
> I noticed that in 2.4.x kernels the fs/proc/base.c:mem_read() function has 
> this permission check:
> 
>         if (!MAY_PTRACE(task) || !may_ptrace_attach(task))
>                 return -ESRCH;
> 
> Are you sure it shouldn't be like this instead:
> 
>         if (!MAY_PTRACE(task) && !may_ptrace_attach(task))
>                 return -ESRCH;
> 
> Because, normally MAY_PTRACE() is 0 (i.e. for any process worth looking at :)
> so may_ptrace_attach() is never even called.
> 
MAY_PTRACE is 1 normally AFAICS.The check as it stands wants both to
have non zero returns so is more restrictive than the one you're asking
for.

> Is there any reason for the above check on each read(2)? Shouldn't there 
> be a simple check at ->open() time only? I assume this is to close some 
> obscure "security hole" but I would like to see the explanation of how 
> could any problem arise if a) such check wasn't done at all (except at 
> open(2) time) or at least b) there was && instead of ||.
cf. chmod thread.

> 
> The 2.6.x situation is similar except the addition of the security stuff.
> 
> Kind regards
> Tigran
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

