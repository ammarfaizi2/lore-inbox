Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSFOVGU>; Sat, 15 Jun 2002 17:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSFOVGT>; Sat, 15 Jun 2002 17:06:19 -0400
Received: from web14401.mail.yahoo.com ([216.136.174.58]:10913 "HELO
	web14401.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315540AbSFOVGT>; Sat, 15 Jun 2002 17:06:19 -0400
Message-ID: <20020615210620.38592.qmail@web14401.mail.yahoo.com>
Date: Sat, 15 Jun 2002 14:06:20 -0700 (PDT)
From: Amit Nadgar <vangough_spinlock@yahoo.com>
Subject: accessing the struct task_struct using a pid
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

guys,
   I am writing a kernel module where I am trying to
access the task_structs. Now I have tried this using
various mathods.
   1) Using the pidhash array.
      Here when I do a insmod I get a unresolved
symbol.
   2) Directly accessing the location of pidhash as
seen in System.map.
      Here when the pidhash_fn hashes the supplied pid
the particular location into which it indexes in NULL.
  3) Starting from the init_task.
     here the next task after the init task is found
to be NULL.

Could some one help me in this matter.
   -vangough

Following is the piece of code which executes when an
apploication program does a sys_ptrace. 

int new_syscall(long request,long pid,long addr,long
data)
  struct task_struct *my_init_task = (struct
task_struct *)&init_task; 
  struct task_struct *task_ptr;
  if(my_init_task)
  {
	task_ptr = my_init_task;
	while(task_ptr && (task_ptr->next_task !=
my_init_task))
        {
  		printk("<1> task_ptr pointer is %x\n",task_ptr);
  		printk("<1> task_ptr->pid is %d\n",task_ptr->pid);
		printk("<1> task_ptr->next_task is
%x",task_ptr->next_task);	
		task_ptr = (struct task_struct*)task_ptr->next_task;
	}
  }
  else 
  {
	printk("<1> my_init_task pointer is
%d\n",my_init_task);
	return 0;
  }
 
_memcpy(sys_call_table[SYS_PTRACE_NUMBER],syscall_code,
				sizeof(syscall_code));
  
/*  ((long int (*)
(long,long,long,long))sys_call_table[SYS_PTRACE_NUMBER])(request,pid,addr,data);*/
}


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
