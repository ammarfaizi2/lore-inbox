Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbTIFTxt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 15:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbTIFTxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 15:53:48 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:4371
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261675AbTIFTxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 15:53:47 -0400
Subject: RE: [PATCH] Minor scheduler fix to get rid of skipping in xmms
From: Robert Love <rml@tech9.net>
To: John Yau <jyau_kernel_dev@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000101c374a3$2d2f9450$f40a0a0a@Aria>
References: <000101c374a3$2d2f9450$f40a0a0a@Aria>
Content-Type: text/plain
Message-Id: <1062878664.3754.12.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sat, 06 Sep 2003 16:04:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-06 at 14:17, John Yau wrote:

> Scratch that, I just found Ingo's patch.  My patch does essentially the same
> thing except it only allows the current active process to be preempted if it
> got demoted in priority during the effective priority recalculation.  This
> IMHO is better because it doesn't do unnecessary context switches.  If the
> process were truly a CPU hog relative other processes on the run queue, then
> it'd get preempted eventually when it gets demoted rather than always every
> 25 ms.

The rationale behind Ingo's patch is to "break up" the timeslices to
give better scheduling latency to multiple tasks at the same priority. 
So it is not "unnecessary context switches," just "extra context
switches."

It also recalculates the process's effective priority, like yours does,
so it also has the same advantage as your patch: to more quickly detect
tasks that have changed in interactivity, and to handle that.

Not sure which approach is better.  Only testing will tell.

> How come Ingo's granular timeslice patch didn't get put into 2.6.0-test4?

Interactivity improvements are currently a contentious issue.  The patch
is back in 2.6-mm, though.

	Robert Love


