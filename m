Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVK2Q55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVK2Q55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVK2Q55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:57:57 -0500
Received: from 65-117-135-105.dia.cust.qwest.net ([65.117.135.105]:989 "EHLO
	santa.timesys.com") by vger.kernel.org with ESMTP id S932201AbVK2Q55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:57:57 -0500
From: Egan <tony.egan@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17292.34963.717045.706135@santa.timesys.com>
Date: Tue, 29 Nov 2005 11:57:55 -0500
To: linux-kernel@vger.kernel.org
CC: tony.egan@timesys.com
Subject: 2.6.14-rt21 doesn't build for ppc
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



2.6.14 with RT21 fails to build for ppc (ibm440gx).  



      CC      kernel/timer.o
    /home/egan/downloads/linux-2.6.14/kernel/timer.c: In function `phase_advance':
    /home/egan/downloads/linux-2.6.14/kernel/timer.c:991: error: `time_phase' undeclared (first use in this function)
    /home/egan/downloads/linux-2.6.14/kernel/timer.c:991: error: (Each undeclared identifier is reported only once
    /home/egan/downloads/linux-2.6.14/kernel/timer.c:991: error: for each function it appears in.)
    /home/egan/downloads/linux-2.6.14/kernel/timer.c:994: warning: type defaults to `int' in declaration of `__x'
    /home/egan/downloads/linux-2.6.14/kernel/timer.c: In function `update_wall_time':
    /home/egan/downloads/linux-2.6.14/kernel/timer.c:1050: error: too few arguments to function `phase_advance'
    /home/egan/downloads/linux-2.6.14/kernel/timer.c:1040: warning: unused variable `time_phase'
    make[2]: *** [kernel/timer.o] Error 1
    make[1]: *** [kernel] Error 2
    make: *** [zImage] Error 2




Adding config GENERIC_TIME to arch/ppc/Kconfig results in a failure later in
the build.




      CC      kernel/time/clockevents.o
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c:80: error: conflicting types for 'timer_interrupt'
    include2/asm/hw_irq.h:12: error: previous declaration of 'timer_interrupt' was here
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c:80: error: conflicting types for 'timer_interrupt'
    include2/asm/hw_irq.h:12: error: previous declaration of 'timer_interrupt' was here
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c: In function `handle_tick_update_profile':
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c:126: warning: implicit declaration of function `profile_tick'
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c:126: error: `CPU_PROFILING' undeclared (first use in this function)
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c:126: error: (Each undeclared identifier is reported only once
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c:126: error: for each function it appears in.)
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c: In function `handle_update_profile':
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c:143: error: `CPU_PROFILING' undeclared (first use in this function)
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c: In function `handle_profile':
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c:151: error: `CPU_PROFILING' undeclared (first use in this function)
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c: In function `setup_event':
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c:326: error: `SA_NODELAY' undeclared (first use in this function)
    /home/egan/downloads/linux-2.6.14/kernel/time/clockevents.c:329: warning: implicit declaration of function `setup_irq'
    make[3]: *** [kernel/time/clockevents.o] Error 1
    make[2]: *** [kernel/time] Error 2
    make[1]: *** [kernel] Error 2
    make: *** [zImage] Error 2



After some research it looks like this breakage was introduced by rt16.
rt15 builds OK.

Please retain my CC in any replies.

Thanks,

Tony
