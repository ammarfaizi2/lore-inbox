Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSJDFfK>; Fri, 4 Oct 2002 01:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbSJDFfK>; Fri, 4 Oct 2002 01:35:10 -0400
Received: from pony1.arc.nasa.gov ([143.232.48.201]:30988 "EHLO
	mail.arc.nasa.gov") by vger.kernel.org with ESMTP
	id <S261346AbSJDFfJ>; Fri, 4 Oct 2002 01:35:09 -0400
Message-Id: <200210040540.WAA09498@mail.arc.nasa.gov>
Content-Type: text/plain; charset=US-ASCII
From: Chad Netzer <cnetzer@mail.arc.nasa.gov>
Reply-To: cnetzer@mail.arc.nasa.gov
Organization: San Jose State Foundation
To: "immortal1015" <immortal1015@hotpop.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How to replace the network cards (kernel newbies)
Date: Thu, 3 Oct 2002 22:39:59 -0700
X-Mailer: KMail [version 1.3.2]
References: <20021004045437.ABCA51B8535@smtp-2.hotpop.com>
In-Reply-To: <20021004045437.ABCA51B8535@smtp-2.hotpop.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 October 2002 21:56, immortal1015 wrote:
>
> Thanks. But how can I do it if I have move pcnet32.c to my own place.

Well, you can make a copy of the existing kernel tree, and simply 
modify things in there, then "make modules_install".  Or you can make a 
link from the kernel tree pcnet32.c, to your own.

If you don't have space or permissions for that, you are pretty much 
SOL, I think. :-)

Ok, I kid you.  Put the driver somewhere, and type something like:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-DMODULE  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include 
-DKBUILD_BASENAME=pcnet32  -c -o pcnet32.o pcnet32.c

Or whatever the actual command is that is output for the module when 
you build the unmodified kernel.

Then copy it to  /lib/modules/2.4.19/kernel/drivers/net/, or wherever, 
and "insmod" away.

-- 

Chad Netzer
cnetzer@mail.arc.nasa.gov
