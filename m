Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTKXLNC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 06:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTKXLNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 06:13:02 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:15614 "EHLO
	mwinf0101.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263740AbTKXLM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 06:12:59 -0500
Message-ID: <3FC1E93A.4090201@wanadoo.fr>
Date: Mon, 24 Nov 2003 12:19:22 +0100
From: Remi Colinet <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm5 : compile error
References: <3FBF5C79.5050409@wanadoo.fr> <Pine.LNX.4.53.0311220946280.2498@montezuma.fsmlabs.com> <3FBF99E6.1070402@wanadoo.fr> <Pine.LNX.4.53.0311221218350.2498@montezuma.fsmlabs.com> <3FBFA6DA.3070707@wanadoo.fr> <Pine.LNX.4.53.0311221438150.2498@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote

>
>Thanks for verifying that, the error was in my auto cvs import script. It 
>seems to have generated rejects. I presume the following patch would 
>suffice (including your other changes)?
>
>Index: linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c
>===================================================================
>RCS file: /build/cvsroot/linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c,v
>retrieving revision 1.1.1.1
>diff -u -p -B -r1.1.1.1 oprofile_stats.c
>--- linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c	21 Nov 2003 20:59:40 -0000	1.1.1.1
>+++ linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c	21 Nov 2003 21:27:44 -0000
>@@ -10,7 +10,8 @@
> #include <linux/oprofile.h>
> #include <linux/cpumask.h>
> #include <linux/threads.h>
>- 
>+#include <linux/smp.h>
>+
> #include "oprofile_stats.h"
> #include "cpu_buffer.h"
>  
>Index: linux-2.6.0-test9-mm5/include/linux/cpumask.h
>===================================================================
>RCS file: /build/cvsroot/linux-2.6.0-test9-mm5/include/linux/cpumask.h,v
>retrieving revision 1.1.1.1
>diff -u -p -B -r1.1.1.1 cpumask.h
>--- linux-2.6.0-test9-mm5/include/linux/cpumask.h	21 Nov 2003 20:59:57 -0000	1.1.1.1
>+++ linux-2.6.0-test9-mm5/include/linux/cpumask.h	21 Nov 2003 21:52:39 -0000
>@@ -39,9 +39,8 @@ typedef unsigned long cpumask_t;
> 
> 
> #ifdef CONFIG_SMP
>-
>+#include <asm/smp.h>
> extern cpumask_t cpu_online_map;
>-extern cpumask_t cpu_possible_map;
> 
> #define num_online_cpus()		cpus_weight(cpu_online_map)
> #define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
It is ok for me.

Thanks
Remi


