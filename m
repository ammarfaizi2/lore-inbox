Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262379AbRE2W6P>; Tue, 29 May 2001 18:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262382AbRE2W6F>; Tue, 29 May 2001 18:58:05 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:53733 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262379AbRE2W56>;
	Tue, 29 May 2001 18:57:58 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105292257.PAA00192@csl.Stanford.EDU>
Subject: Re: [CHECKER] 4 security holes in 2.4.4-ac8
To: davem@redhat.com (David S. Miller)
Date: Tue, 29 May 2001 15:57:53 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15124.7615.678503.824814@pizda.ninka.net> from "David S. Miller" at May 29, 2001 03:07:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > [BUG] raddr seems to be a user pointer, but is written at the end of
>  >       the system call.
>  > 
>  > ipc/shm.c: ERROR: system call 'sys_shmat' derefs non-tainted param= 3
>  > 
>  > asmlinkage long sys_shmat (int shmid, char *shmaddr, int shmflg, ulong *raddr)
>  > {
>  >         struct shmid_kernel *shp;
>  > 
>  > 
>  > 	...
>  >         *raddr = (unsigned long) user_addr;
>  >         err = 0;
>  >         if (IS_ERR(user_addr))
>  >                 err = PTR_ERR(user_addr);
>  >         return err;
> 
> Believe it or not, this one is OK :-)
> 
> All callers pass in a pointer to a local stack kernel variable
> in raddr.

Ah.  I assumed that "sys_*" meant that all pointers were from user space ---
is this generally not the case?  (Also, are there other functions called 
directly from user space that don't have the sys_* prefix?)
