Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUJWJVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUJWJVN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 05:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUJWJVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 05:21:13 -0400
Received: from dialup-4.246.12.161.Dial1.SanJose1.Level3.net ([4.246.12.161]:14976
	"EHLO nofear.bounceme.net") by vger.kernel.org with ESMTP
	id S264530AbUJWJVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 05:21:12 -0400
Message-ID: <417A2292.9090008@syphir.sytes.net>
Date: Sat, 23 Oct 2004 02:21:22 -0700
From: "C.Y.M" <syphir@syphir.sytes.net>
Reply-To: syphir@syphir.sytes.net
Organization: CooLNeT
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Unknown symbol kill_proc_info in 2.6.10-rc1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After building 2.6.10-rc1, i was unable to load my "lufs" module due to 
an unknown symbol error (kill_proc_info).  When I examined the 
2.6.10-rc1 patch, I noticed that "EXPORT_SYMBOL(kill_proc_info);" was 
removed from signal.c.  With the following patch, I was able to resolve 
my problem, but I am not sure if this is the correct method.  Is there a 
reason why the kill_proc_info symbol is no longer exported?

--- linux/kernel/signal.c.original      2004-10-23 02:12:32.000000000 -0700
+++ linux/kernel/signal.c       2004-10-23 01:37:36.000000000 -0700
@@ -1939,6 +1939,7 @@
  EXPORT_SYMBOL(force_sig);
  EXPORT_SYMBOL(kill_pg);
  EXPORT_SYMBOL(kill_proc);
+EXPORT_SYMBOL(kill_proc_info);
  EXPORT_SYMBOL(ptrace_notify);
  EXPORT_SYMBOL(send_sig);
  EXPORT_SYMBOL(send_sig_info);
