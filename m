Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267401AbSLETa6>; Thu, 5 Dec 2002 14:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267402AbSLETa6>; Thu, 5 Dec 2002 14:30:58 -0500
Received: from fmr05.intel.com ([134.134.136.6]:47322 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267401AbSLETa5>; Thu, 5 Dec 2002 14:30:57 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA260216C228@pdsmsx32.pd.intel.com>
From: "Hu, Boris" <boris.hu@intel.com>
To: "NPTL list (E-mail)" <phil-list@redhat.com>
Cc: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Subject: what's the relationship between tgid, tid and pid ?
Date: Fri, 6 Dec 2002 03:36:21 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="gb2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux 2.5.49
NTPL 0.10

I learned from the kernel source. sys_getpid() returns tgid and 
sys_gettid() returns pid. Moreover, 
/kernel/source/fork.c
copy_process() 
771 if (clone_flags & CLONE_PARENT_SETTID)
772 if (put_user(p->pid, parent_tidptr))  // parent_tidptr is tid in struct
pthread
                                   ....
It seems tid = pid, while tgid is head pthread pid. 

But the following lines let me confused.
/kernel/source/fork.c
copy_process()              
893         p->tgid = p->pid;
894         p->group_leader = p;
every pthread_create()->sys_clone()->do_fork()->copy_process()
p->tgid will be overwritten every time?

any comments? thanks. 

  Boris
=========================
To know what I don't know
To learn what I don't know
To contribute what I know
=========================

