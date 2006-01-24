Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWAXRGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWAXRGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWAXRGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:06:37 -0500
Received: from fmr22.intel.com ([143.183.121.14]:45004 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030432AbWAXRGh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:06:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/2] _PPC frequency change issues
Date: Tue, 24 Jan 2006 09:06:27 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6007000574@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] _PPC frequency change issues
Thread-Index: AcYhAccC4SwDkr9nSUebRRLo9of+CgABQKZA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Thomas Renninger" <trenn@suse.de>, <cpufreq@www.linux.org.uk>
Cc: "Dominik Brodowski" <linux@brodo.de>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Jan 2006 17:06:28.0710 (UTC) FILETIME=[8424D860:01C62108]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for identifying the issues and sendint these patches Thomas.

Patch 1 looks clean. New lines seem to contain spaces instead of tabs.
The same issue is there in patch 2 as well. Can you resent it with
indentation fixed.

Patch 2 I am concenred with following hunk.

@@ -161,16 +158,17 @@
 		cpu_max_freq[cpu] = policy->max;
 		dprintk("limit event for cpu %u: %u - %u kHz, currently
%u kHz, last set to %u kHz\n", cpu, cpu_min_freq[cpu],
cpu_max_freq[cpu], cpu_cur_freq[cpu], cpu_set_freq[cpu]);
 		if (policy->max < cpu_set_freq[cpu]) {
-			__cpufreq_driver_target(&current_policy[cpu],
policy->max, 
-			      CPUFREQ_RELATION_H);
+            if (!__cpufreq_driver_target(policy, policy->max, 
+                            CPUFREQ_RELATION_H))
+                cpu_cur_freq[cpu] = policy->max;

Should this me cpu_cur_freq[cpu] = policy->cur instead. As the max
setting may not be supported by the driver, it might have set some
closer available freq

Same comment for below two driver target calls as well.


 		} else if (policy->min > cpu_set_freq[cpu]) {
-			__cpufreq_driver_target(&current_policy[cpu],
policy->min, 
-			      CPUFREQ_RELATION_L);
+            if (!__cpufreq_driver_target(policy, policy->min, 
+                            CPUFREQ_RELATION_L))
+                cpu_cur_freq[cpu] = policy->min;
 		} else {
-			__cpufreq_driver_target(&current_policy[cpu],
cpu_set_freq[cpu],
+            __cpufreq_driver_target(policy, cpu_set_freq[cpu],
 			      CPUFREQ_RELATION_L);
 		}


Thx,
Venki

>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de] 
>Sent: Tuesday, January 24, 2006 8:18 AM
>To: cpufreq@www.linux.org.uk
>Cc: Pallipadi, Venkatesh; Dominik Brodowski; Kernel Mailing List
>Subject: [PATCH 2/2] _PPC frequency change issues
>
>and the second one fixing the usergovernor for these machines...
>
