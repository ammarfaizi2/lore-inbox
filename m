Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275261AbTHGKc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275263AbTHGKc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:32:56 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:42631 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S275261AbTHGKcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:32:53 -0400
Message-ID: <3F322919.AFFC7B6F@cs.fujitsu.co.jp>
Date: Thu, 07 Aug 2003 19:25:29 +0900
From: Takeharu KATO <tkato@cs.fujitsu.co.jp>
Organization: Fujitsu Limited
X-Mailer: Mozilla 4.75 [ja] (Win98; U)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linuxppc-dev@lists.linuxppc.org
Subject: [RFC] new feattures to improve linux interrupt response
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers:

We have a plan to implement new features of Linux kernel for
embedded systems.
In particular, these features are planed to improve interrupt 
response on Linux. 
Please tell us whether someone has been engaged in 
working about the same features yet.
Of course any comments are welcome.
We describe the feature as follows. 

[1] Problems to be solved

We focus on the following problems to use Linux on the embedded systems.

(1)　Long critical sections
	Linux has longer critical sections than RTOS.
	So the invocation of interrupt handler may be delayed until executions of 
	critical section 
	is ended for long time.	The issue declines the response time to interrupts.

(2)　The handling order of interrupts is not guaranteed.
	Current Linux kernel does not guarantee the handling order of interrupts
 	, so any kind of interruptions can interrupt on  handlers
	which is not set SA_INTERRUPT flags.
	
	By the way, typically, when we design the systems, we assign the interrupt
	priority on each devices by its importance.
	(e.g. Some systems need to handle network devices before disk devices,
	other systems need to handle disk devices have most important priority.).
	These priorities are decided by the system's character. In such cases,
	developers need the mechanism to guarantee interruption handling order for
	their systems.
	

[2] The proposed features

	We are engaged in implementing following facilities.
	These features can be enabled/disabled by kernel configuration.
	If users disable these features in kernel configuration,
	our modification will make no effect on kernel behaviors.

	a)　Quick interruption handling facility for embedded systems
		We are designing and implementing quick interrupt handling facility 
		for embedded systems. This is achieved by accepting some 
		interrupts(these are pre-defined in kernel configuration.) in current 
		Linux kernel's critical sections. 
		
		We will modify local_irq_disable/local_irq_enable macros
		to keep interrupt masks of some interrupts which need to handle quickly
		un-masked in most of kernel critical sections.
		
	b)　Priority based interrupt handler facility
		We adopt interrupt priorities for interrupt handlers(top half handlers)
		to handle interruption orderly(like Solaris).  
		In current plan, these priorities are set in kernel configuration,
		so this feature will make no effects on  current interrupt handler
		handlers API (request_irq/free_irq and so on.). 
		
		This is achieved by invoking interrupt handlers by kernel threads.
		These threads are created for each priority. Interrupt 
		priority is represented by thread's priority.


[3] About target platform
We will implement these features on PowerPC 405GP(r) platform at first.

Sincerely, yours


-- 
Takeharu KATO
Fujitsu Limited
Email:tkato@cs.fujitsu.co.jp
