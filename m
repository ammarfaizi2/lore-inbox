Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131764AbRCOQFk>; Thu, 15 Mar 2001 11:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131770AbRCOQFb>; Thu, 15 Mar 2001 11:05:31 -0500
Received: from changeofhabit.mr.itd.umich.edu ([141.211.144.17]:6902 "EHLO
	changeofhabit.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S131764AbRCOQFU>; Thu, 15 Mar 2001 11:05:20 -0500
Message-ID: <3AB0E997.2070603@engin.umich.edu>
Date: Thu, 15 Mar 2001 11:11:03 -0500
From: Krisztian Flautner <manowar@engin.umich.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: task switch hook - crashes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am experimenting with adding a few hooks to the kernel.
One of the hooks gets invoked every time the kernel switches
two tasks. To do this I added a single line to schedule() right
before the tasks are switched:

      ...
      if (task_switch_hook) task_switch_hook(prev, next)

      switch_to(prev, next, prev);
      ...

I then wrote a module that attaches a function to this hook
in its init_module() function. The problem is that if I do this,
the kernel crashes. Sometimes, the hooks are invoked a few times,
other times, the machine locks up immediately. I previous version
that compiled everything into the kernel worked fine.

I don't quite understand why this does not work. Is this due
to some virtual memory interactions? Maybe the problem is that
modules are vmalloc-ed and the hook function should be kmalloc-ed?

Any insights?


Thanks, -- Kris

