Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262982AbTCSKDB>; Wed, 19 Mar 2003 05:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262984AbTCSKDB>; Wed, 19 Mar 2003 05:03:01 -0500
Received: from webmail6.rediffmail.com ([202.54.124.151]:40147 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S262982AbTCSKC6>;
	Wed, 19 Mar 2003 05:02:58 -0500
Date: 19 Mar 2003 10:13:16 -0000
Message-ID: <20030319101316.25608.qmail@webmail6.rediffmail.com>
MIME-Version: 1.0
From: "Sudharsan  Vijayaraghavan" <sud_vijay@rediffmail.com>
Reply-To: "Sudharsan  Vijayaraghavan" <sud_vijay@rediffmail.com>
To: linux-kernel@vger.kernel.org
Cc: svijayar@cisco.com, narendiran_srinivasan@satyam.com
Subject: Compilation problems - kernel version 2.4.18
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently we installed RED HAT 8 in our PC.Now the kernel version 
is 2.4.18 previously the kernel version was 2.4.19
We changed it because we needed an even version which would be 
stable.
Unfortunately now we are facing new problems.
We tried compiling our own kernel modules. It gave a whole list of 
errors.The same code was compiling and also working fine
in 2.4.19 kernel.

The errors are confined with the header files included in our 
modules .

The original source code of the various header files are giving 
many errors hence could not generate the .o file.
We did not modify any of the original kernel source code.
For example on compiling our code with same make file we used 
earlier .. many errors show up , a sample of that is as follows.

++++++++++++++++++++++++++++++++++++++++++++++++++++

/usr/include/asm/signal.h : 107 parse error before "sigset_t"
                                      :   110 '}' token

/usr/include/linux/timer.h : 45 "spinlock_t"

+++++++++++++++++++++++++++++++++++++++++++++++++++++

Note : The same phrase for example "sigset_t" appears in signal.h 
.

Is its a problem with red hat 8 package installation itself or so 
much problems due kernel version change.
We guess that such a minor kernel change cannot lead to such 
errors.

kernel version : 2.4.18-14 [ stable one ]

+++++++++++++++++++++++++++++++++++++++++++++++++++++

Below is the contents of makefile .
-----------------------------------

CC=gcc
CFLAGS=-Wall -DMODULE -D__KERNEL__ -DLINUX -c

ppipe.o:	ppipe.c
 		$(CC) $(CFLAGS) ppipe.c

++++++++++++++++++++++++++++++++++++++++++++++++++++++

Below are the first few lines of our module.
--------------------------------------------

#include <linux/mm.h>
#include <linux/file.h>
#include <linux/poll.h>
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/init.h>

#include <asm/uaccess.h>
#include <asm/ipc.h>
#include <asm/ioctls.h>
#include <asm/poll.h>
/*
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way Unix traditionally does this, 
though.
  */

/* common code for old and new mmaps */

#define PPIPEFS_MAGIC 0x77777777
static long *latime;
/*struct pp {
 	long private_date;
 	long person_data;
};
struct pp *latime; */
//static int NUM_READOP;
/*
  * We use a start+len construction, which provides full use of 
the
  * allocated memory.
  * -- Florian Coosmann (FGC)
  *
  * Reads with count = 0 should always return 0.
  * -- Julian Bradfield 1999-06-07.
  */

asmlinkage int sys_ppipe(unsigned long * fildes,int n)
{
 	unsigned long fd[3];
 	int error;

 	error = do_ppipe(fd,n);
 	if (!error) {
 		if (copy_to_user(fildes, fd, 3*sizeof(long)))

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Please help me to solve this issue.

Thanks in advance,
Sudharsan.


_______________________________________________________________________
Odomos - the only  mosquito protection outside 4 walls -
Click here to know more!
http://r.rediff.com/r?http://clients.rediff.com/odomos/Odomos.htm&&odomos&&wn


ARISE, AWAKE AND STOP NOT TILL THE GOAL IS REACHED
