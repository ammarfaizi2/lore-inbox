Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbRCRDmW>; Sat, 17 Mar 2001 22:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129478AbRCRDmC>; Sat, 17 Mar 2001 22:42:02 -0500
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:2191 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S129408AbRCRDl4>; Sat, 17 Mar 2001 22:41:56 -0500
Message-ID: <3AB42E58.1FF1895F@bigfoot.com>
Date: Sat, 17 Mar 2001 19:41:12 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/uptime on SMP machines
In-Reply-To: <15027.62364.751528.388435@siemens.ikp.physik.tu-darmstadt.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Same for 2.2.19p17

except that init_tasks is a 2.4 struc.  Corrected as below.

rgds,
tim

--- 2.2.19pre17/fs/proc/array.c.old     Fri Mar 16 04:09:41 2001
+++ 2.2.19pre17/fs/proc/array.c.idle    Sat Mar 17 19:35:36 2001
@@ -339,9 +339,16 @@
 {
        unsigned long uptime;
        unsigned long idle;
+       int i;
 
        uptime = jiffies;
+#ifdef CONFIG_SMP
+       for (idle =0,i = 0; i < smp_num_cpus; i++)
+       idle += (task[i]->times.tms_utime +
+               task[i]->times.tms_stime)/smp_num_cpus;
+#else
        idle = task[0]->times.tms_utime + task[0]->times.tms_stime;
+#endif
 
        /* The formula for the fraction parts really is ((t * 100) / HZ) % 100, but
           that would overflow about every five days at HZ == 100.

--
