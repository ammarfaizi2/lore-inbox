Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317778AbSFSFjR>; Wed, 19 Jun 2002 01:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317780AbSFSFjQ>; Wed, 19 Jun 2002 01:39:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57350 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317778AbSFSFjQ>; Wed, 19 Jun 2002 01:39:16 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux 2.5.23 cpu_online_map undeclared
Date: Wed, 19 Jun 2002 05:36:08 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aep588$21j$1@penguin.transmeta.com>
References: <3D0FF715.7040601@linuxhq.com>
X-Trace: palladium.transmeta.com 1024465138 18970 127.0.0.1 (19 Jun 2002 05:38:58 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 19 Jun 2002 05:38:58 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3D0FF715.7040601@linuxhq.com>,
John Weber  <john.weber@linuxhq.com> wrote:
>I am running on a UP system, so I don't believe that cpu_online_map 
>should be declared.  Any suggestions?

Actually, it _should_ be declared, it's just that on UP it should be
defined to the constant 1.

Somehow that #define got dropped by the hotplug-CPU stuff.

To fix, just add a

	#define cpu_online_map		1

to the non-SMP parts of include/linus/smp.h. The patch looks something
like the appended (totally untested) thing.

Does that make UP happier?

		Linus

--- 1.8/include/linux/smp.h	Mon Jun 17 23:25:22 2002
+++ edited/include/linux/smp.h	Tue Jun 18 22:30:47 2002
@@ -86,6 +86,7 @@
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
+#define cpu_online_map				1
 #define cpu_online(cpu)				1
 #define num_online_cpus()			1
 #define __per_cpu_data
