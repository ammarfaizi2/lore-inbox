Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVAHJsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVAHJsT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVAHJrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:47:01 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:17629 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261858AbVAHJkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 04:40:52 -0500
Subject: [RFC] Patches to reduce delay in arch/kernel/time.c
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, John Stultz <johnstul@us.ibm.com>,
       David Shaohua <shaohua.li@intel.com>
Content-Type: text/plain
Message-Id: <1105176732.5478.20.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 08 Jan 2005 20:42:02 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Over the past couple of months there's been a fair bit of discussion
regarding clock drift after suspending, big pauses during suspending and
resuming and so on.  I believe this set of three patches, applied on top
of David's patch (now in Linus' tree) may address the remaining issues.
Comments please!

Patch 1: Replace multiple calls to get_cmos_time in both suspend and
resume routines with a single call. Since get_cmos_time waits for the
start of the next second before returning the result, This
reduces the delay for suspending and resuming by one second in each
case.
Patch 2: Make sleep start an unsigned long. This appears to address the
occasional 1hr 10min error seen by myself and John
(http://lkml.org/lkml/2004/12/15/290). Better solution?
Patch 3: Implement a new __get_cmos_time() function which doesn't delay
until the start of the new second before returning. Use it in suspending
(feel free to correct me, but I don't think having the
exact start of the second is necessary here).

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

