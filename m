Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbTCFAL7>; Wed, 5 Mar 2003 19:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbTCFAL7>; Wed, 5 Mar 2003 19:11:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:62081 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267361AbTCFAL6>;
	Wed, 5 Mar 2003 19:11:58 -0500
Date: Wed, 5 Mar 2003 16:22:25 -0800
From: Bob Miller <rem@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>, mochel@osdl.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bugme-new] [Bug 442] New: compile failure in drivers/cpufreq/userspace.c (fwd)
Message-ID: <20030306002225.GA10819@doc.pdx.osdl.net>
References: <657950000.1046904813@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657950000.1046904813@flay>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 02:53:33PM -0800, Martin J. Bligh wrote:
>   gcc -Wp,-MD,drivers/cpufreq/.userspace.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
> -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default
> -nostdinc -iwithprefix include    -DKBUILD_BASENAME=userspace
> -DKBUILD_MODNAME=userspace -c -o drivers/cpufreq/.tmp_userspace.o
> drivers/cpufreq/userspace.c
> drivers/cpufreq/userspace.c: In function `cpufreq_governor_userspace':
> drivers/cpufreq/userspace.c:514: structure has no member named `intf'
> drivers/cpufreq/userspace.c:523: structure has no member named `intf'
> make[2]: *** [drivers/cpufreq/userspace.o] Error 1
> make[1]: *** [drivers/cpufreq] Error 2
> make: *** [drivers] Error 2

I believe the patch below fixes the problem.  Pat?

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


===== userspace.c 1.1 vs edited =====
--- 1.1/drivers/cpufreq/userspace.c	Sun Feb 16 05:23:39 2003
+++ edited/userspace.c	Wed Mar  5 16:12:16 2003
@@ -511,7 +511,7 @@
 		cpu_min_freq[cpu] = policy->min;
 		cpu_max_freq[cpu] = policy->max;
 		cpu_cur_freq[cpu] = policy->cur;
-		device_create_file (policy->intf.dev, &dev_attr_scaling_setspeed);
+		device_create_file (policy->dev, &dev_attr_scaling_setspeed);
 		memcpy (&current_policy[cpu], policy, sizeof(struct cpufreq_policy));
 		up(&userspace_sem);
 		break;
@@ -520,7 +520,7 @@
 		cpu_is_managed[cpu] = 0;
 		cpu_min_freq[cpu] = 0;
 		cpu_max_freq[cpu] = 0;
-		device_remove_file (policy->intf.dev, &dev_attr_scaling_setspeed);
+		device_remove_file (policy->dev, &dev_attr_scaling_setspeed);
 		up(&userspace_sem);
 		module_put(THIS_MODULE);
 		break;
