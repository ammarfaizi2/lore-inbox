Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263030AbREWJeH>; Wed, 23 May 2001 05:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263031AbREWJd5>; Wed, 23 May 2001 05:33:57 -0400
Received: from ns.digitalndigital.co.kr ([203.235.25.201]:13246 "EHLO
	digital-digital.com") by vger.kernel.org with ESMTP
	id <S263030AbREWJdx>; Wed, 23 May 2001 05:33:53 -0400
Message-ID: <026201c0e36b$6d10d780$2502a8c0@flyduck.flyduck.com>
From: =?ISO-8859-1?Q? "=C0=CC=C8=A3" ?= <i@flyduck.com>
To: "Blesson Paul" <blessonpaul@usa.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [Re: __asm__ ]
Date: Wed, 23 May 2001 18:33:28 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="euc-kr"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Blesson Paul Wrote:
>                   Thanks for the reply. I am sorry that I misspelled the
> line(__asm__(....)). It is from the get_current() function in
> asm-i386/current.h. But I am not clear what is the whole meaning of that
> line(__asm__(..)) in get_current(). I am doing a project in Linux related to
> VFS. From VFS. this function is called to get the base of the file system. I
> am not getting how this function will gave the base of the file system.
> get_current() is called from lookup_dentry function.
>              base=dget(current->fs->root)

get_current() returns the pointer to process descriptor 
(struct task_struct). Kernel allocates 8KB per each process,
which is used for the process descriptor of process, and
process kernel stack. So masking out 13 LSB of stack
poiniter yields the pointer to process descriptor. 

You can find more explanation in the Chapter 3 of 
<Understanding the Linux Kernel> 

fs field in the process descriptor describes the root directory
and the current working directory of the process. so
current->fs->root is the pointer to the directory entry of 
process' root directory. 

*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
Lee, Ho. Software Engineer, Embedded Linux Dep, LinuxOne 
ICQ : #52017992, Mail : flyduck@linuxone.co.kr, i@flyduck.com
Homepage : http://flyduck.com, http://linuxkernel.to


