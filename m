Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTD3Ws2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTD3Ws2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:48:28 -0400
Received: from firenze.terenet.com.br ([200.255.3.10]:44938 "EHLO
	firenze.terenet.com.br") by vger.kernel.org with ESMTP
	id S262498AbTD3WsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:48:25 -0400
From: Rafael Santos <rafael@thinkfreak.com.br>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Date: Wed, 30 Apr 2003 20:00:02 -0300
X-Priority: 3 (Normal)
Reply-To: rafael@thinkfreak.com.br
In-Reply-To: <p73vfwx2uw8.fsf@oldwotan.suse.de>
Message-Id: <1UVQRFALHIE82ZYICTO43SQVTC751.3eb05572@rafaelnote.ns1.lhost.com.br>
Subject: Re: software reset
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Opera 6.05 build 1140
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Just a doubt...

	#define MODULE 1
	#define __KERNEL__ 1

	What are those for? What do they do?



4/29/03 12:19:51 PM, Andi Kleen <ak@suse.de> wrote:

>joe briggs <jbriggs@briggsmedia.com> writes:
>
>> Can anyone tell me how to absolutely force a reset on a i386?  Specifically, 
>> is there a system call that will call the assembly instruction to assert the 
>> RESET bus line? I try to use the "reboot(LINUX_REBOOT_CMD_RESTART,0,0,NULL)" 
>> call, but it will not always work.  Occassionally, I experience a "missed 
>> interrupt" on a Promise IDE controller, and while I can telnet into the 
>> system, I can't reset it.  Any help greatly appreciated!  Since these systems 
>> are 1000's of miles away, the need to remotely reset it paramont.
>
>The most reliable way is to force a triple fault; load zero into
>the IDT register and then trigger an exception. The linux kernel 
>does that in fact for reboot and so far I haven't seen any machine failing
>to reset yet.
>
>-Andi
>
>If you don't trust reboot you can use something like (untested!).
>Compile with -c and load with insmod. I'm pretty sure it will reset
>your box.
>
>#define MODULE 1
>#define __KERNEL__ 1
>#include <linux/module.h>
>
>int init_module(void)
>{ 
>        static struct { 
>                short limit;
>                unsigned ptr;
>        } desc = { 64000, 0 }; 
>
>        asm volatile("lidt %0" : "m" (desc)); 
>        asm volatile("movl %0,%%esp ; int $3" : "g" (0)); 
>} 
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
Rafael Costa dos Santos
ThinkFreak Comércio e Soluções em Hardware e Software
Rio de Janeiro / RJ / Brazil
rafael@thinkfreak.com.br
+ 55 21 9432-9266


