Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293150AbSCJSgF>; Sun, 10 Mar 2002 13:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293148AbSCJSfz>; Sun, 10 Mar 2002 13:35:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:266 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293150AbSCJSfq>;
	Sun, 10 Mar 2002 13:35:46 -0500
Message-ID: <3C8BA70A.206C0EFE@zip.com.au>
Date: Sun, 10 Mar 2002 10:33:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Kirkwood <matthew@hairy.beasts.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6: JFS vs gcc 2.95.4
In-Reply-To: <Pine.LNX.4.33.0203101600010.31738-100000@sphinx.mythic-beasts.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Kirkwood wrote:
> 
> Hi,
> 
> I can't build jfs in 2.5.6 with gcc 2.95.4 from Debian
> testing:
> 
> gcc -D__KERNEL__ -I/home/matthew/kern/linux-2.5.6/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=k6  -D_JFS_4K -DKBUILD_BASENAME=jfs_imap  -c -o jfs_imap.o
> jfs_imap.c
> jfs_imap.c: In function `diAlloc':
> /home/matthew/kern/linux-2.5.6/include/asm/rwsem.h:169: inconsistent
> operand constraints in an `asm'
> jfs_imap.c: In function `diNewIAG':
> /home/matthew/kern/linux-2.5.6/include/asm/rwsem.h:169: inconsistent
> operand constraints in an `asm'
> 
> I don't really speak gcc asm, so I don't know where to start
> on this.  Is it a known issue?
> 

This worked for me:

--- linux-2.5.6/include/asm-i386/rwsem.h	Tue Feb 19 18:11:01 2002
+++ 25/include/asm-i386/rwsem.h	Sat Mar  9 14:37:35 2002
@@ -164,7 +164,7 @@ LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n
 		"  jmp       1b\n"
 		LOCK_SECTION_END
 		"# ending __up_read\n"
-		: "+m"(sem->count), "+d"(tmp)
+		: /*"+m"(sem->count),*/ "+d"(tmp)
 		: "a"(sem)
 		: "memory", "cc");
 }

-
