Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261588AbSJIM3y>; Wed, 9 Oct 2002 08:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbSJIM3y>; Wed, 9 Oct 2002 08:29:54 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:47306 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261588AbSJIM3x> convert rfc822-to-8bit; Wed, 9 Oct 2002 08:29:53 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.41 s390.
Date: Wed, 9 Oct 2002 14:33:30 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210091425.36762.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
the latest s/390 changes for 2.5.41. Most of it is adaptions to recent changes,
only the last three contain "real" changes:

01: Use the generic method to generate asm-offsets.h, fix some inclues and
    fix signal dequeueing in the 31 bit emulation code.
02: Remove last traces of tq_struct from the s390 drivers.
03: Work queues can't be use for 3215 and 3270 at the moment because they
    get initialized to late for the console. Therefore I replaced them
    by tasklets. This works but if the tasklets are supposed to go away
    then I have a problem.
04: A typo in vmlinus.lds.S
05: A superfluous memset.
06: A fix for strace. We noticed that some svcs didn't show up correctly
    in the strace output. Heiko debugged this an found that executed svcs
    are not handled properly. The execute instruction is an odd one, it
    points to another instruction to be executed in place of the execute
    instruction. In this case strace does not see an svc instruction but
    an execute at the current ip. Unluckily the two instruction have a
    different length. strace can't reliably distinguish between these
    two cases because the execute instruction could end just like an
    svc instruction. So the kernel has to provide the svc number to
    strace.
07: 3270 update from Richard Hitt.
08: A patch to remove duplicated code in the 31 bit emulation and use
    the generic code in kernel/uid16.c instead. This patch might be
    a bit problematic because it adds the __UID16 define to common
    code files which is ugly.

Just for info: hwc, lcs and tape are currently rewritten. So don't worry
about uglyness in their current implementation. At the moment its enough
that they compile.

blue skies,
  Martin.


