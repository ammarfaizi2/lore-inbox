Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269177AbUIHWhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269177AbUIHWhA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 18:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269188AbUIHWhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 18:37:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54408 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269177AbUIHWg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 18:36:58 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R9
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Alexander Nyberg <alexn@dsv.su.se>
In-Reply-To: <20040908082050.GA680@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu>
	 <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen>
	 <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu>
	 <20040907115722.GA10373@elte.hu>
	 <1094597988.16954.212.camel@krustophenia.net>
	 <20040908082050.GA680@elte.hu>
Content-Type: text/plain
Message-Id: <1094683020.1362.219.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Sep 2004 18:37:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 04:20, Ingo Molnar wrote:
> does -R9 work for you:
> 

No, same error:

  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o(.init.text+0xcbf): In function `interruptible_sleep_on':
kernel/sched.c:1563: undefined reference to `init_irq_proc'
make: *** [.tmp_vmlinux1] Error 1

Here is the change that is responsible.  R6 compiles:

rlrevell@mindpipe:~/kernel-source/linux-2.6.9-rc1-bk12-R8$ grep init_irq_proc ../voluntary-preempt-2.6.9-rc1-bk12-R6 
-void init_irq_proc (void)
-void init_irq_proc (void)
-void init_irq_proc (void)
+void init_irq_proc (void)

R8 and later do not:

rlrevell@mindpipe:~/kernel-source/linux-2.6.9-rc1-bk12-R8$ grep init_irq_proc ../voluntary-preempt-2.6.9-rc1-bk12-R9
-void init_irq_proc (void)
-void init_irq_proc (void)
-void init_irq_proc (void)
+extern void generic_init_irq_proc(void);
+static inline void init_irq_proc(void)
+	generic_init_irq_proc();
+void generic_init_irq_proc(void)

Lee


