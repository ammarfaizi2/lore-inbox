Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbTEIVcI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTEIVcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:32:08 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:29573 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S263481AbTEIVcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:32:07 -0400
Date: Fri, 9 May 2003 14:44:41 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CHECKER] Clarifications needed on a user-pointer false alarm in
 kernel/kmod.c
In-Reply-To: <Pine.GSO.4.44.0305012334140.7454-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0305091424590.5419-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I got the following false alarm in kernel/kmod.c.

the call chain is sys_wait4 (_, &sub_info->retval) -> wait_task_zombie (_,
_, stat_addr, _) -> put_user (_, stat_addr), which means &sub_info->retval
will be passed into put_user. From the calling context, sub_info should be
in kernel space, so &sub_info->retval should be in kernel space as well.
The explanation for this false alarm could be that the call chain wasn't
realistic, but I'm not sure. Can you guys please help me on that?

/home/junfeng/linux-tainted/kernel/kmod.c:185:wait_for_helper:
ERROR:TAINTED:185:185: dereferencing tainted ptr 'sub_info' [Callstack: ]
  if (pid < 0)
            sub_info->retval = pid;
 else
            sys_wait4(pid, (unsigned int *)&sub_info->retval, 0, NULL);


Error --->
   complete(sub_info->complete);
   return 0;
}


