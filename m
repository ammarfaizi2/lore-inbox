Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVBXXAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVBXXAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbVBXXAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:00:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:41631 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262526AbVBXXAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:00:46 -0500
Date: Thu, 24 Feb 2005 15:00:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chad N. Tindel" <chad@tindel.net>
Cc: helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-Id: <20050224150026.69b1862f.akpm@osdl.org>
In-Reply-To: <20050224173356.GA11593@calma.pair.com>
References: <20050223230639.GA33795@calma.pair.com>
	<20050223183634.31869fa6.akpm@osdl.org>
	<20050224052630.GA99960@calma.pair.com>
	<421DD5CC.5060106@aitel.hist.no>
	<20050224173356.GA11593@calma.pair.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chad N. Tindel" <chad@tindel.net> wrote:
>
>  I would make the following assertion for any kernel:
> 
>  No single userspace thread of execution running on an SMP system should be 
>  able to hose a box by going CPU-bound, bug in the software or no bug.

But if we were to enforce that policy, realtime policy would become less
useful.  You havn't even acknowledged that such a tradeoff exists, let
alone demonstrated that we're on the wrong side of it.

Here's a quicky which will convert all your kernel threads to SCHED_RR,
priority 99.  Please test.

#!/bin/sh

PIDS=$(ps axo pid,command | grep ' \[.*\]$' | sed -e 's/ \[.*\]$//')

for i in $PIDS
do
	chrt -r 99 -9 $i
done

