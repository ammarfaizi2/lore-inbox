Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVIVDZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVIVDZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 23:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVIVDZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 23:25:38 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:59801 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030199AbVIVDZi (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 21 Sep 2005 23:25:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=HRXsCLvbOyIpAJc30tPlk21NFg41Cd1FS8i0HX4ClXuR4zTsBLNoaU2ljeznYRGukc8UJ7J7Jmt8eZPRVStE6IOfRCJsBQrONzCCSxPNBRRJelWX3fBPYxRNuOWM1W1YVcbgeY6WTI82DpWhjgBOQm8DRlruIrd2EhCEzpgEslc=  ;
Message-ID: <43322445.6050003@yahoo.com.au>
Date: Thu, 22 Sep 2005 13:25:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ncunningham@cyclades.com, shaohua.li@intel.com, vatsa@in.ibm.com,
       Linux-Kernel@vger.kernel.org, spyro@f2s.com, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 2.6.14-rc1-git5] sched: disable preempt in idle tasks
References: <43317F3E.9090207@yahoo.com.au> <20050921183138.52bcdf27.akpm@osdl.org>
In-Reply-To: <20050921183138.52bcdf27.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060107080905060401060101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060107080905060401060101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>This patch should hopefully fix Nigel's bug.
>>
>> Split out from sched-resched-opt.patch. Tested on i386 with acpi idle
>> and poll idle (previous iterations tested on various other architectures).
> 
> 
> This makes the emt64 machine reboot itself, which iirc was the behaviour in
> the failing patch from which this one was split out.
> 
> The machine is using acpi_processor_idle().
> 

OK, thanks. That must be the preempt_disable() being called in
start_secondary(). Maybe I should have listened to the comment.

Can you try the following patch?

-- 
SUSE Labs, Novell Inc.


--------------060107080905060401060101
Content-Type: text/plain;
 name="sched-no-preempt-idle-x86-64-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-no-preempt-idle-x86-64-fix.patch"

Index: linux-2.6/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/smpboot.c	2005-09-22 01:04:03.000000000 +1000
+++ linux-2.6/arch/x86_64/kernel/smpboot.c	2005-09-22 13:24:11.000000000 +1000
@@ -473,8 +473,8 @@ void __cpuinit start_secondary(void)
 	 * booting is too fragile that we want to limit the
 	 * things done here to the most necessary things.
 	 */
-	preempt_disable();
 	cpu_init();
+	preempt_disable();
 	smp_callin();
 
 	/* otherwise gcc will move up the smp_processor_id before the cpu_init */

--------------060107080905060401060101--
Send instant messages to your online friends http://au.messenger.yahoo.com 
