Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423382AbWBBIsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423382AbWBBIsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423060AbWBBIsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:48:04 -0500
Received: from mail.asdfg.lv ([83.136.139.133]:41875 "HELO mail.asdfg.lv")
	by vger.kernel.org with SMTP id S1423384AbWBBIsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:48:03 -0500
X-Antivirus-ASDFG-Mail-From: waters@inbox.lv via mail
X-Antivirus-ASDFG: 1.24-st-qms (Clear:RC:1(10.10.200.230):. Processed in 0.058258 secs Process 5084)
Date: Thu, 2 Feb 2006 10:45:54 +0200
From: kasp <waters@inbox.lv>
X-Mailer: The Bat! (v2.00.6) Business
Reply-To: kasp <waters@inbox.lv>
X-Priority: 3 (Normal)
Message-ID: <293455779.20060202104554@inbox.lv>
To: linux-kernel@vger.kernel.org
Subject: DEVICE POLLING
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've read that *BSD like systems support device polling:

------------------------------------------------------------
You  can  enable DEVICE_POLLING in your kernel. DEVICE_POLLING changes
the  method  through  which  data  gets  from your network card to the
kernel. Traditionally, each time the network card needs attention (for
example when it receives a packet), it generates an interrupt request.
The  request  causes  a  context  switch  and  a  call to an interrupt
handler.  A  context  switch is when the CPU and kernel have to switch
from  user  land  (the  user's  programs  or daemons), and kernel land
(dealing with device drivers, hardware, and other kernel-bound tasks).
The   last  few  years  have  seen  significant  improvements  in  the
efficiency of context switching but it is still an extremely expensive
operation.  Furthermore,  the  amount  of  time the system can have to
spend  when  dealing  with an interrupt can be almost limitless. It is
completely possible for an interrupt to never free the kernel, leaving
your machine unresponsive. Those of us unfortunate enough to be on the
wrong side of certain Denial of Service attacks will know about this.

The  DEVICE_POLLING option changes this behavior. It causes the kernel
to  poll  the  network  card  itself  at  certain predefined times: at
defined  intervals,  during  idle  loops, or on clock interrupts. This
allows the kernel to decide when it is most efficient to poll a device
for  updates and for how long, and ultimately results in a significant
increase in performance.

If  you  want to take advantage of DEVICE_POLLING, you need to compile
two options in to your kernel:

    * options DEVICE_POLLING
    * options HZ=1000

The  first line enables DEVICE_POLLING and the second device slows the
clock  interrupts  to  1000  times  per  second. The need to apply the
second,  because in the worst case your network card will be polled on
clock  ticks.  If  the clock ticks very fast, you would spend a lot of
time polling devices which defeats the purpose here.

Finally  we need to change one sysctl to actually enable this feature.
You  can  either  enable polling at runtime or at boot. If you want to
enable it at boot, add this line to the end of your /etc/sysctl.conf:

    * kern.polling.enable=1

The  DEVICE_POLLING  option  by default does not work with SMP enabled
kernels. When the author of the DEVICE_POLLING code initially commited
it  he  admits  he  was  unsure  of  the  benefits of the feature in a
multiple-CPU  environment, as only one CPU would be doing the polling.
Since  that  time  many  administrators  have  found  that  there is a
significant  advantage  to  DEVICE_POLLING even in SMP enabled kernels
and that it works with no problems at all. If you are compiling an SMP
kernel       with       DEVICE_POLLING,       edit      the      file:
/usr/src/sys/kern/kern_poll.c and remove the following lines:

        #ifdef SMP
        #include "opt_lint.h"
        #ifndef COMPILING_LINT
        #error DEVICE_POLLING is not compatible with SMP
        #endif
        #endif
      
---------------------------------------------------------------------------
  

So, are there any feature like that in linux kernel supported?

P.S. http://silverwraith.com/papers/freebsd-tuning.php

-- 
Best regards,
 kasp                          mailto:waters@inbox.lv

