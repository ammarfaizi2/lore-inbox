Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTJILWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 07:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTJILWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 07:22:13 -0400
Received: from ip5.searssiding.com ([216.54.166.5]:9600 "EHLO texas.encore.com")
	by vger.kernel.org with ESMTP id S262001AbTJILWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 07:22:11 -0400
Message-ID: <3F8544DF.85E7CA81@compro.net>
Date: Thu, 09 Oct 2003 07:22:07 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-ert i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Can't build external module against 2.6.0-test6 kernel 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to build a driver external to the kernel. I'm running 2.6.0-test6
kernel.
It appears to me (I'm probably wrong) that there is a kernel include file issue.

gcc -c rtom.c -D__KERNEL__ -DMODULE -DDEBUG -DDEBUG_LEVEL=6
-I/lib/modules/2.6.0-test6/build/include -I../include/linux/sys
-I../include/linux -I../include -O -o rtom
In file included from /lib/modules/2.6.0-test6/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.0-test6/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.0-test6/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.0-test6/build/include/linux/module.h:10,
                 from rtom.c:2:
/lib/modules/2.6.0-test6/build/include/asm/mpspec.h:6:25: mach_mpspec.h: No such
file or directory
In file included from /lib/modules/2.6.0-test6/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.0-test6/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.0-test6/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.0-test6/build/include/linux/module.h:10,
                 from rtom.c:2:
/lib/modules/2.6.0-test6/build/include/asm/mpspec.h:8: error `MAX_MP_BUSSES'
undeclared here 
(not in a function)
.
.



harley:/usr/src/linux-2.6.0-test6 # find ./ -name mach_mpspec.h

./include/asm-i386/mach-default/mach_mpspec.h
./include/asm-i386/mach-es7000/mach_mpspec.h
./include/asm-i386/mach-generic/mach_mpspec.h
./include/asm-i386/mach-summit/mach_mpspec.h
./include/asm-i386/mach-numaq/mach_mpspec.h
./include/asm-i386/mach-bigsmp/mach_mpspec.h



In the 'include/asm/mpspec.h' file:
#ifndef __ASM_MPSPEC_H
#define __ASM_MPSPEC_H

#include <linux/cpumask.h>
#include <asm/mpspec_def.h>    
#include <mach_mpspec.h>   <-----------------------------------------------

extern int mp_bus_id_to_type [MAX_MP_BUSSES];

It seems like something is amiss here. Isn't the include statment incorrect
above?

Thanks
Mark
