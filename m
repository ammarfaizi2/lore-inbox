Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSFDJzi>; Tue, 4 Jun 2002 05:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSFDJzh>; Tue, 4 Jun 2002 05:55:37 -0400
Received: from vivi.uptime.at ([62.116.87.11]:29612 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S317473AbSFDJzh>;
	Tue, 4 Jun 2002 05:55:37 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>
Cc: "'Richard Henderson'" <rth@twiddle.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] Re: kernel 2.5.18 on alpha
Date: Tue, 4 Jun 2002 11:55:30 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <000001c20bad$f6aa7850$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <20020528191753.A5254@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> On Tue, May 28, 2002 at 04:29:15PM +0200, Oliver Pitzeier wrote:
> > I get this error when trying to compile kernel 2.5.18 on alpha.
> 
> Just intended to post the patch... :-)
> 
> - sync up with new pte/pfn/page/tlb macros
> - pcibios_init() should return int;
> - find last bit set: ctlz for ev67 and above, generic for others.
> 
> > /root/linux-2.5.18/include/linux/suspend.h:4:25: asm/suspend.h: No 
> > such file or directory
> 
> I'm not sure what to do with this. I doubt that we ever want 
> this file on alpha. For myself I moved "#include 
> <asm/suspend.h>" under #ifdef CONFIG_SOFTWARE_SUSPEND and 
> everything compiles.

Yes. It does! Great job! But there are new problems with 2.5.20. I try
to catch 'em. I may find the gizmo... :o)

I you want to know the error:
gcc -D__KERNEL__ -I/usr/src/linux-2.5.20/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
-Wa,-mev6    -DKBUILD_BASENAME=main  -c -o main.o main.c
In file included from /usr/src/linux-2.5.20/include/linux/pagemap.h:10,
                 from /usr/src/linux-2.5.20/include/linux/blkdev.h:9,
                 from /usr/src/linux-2.5.20/include/linux/blk.h:4,
                 from main.c:25:
/usr/src/linux-2.5.20/include/linux/highmem.h:80:42: macro
"clear_user_page" passed 3 arguments, but takes just 2
/usr/src/linux-2.5.20/include/linux/highmem.h:114:45: macro
"copy_user_page" passed 4 arguments, but takes just 3
In file included from /usr/src/linux-2.5.20/include/linux/pagemap.h:10,
                 from /usr/src/linux-2.5.20/include/linux/blkdev.h:9,
                 from /usr/src/linux-2.5.20/include/linux/blk.h:4,
                 from main.c:25:
/usr/src/linux-2.5.20/include/linux/highmem.h: In function
`clear_user_highpage':
/usr/src/linux-2.5.20/include/linux/highmem.h:80: `clear_user_page'
undeclared (first use in this function)
/usr/src/linux-2.5.20/include/linux/highmem.h:80: (Each undeclared
identifier is reported only once
/usr/src/linux-2.5.20/include/linux/highmem.h:80: for each function it
appears in.)
/usr/src/linux-2.5.20/include/linux/highmem.h:79: warning: unused
variable `addr'
/usr/src/linux-2.5.20/include/linux/highmem.h: In function
`copy_user_highpage':
/usr/src/linux-2.5.20/include/linux/highmem.h:114: `copy_user_page'
undeclared (first use in this function)
make[1]: *** [main.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.20/init'
make: *** [init] Error 2

Greetz,
 Oliver


