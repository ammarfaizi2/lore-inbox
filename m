Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262119AbRE2WIb>; Tue, 29 May 2001 18:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbRE2WIV>; Tue, 29 May 2001 18:08:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27549 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262119AbRE2WIN>;
	Tue, 29 May 2001 18:08:13 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15124.7615.678503.824814@pizda.ninka.net>
Date: Tue, 29 May 2001 15:07:59 -0700 (PDT)
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 4 security holes in 2.4.4-ac8
In-Reply-To: <200105292200.PAA29842@csl.Stanford.EDU>
In-Reply-To: <200105292200.PAA29842@csl.Stanford.EDU>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dawson Engler writes:
 > -------------------------------------------------------------------------------
 > [BUG] raddr seems to be a user pointer, but is written at the end of
 >       the system call.
 > 
 > ipc/shm.c: ERROR: system call 'sys_shmat' derefs non-tainted param= 3
 > 
 > asmlinkage long sys_shmat (int shmid, char *shmaddr, int shmflg, ulong *raddr)
 > {
 >         struct shmid_kernel *shp;
 > 
 > 
 > 	...
 >         *raddr = (unsigned long) user_addr;
 >         err = 0;
 >         if (IS_ERR(user_addr))
 >                 err = PTR_ERR(user_addr);
 >         return err;

Believe it or not, this one is OK :-)

All callers pass in a pointer to a local stack kernel variable
in raddr.

Later,
David S. Miller
davem@redhat.com

