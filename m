Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbULCBEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbULCBEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 20:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbULCBEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 20:04:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12010 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261830AbULCBE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 20:04:27 -0500
Date: Thu, 2 Dec 2004 17:04:17 -0800
Message-Id: <200412030104.iB314HtA001566@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
X-Fcc: ~/Mail/linus
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use pid_alive in proc_pid_status
In-Reply-To: Manfred Spraul's message of  Monday, 29 November 2004 18:58:30 +0100 <41AB6346.2080601@colorfullife.com>
X-Shopping-List: (1) Prestigious digressions
   (2) Luxurious lips
   (3) Heterogeneous superstitious witches
   (4) Obsequious persuaders
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But I don't understand the lines in wait_task_zombie that reset 
> exit_state from DEAD to ZOMBIE, so perhaps I overlook something.

This happens when a sys_wait* call tries to reap a process, but then has
some problem like EFAULT.  It then abandons the reaping attempt by turning
DEAD back into ZOMBIE, so another sys_wait* call can succeed later.  So,
during this brief window it can be in DEAD though it in fact is never
reaped and the PID remains bound to that task_struct throughout.
If you don't want to rule out ZOMBIE, you can't really rule out DEAD.


Thanks,
Roland
