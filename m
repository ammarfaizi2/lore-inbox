Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTJXBgB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 21:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTJXBgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 21:36:01 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:35196 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261929AbTJXBf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 21:35:59 -0400
Message-Id: <200310240136.h9O1aaOU002931@pasta.boston.redhat.com>
To: "Michael Glasgow" <glasgowNOSPAM@beer.net>
cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: posix capabilities inheritance
In-Reply-To: Your message of "Thu, 23 Oct 2003 17:05:40 CDT."
             <200310232205.h9NM5eOc004400@dark.beer.net>
Date: Thu, 23 Oct 2003 21:36:36 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 23-Oct-2003 at 17:5 CDT, "Michael Glasgow" wrote:

> The code to drop privs is not hard, but it's also not trivial.

Here's an example code sequence that demonstrates how a setuid-to-root
application could drop all capabilities except for CAP_IPC_LOCK and
then run with the non-privileged uid:

    #include <sys/prctl.h>
    #include <sys/capability.h>

	...

	cap_t c;

	if (prctl(PR_SET_KEEPCAPS, 1UL, 0UL, 0UL, 0UL) < 0 ||
	    seteuid(getuid()) < 0 ||
	    !(c = cap_from_text("cap_ipc_lock=eip")) ||
	    cap_set_proc(c) < 0)
		/* handle error */;

However, I agree that it's often not viable to require application
changes to achieve the desired result.

Cheers.  -ernie
