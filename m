Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSHXJyL>; Sat, 24 Aug 2002 05:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSHXJyL>; Sat, 24 Aug 2002 05:54:11 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:6377
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP
	id <S315483AbSHXJyG>; Sat, 24 Aug 2002 05:54:06 -0400
Message-ID: <20020824095817.19775.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-0.27
To: Thunder from the hill <thunder@lightweight.ods.org>
cc: Dag Nygren <dag@newtech.fi>, linux-kernel@vger.kernel.org, dag@newtech.fi
Subject: Re: Preempt note in the logs  (and patch)
In-Reply-To: Message from Thunder from the hill <thunder@lightweight.ods.org> 
   of "Sat, 24 Aug 2002 03:45:46 MDT." <Pine.LNX.4.44.0208240344470.3234-100000@hawkeye.luckynet.adm> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_14562106260"
Date: Sat, 24 Aug 2002 12:58:17 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_14562106260
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

> Hi,
> =

> On Sat, 24 Aug 2002, Dag Nygren wrote:
> > just installed the preempt stuff on a 2.4.19 here
> > running on a laptop and keep getting the
> > "dreaded"  exited with preempt_count 1
> > messages.
> > there is modprobe,kdeinit,aplay,less,find,grep,automount
> > and others misbehaving.
> =

> Not much. That's just unclean preempt.

Anyway I cannot have it on the laptop so I made the sysctl patch
I was talking about myself (The one that switches that message on
or off. The default is on as wo. the patch)

It is diffed against a kernel with the ck2 patch applied,
ie. lowlatency+preempt.

Here it is, if you are interested out there:

Best from Finland

-- =

Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Tr=E4sktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


--==_Exmh_14562106260
Content-Type: application/x-patch ; name="preemponoff.patch"
Content-Description: preemponoff.patch
Content-Disposition: attachment; filename="preemponoff.patch"

*** ./kernel/exit.c.orig	Sat Aug 24 12:08:59 2002
--- ./kernel/exit.c	Sat Aug 24 12:21:05 2002
***************
*** 24,29 ****
--- 24,31 ----
  extern void sem_exit (void);
  extern struct task_struct *child_reaper;
  
+ int sysctl_warn_preempt = 1;	/* Warn about preempted tasks still holding locks */
+ 
  int getrusage(struct task_struct *, int, struct rusage *);
  
  static void release_task(struct task_struct * p)
***************
*** 496,502 ****
  	tsk->flags |= PF_EXITING;
  	del_timer_sync(&tsk->real_timer);
  
! 	if (unlikely(preempt_get_count()))
  		printk(KERN_INFO "note: %s[%d] exited with preempt_count %d\n",
  				current->comm, current->pid,
  				preempt_get_count());
--- 498,504 ----
  	tsk->flags |= PF_EXITING;
  	del_timer_sync(&tsk->real_timer);
  
! 	if (sysctl_warn_preempt && unlikely(preempt_get_count()))
  		printk(KERN_INFO "note: %s[%d] exited with preempt_count %d\n",
  				current->comm, current->pid,
  				preempt_get_count());
*** ./kernel/sysctl.c.orig	Sat Aug 24 12:07:26 2002
--- ./kernel/sysctl.c	Sat Aug 24 12:22:03 2002
***************
*** 74,79 ****
--- 74,81 ----
  extern int sem_ctls[];
  #endif
  
+ extern int sysctl_warn_preempt;
+ 
  #ifdef __sparc__
  extern char reboot_command [];
  extern int stop_a_enabled;
***************
*** 260,265 ****
--- 262,269 ----
  	{KERN_LOWLATENCY, "lowlatency", &enable_lowlatency, sizeof (int),
  	 0644, NULL, &proc_dointvec},
  #endif
+ 	{KERN_PREEMPTWARN, "preemptwarnings", &sysctl_warn_preempt, sizeof (int),
+ 	 0644, NULL, &proc_dointvec},
  	{0}
  };
  
*** ./include/linux/sysctl.h.orig	Sat Aug 24 12:06:09 2002
--- ./include/linux/sysctl.h	Sat Aug 24 12:07:07 2002
***************
*** 125,130 ****
--- 125,131 ----
  	KERN_TAINTED=53,	/* int: various kernel tainted flags */
  	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
  	KERN_LOWLATENCY=55,     /* int: enable low latency scheduling */
+ 	KERN_PREEMPTWARN=56,     /* int: enable warnings about preempted processes */
  };
  
  

--==_Exmh_14562106260--


