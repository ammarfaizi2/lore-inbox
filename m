Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSJBP2Q>; Wed, 2 Oct 2002 11:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263108AbSJBP2Q>; Wed, 2 Oct 2002 11:28:16 -0400
Received: from host187.south.iit.edu ([216.47.130.187]:11648 "EHLO
	host187.south.iit.edu") by vger.kernel.org with ESMTP
	id <S263105AbSJBP2O>; Wed, 2 Oct 2002 11:28:14 -0400
Message-ID: <3D9B119A.6020800@host187.south.iit.edu>
Date: Wed, 02 Oct 2002 10:32:42 -0500
From: Stephen Marz <smarz@host187.south.iit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Netfilter ipt_owner.o
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I attached a patch below that will allow ipt_owner to be loaded as a 
module, for those who actually use ipt_owner.

----START PATCH---
diff -c ../linux-2.5.40/kernel/Makefile ./kernel/Makefile
*** ../linux-2.5.40/kernel/Makefile    Tue Oct  1 02:06:22 2002
--- ./kernel/Makefile    Wed Oct  2 10:25:04 2002
***************
*** 3,9 ****
  #
 
  export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
!           printk.o platform.o suspend.o dma.o module.o cpufreq.o
 
  obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
          module.o exit.o itimer.o time.o softirq.o resource.o \
--- 3,10 ----
  #
 
  export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
!           printk.o platform.o suspend.o dma.o module.o cpufreq.o pid.o \
!           exit.o
 
  obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
          module.o exit.o itimer.o time.o softirq.o resource.o \
diff -c ../linux-2.5.40/kernel/exit.c ./kernel/exit.c
*** ../linux-2.5.40/kernel/exit.c    Tue Oct  1 02:06:28 2002
--- ./kernel/exit.c    Wed Oct  2 10:25:22 2002
***************
*** 706,712 ****
 
      return pid_task(tmp, PIDTYPE_TGID);
  }
!
  /*
   * this kills every thread in the thread group. Note that any externally
   * wait4()-ing process will get the correct exit code - even if this
--- 706,712 ----
 
      return pid_task(tmp, PIDTYPE_TGID);
  }
! EXPORT_SYMBOL(next_thread);
  /*
   * this kills every thread in the thread group. Note that any externally
   * wait4()-ing process will get the correct exit code - even if this
diff -c ../linux-2.5.40/kernel/pid.c ./kernel/pid.c
*** ../linux-2.5.40/kernel/pid.c    Tue Oct  1 02:07:03 2002
--- ./kernel/pid.c    Wed Oct  2 10:17:29 2002
***************
*** 23,28 ****
--- 23,29 ----
  #include <linux/slab.h>
  #include <linux/init.h>
  #include <linux/bootmem.h>
+ #include <linux/module.h>
 
  #define PIDHASH_SIZE 4096
  #define pid_hashfn(nr) ((nr >> 8) ^ nr) & (PIDHASH_SIZE - 1)
***************
*** 228,234 ****
          return NULL;
      return pid_task(pid->task_list.next, PIDTYPE_PID);
  }
!
  /*
   * This function switches the PIDs if a non-leader thread calls
   * sys_execve() - this must be done without releasing the PID.
--- 229,235 ----
          return NULL;
      return pid_task(pid->task_list.next, PIDTYPE_PID);
  }
! EXPORT_SYMBOL(find_task_by_pid);
  /*
   * This function switches the PIDs if a non-leader thread calls
   * sys_execve() - this must be done without releasing the PID.


---END PATCH---

