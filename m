Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbSKKRZt>; Mon, 11 Nov 2002 12:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbSKKRZt>; Mon, 11 Nov 2002 12:25:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18630 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265844AbSKKRZs>;
	Mon, 11 Nov 2002 12:25:48 -0500
Subject: [RFC] i386/unistd.h incomprehensible comment?
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Nov 2002 09:32:36 -0800
Message-Id: <1037035956.20416.215.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following comment needs to be updated since it seems to be out of
date (fork is not actually declared here) and hard to read.
Don't know the history of this, or what is correct comment would be, but
this seems wrong.

------------------------------------------------------------
in include/asm-i386/unistd.h


#ifdef __KERNEL_SYSCALLS__

/*
 * we need this inline - forking from kernel space will result
 * in NO COPY ON WRITE (!!!), until an execve is executed. This
 * is no problem, but for the stack. This is handled by not letting
 * main() use the stack at all after fork(). Thus, no function
 * calls - which means inline code for fork too, as otherwise we
 * would use the stack upon exit from 'fork()'.
 *
 * Actually only pause and fork are needed inline, so that there
 * won't be any messing with the stack from main(), but we define
 * some others too.
 */
#define __NR__exit __NR_exit
static inline _syscall0(pid_t,setsid)
static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
static inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
static inline _syscall1(int,dup,int,fd)
static inline _syscall3(int,execve,const char *,file,char **,argv,char
**,envp)
static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
static inline _syscall1(int,close,int,fd)
static inline _syscall1(int,_exit,int,exitcode)
static inline _syscall3(pid_t,waitpid,pid_t,pid,int
*,wait_stat,int,options)
#endif


