Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318844AbSHWOzB>; Fri, 23 Aug 2002 10:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318845AbSHWOzB>; Fri, 23 Aug 2002 10:55:01 -0400
Received: from codepoet.org ([166.70.99.138]:59536 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318844AbSHWOzA>;
	Fri, 23 Aug 2002 10:55:00 -0400
Date: Fri, 23 Aug 2002 08:59:08 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac1
Message-ID: <20020823145907.GA24609@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208231046.g7NAk2914276@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 23, 2002 at 06:46:02AM -0400, Alan Cox wrote:
> Once I get a bit of time I'll resync with Marcelo and push him various
> updates.

I'm seeing tons of these type warnings:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -Os
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-nostdinc -iwithprefix include -DKBUILD_BASENAME=block_dev  -c -o block_dev.o block_dev.c
In file included from /usr/src/linux-2.4.19/include/asm/bitops.h:389,
                 from /usr/src/linux-2.4.19/include/linux/fs.h:26,
                 from /usr/src/linux-2.4.19/include/linux/capability.h:17,
                 from /usr/src/linux-2.4.19/include/linux/binfmts.h:5,
                 from /usr/src/linux-2.4.19/include/linux/sched.h:9,
                 from /usr/src/linux-2.4.19/include/linux/mm.h:4,
                 from block_dev.c:10:
/usr/src/linux-2.4.19/include/linux/bitops.h: In function `get_bitmask_order':
/usr/src/linux-2.4.19/include/linux/bitops.h:78: warning: implicit declaration of function `fls'

It appears that linux/bitops.h includes asm/bitops.h, which itself
includes linux/bitops.h prior to the #define fls(x)...  Both files
have include guards, therefore the #define never happens....
 
 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
