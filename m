Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262372AbSIPOwH>; Mon, 16 Sep 2002 10:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262398AbSIPOwG>; Mon, 16 Sep 2002 10:52:06 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:36815 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S262372AbSIPOwF>; Mon, 16 Sep 2002 10:52:05 -0400
Message-ID: <3D85F1B5.7020904@drugphish.ch>
Date: Mon, 16 Sep 2002 16:59:01 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.35: fs.o
References: <200209161651.23546@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> fs/fs.o: In function `flush_old_exec':
> fs/fs.o(.text+0x9b1c): undefined reference to `wait_task_inactive'

The following worked for me but I'm not convinced that this is the right 
thing (tm):

--- linux-2.5.35/kernel/sched.c Mon Sep 16 04:18:24 2002
+++ linux-2.5.35-ratz/kernel/sched.c    Mon Sep 16 13:29:28 2002
@@ -331,8 +331,6 @@
  #endif
  }

-#ifdef CONFIG_SMP
-
  /*
   * wait_task_inactive - wait for a thread to unschedule.
   *
@@ -366,7 +364,6 @@
         task_rq_unlock(rq, &flags);
         preempt_enable();
  }
-#endif

  /*
   * kick_if_running - kick the remote CPU if the task is running currently.

I think Ingo should check this and take appropriate actions. I could 
also be that ../fs/exec.c and others in binfmt* should not call this 
wait_task_inactive under UP anymore.

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

