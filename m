Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVFMJcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVFMJcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 05:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVFMJcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 05:32:43 -0400
Received: from mailservice.tudelft.nl ([130.161.131.5]:49434 "EHLO
	mailservice.tudelft.nl") by vger.kernel.org with ESMTP
	id S261281AbVFMJck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 05:32:40 -0400
Subject: [FIX] apm.c: ignore_normal_resume is set to 1 a bit too late
From: Thomas Hood <jdthood@aglu.demon.nl>
To: linux-kernel@vger.kernel.org
Cc: sfr@canb.auug.org.au
Content-Type: text/plain
Date: Mon, 13 Jun 2005 11:45:39 +0200
Message-Id: <1118655939.7066.37.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message contains a fix for a bug in the apm driver.

A bug report was submitted to the Debian BTS saying that on the
submitter's system the apmd proxy script was being run twice on resume.

Having seen exactly the same problem some years ago and knowing that the
solution then was to ensure that the ignore_normal_resume flag got set
before there was any chance of an APM RESUME event being processed, I
checked the current apm.c and I found that ignore_normal_resume was once
again being set too late.  I asked the submitter to move the line where
the flag was set and he reported that this change solved the problem.  I
append the message in question.  The line numbers I mention there are
for Linux 2.6.11.

Please make the indicated change to the apm driver.

-------- Forwarded Message --------
jdthood@aglu.demon.nl wrote to the submitter of Debian bug #310865:
> In arch/i386/kernel/apm.c there is at approximately line 1229:
> 
>         ignore_normal_resume = 1;
> 
> Move this up so that it occurs right after line 1222:
> 
>         err = set_system_power_state(APM_STATE_SUSPEND);
> 
> Let us know if that helps.


It does. Very nice.
I don't understand what I did and how it works. Will you try to
push that into kernel sources or is this no permanent fix?
-- 
Thomas Hood <jdthood@aglu.demon.nl>

