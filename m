Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbTCEPWr>; Wed, 5 Mar 2003 10:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbTCEPWr>; Wed, 5 Mar 2003 10:22:47 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:19847 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S267196AbTCEPWq>; Wed, 5 Mar 2003 10:22:46 -0500
Date: Thu, 6 Mar 2003 02:36:51 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.64 - cpufreq/userspace compile failure (with patch)
Message-ID: <20030305153651.GF2075@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel failed to compile with the cpufreq userspace option being
set. I looked at the code a bit and figured the following patch would
solve it. Haven't tested the kernel yet though.

--- drivers/cpufreq/userspace.c.old	Thu Mar  6 02:01:39 2003
+++ drivers/cpufreq/userspace.c	Thu Mar  6 02:01:42 2003
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

The problem was that intf was not a member of the cpyfreq_policy struct
(or any other struct in any related .h files that I could see)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to         kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

