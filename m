Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269549AbRHCSsZ>; Fri, 3 Aug 2001 14:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269550AbRHCSsP>; Fri, 3 Aug 2001 14:48:15 -0400
Received: from real.realitydiluted.com ([208.242.241.164]:51721 "EHLO
	real.realitydiluted.com") by vger.kernel.org with ESMTP
	id <S269549AbRHCSsK>; Fri, 3 Aug 2001 14:48:10 -0400
Message-ID: <3B6AF00E.C66F69DE@cotw.com>
Date: Fri, 03 Aug 2001 13:40:14 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Building multipart modules with subdirectories...
In-Reply-To: <UTC200107021303.PAA496134.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This question has to do with the kernel build system as it relates to
building a driver both as static and as a module. I have a solution,
but I don't like it. Please read on...

I have driver that is rather complex and in order to maintain it, the
module is broke up into 17 different subdirectories. I am maintaining it
and I am trying to integrate it into the kernel build system. No, I am
not the original architect. Regardless, in the top level Makefile of
my driver directory I have the statement:

subdir-$(CONFIG_FOO_DRV) += $(17 directories' names)

When the module is built, the 'foodrv.o' object is placed in the top
level directory. The problem is that when a 'make modules_install' is
done, it uses the directories defined in 'subdir-$(CONFIG_FOO_DRV)' and
proceeds to fail installing in each of the subdirectories because there
is no target in their makefiles and nor should there be since their
objects are part of the top-level module object.

I could use the 'subdir-' directive above only when I am statically
linking in the driver, hence place it in an 'if' statement. Then when
I build the driver as a module, I manually enter each directory and
do a 'make -C <dir> modules'. However, since the 'subdir-' definition
would be missing if I am building as a module, no '.depend' files are
generated in my subdirectories when I do a 'make dep' which means if
I change a critical header file in my driver's common include
directory, the .c files using it will not be rebuilt! If I could
override the 'modules_install' target in each of my subdirectories
makefiles the problem would be solved. This is possible according to
a solution in the info pages for make, but it requires me to create a
GNUmakefile in each of my directories. Can someone perhaps give me
some ideas for this dilemna? Thanks.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
