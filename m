Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWCPWPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWCPWPW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWCPWPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:15:22 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44745 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964874AbWCPWPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:15:22 -0500
Date: Thu, 16 Mar 2006 23:15:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alexander Gran <alex@zodiac.dnsalias.org>
cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Bug while trying to mount nfs share
In-Reply-To: <200603162220.59240@zodiac.zodiac.dnsalias.org>
Message-ID: <Pine.LNX.4.61.0603162308150.27951@yvahk01.tjqt.qr>
References: <200603151244.34159@zodiac.zodiac.dnsalias.org>
 <Pine.LNX.4.61.0603162133100.11776@yvahk01.tjqt.qr>
 <200603162220.59240@zodiac.zodiac.dnsalias.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >127MB HIGHMEM available.
>> >896MB LOWMEM available.
>>
>> BTW, you could try ot VMSPLIT_3G_OPT.
>
>Which works ;) BTW: Why do I need to recompile the complete kernel for that 
>option, and isn't there any negative impact (The menuconfig help doesn't 
>mention anything...)
>

Every file somehow depends on page.h. Only one file in kernel/*.c (taking 
.h in .h into account) does not require page.h, sys_ni.c:

23:08 shanghai:../linux-2.6-AS24/kernel > diff -dpru <(ls -1 .*.o.cmd) 
<(grep -l /page.h .*.o.cmd)
--- /dev/fd/63  2006-03-16 23:09:20.248517000 +0100
+++ /dev/fd/62  2006-03-16 23:09:20.248517000 +0100
@@ -1,4 +1,3 @@
-.built-in.o.cmd
 .capability.o.cmd
 .configs.o.cmd
 .dma.o.cmd
@@ -31,7 +30,6 @@
 .signal.o.cmd
 .softirq.o.cmd
 .sys.o.cmd
-.sys_ni.o.cmd
 .sysctl.o.cmd
 .time.o.cmd
 .timer.o.cmd


Jan Engelhardt
-- 
