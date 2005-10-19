Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbVJSMWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVJSMWs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVJSMWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:22:48 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:36058 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750848AbVJSMWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:22:47 -0400
Date: Wed, 19 Oct 2005 08:22:13 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Christoph Hellwig <hch@infradead.org>
cc: Lee Revell <rlrevell@joe-job.com>, Mark Knecht <markknecht@gmail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       rmk@arm.linux.org.uk, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, andmike@us.ibm.com,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi_error thread exits in TASK_INTERRUPTIBLE state.
In-Reply-To: <20051019115435.GA31007@infradead.org>
Message-ID: <Pine.LNX.4.58.0510190811380.20634@localhost.localdomain>
References: <5bdc1c8b0510181402o2d9badb0sd18012cf7ff2a329@mail.gmail.com>
 <1129693423.8910.54.camel@mindpipe> <1129695564.8910.64.camel@mindpipe>
 <Pine.LNX.4.58.0510190300010.20634@localhost.localdomain>
 <Pine.LNX.4.58.0510190349590.20634@localhost.localdomain>
 <20051019113131.GA30553@infradead.org> <Pine.LNX.4.58.0510190751070.20634@localhost.localdomain>
 <20051019115435.GA31007@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Once again here's the patch.

Andrew, can you pull my previous one in favor of this one

I'm one of the rare breeds of programmers that over document, at least I
didn't comment "x equals a plus b" for "x = a + b" but I'm sure Christoph
would say that I was pretty close ;-)

Description:

Found in the -rt patch set.  The scsi_error thread likely will be in the
TASK_INTERRUPTIBLE state upon exit.  This patch fixes this bug.

Ingo,

I take it that you don't care about the comment for RT.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.14-rc4/drivers/scsi/scsi_error.c
===================================================================
--- linux-2.6.14-rc4.orig/drivers/scsi/scsi_error.c	2005-10-19 03:37:55.000000000 -0400
+++ linux-2.6.14-rc4/drivers/scsi/scsi_error.c	2005-10-19 08:10:23.000000000 -0400
@@ -1645,6 +1645,8 @@
 		set_current_state(TASK_INTERRUPTIBLE);
 	}

+	__set_current_state(TASK_RUNNING);
+
 	SCSI_LOG_ERROR_RECOVERY(1, printk("Error handler scsi_eh_%d"
 					  " exiting\n",shost->host_no));

