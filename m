Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753848AbWKFWDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbWKFWDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753850AbWKFWDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:03:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62367 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753848AbWKFWDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:03:47 -0500
Subject: Re: 2.6.19 Microcode Update causes a ten second wait
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Benton <b3nt@supanet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <454FAA44.1080000@supanet.com>
References: <454FAA44.1080000@supanet.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 06 Nov 2006 23:03:44 +0100
Message-Id: <1162850624.3138.83.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 21:33 +0000, Andrew Benton wrote:
> Hello World
> With the 2.6.19 kernels I've tried (2.6.19-rc1-git7 and 
> 2.6.19-rc4-git10), enabling the Intel Microcode Update Driver causes the 
> kernel to hang for more than ten seconds when I boot. The last thing it 
> shows on the screen is `TCP reno registered' and then it just stops like 
> its a kernel panic. But it isn't, after about ten seconds the text flies 
> up the screen again and the system boots normally. Disabling support for 
> the microcode update makes the problem go away.

you're lucky, for me it hangs forever until I add this patch:

--- linux-2.6.18/arch/i386/kernel/microcode.c.org	2006-11-06 14:50:37.000000000 +0100
+++ linux-2.6.18/arch/i386/kernel/microcode.c	2006-11-06 14:52:30.000000000 +0100
@@ -577,7 +577,7 @@ static void microcode_init_cpu(int cpu)
 	set_cpus_allowed(current, cpumask_of_cpu(cpu));
 	mutex_lock(&microcode_mutex);
 	collect_cpu_info(cpu);
-	if (uci->valid)
+	if (uci->valid && system_state==SYSTEM_RUNNING)
 		cpu_request_microcode(cpu);
 	mutex_unlock(&microcode_mutex);
 	set_cpus_allowed(current, old);


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

