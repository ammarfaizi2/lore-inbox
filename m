Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVB1W0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVB1W0Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVB1W0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:26:16 -0500
Received: from mail.tmr.com ([216.238.38.203]:56849 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261798AbVB1WZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:25:53 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH 2.6.11-rc4] oom_kill.c: Kill obvious processes first
Date: Mon, 28 Feb 2005 17:30:53 -0500
Organization: TMR Associates, Inc
Message-ID: <42239B9D.80001@tmr.com>
References: <200502250024.30450.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1109628867 7513 192.168.12.100 (28 Feb 2005 22:14:27 GMT)
X-Complaints-To: abuse@tmr.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <200502250024.30450.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:
> oom_kill.c misses very obvious targets - For example, a process occupying > 
> 80% memory, not superuser and not having hardware access gets ignored by it. 
> Logically, such a process, if killed , is going to make things return to 
> normal thereby eliminating the need for oom killer to further scan for more 
> processes.
> 
> This patch calculates the approximate integer percentage of memory occupied by 
> the process by looking at num_physpages and p->mm->total_vm. If this process 
> is not super user and doesn't have hardware access, and the percentage of 
> occupied memory is more than 60%, it immediately selects this process for 
> killing by returning unusually high points from badness().
> 
> Without this patch, when KDevelop running as non root user gobbles up 90% 
> memory, the OOM killer kills many other irrelevant processes but not KDevelop 
> And machine never recovers.. (Pls see LKML for my previous message with 
> subject "2.6.11-rc4 OOM Killer - Kill the Innocent".) 
> 
> With this patch OOM killer immediately kills kdevelop and machine recovers.

Thank you for the patch, I'm in agreement with the idea, and I'll give 
it a try after I look at the code a bit. The current code frequently 
seems bit... non-deterministic.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
