Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVDIFCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVDIFCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 01:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVDIFCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 01:02:45 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:436 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261283AbVDIFCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 01:02:39 -0400
Date: Sat, 09 Apr 2005 01:02:52 -0400
From: philip dahlquist <dahlquist@kreative.net>
Subject: easy softball jiffies quest(ion)
To: linux-kernel@vger.kernel.org
Message-id: <20050409010252.2eca2177.dahlquist@kreative.net>
MIME-version: 1.0
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i'm on a quest to get access to jiffies in user space so i can write a
simple stepper motor driver program.  i co-opted the "#includes" list 
from alessandro rubini's jit.c file from "linux device drivers" to write
jfi.c.

this is it:
------------------------------------------------------------------
#include <linux/config.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>

#include <linux/time.h>
#include <linux/timer.h>
#include <linux/kernel.h>
#include <linux/proc_fs.h>
#include <linux/types.h>
#include <linux/spinlock.h>
#include <linux/interrupt.h>

#include <asm/hardirq.h>


int main(void)
{
	unsigned long j = jiffies + (50 * HZ);
	printf("start jiffies = %9li\n",jiffies);
	while(jiffies < j)
		;
	
	printf("done jiffies = %9li\n", jiffies);
	return 0;
}

-----------------------------------------------------------
all right, you can giggle, but no laughing out loud, my kernel ego is
nacent and fragile.

when i compile it with:

gcc -o jfi.x jfi.c

i get a handful of errors regarding various #include statements:
-------------------------------------------------
jfi.c:3:31: linux/moduleparam.h: No such file or directory
In file included from jfi.c:6:
/usr/include/linux/time.h:10: error: syntax error before "time_t"
/usr/include/linux/time.h:12: error: syntax error before '}' token
/usr/include/linux/time.h:18: error: syntax error before "time_t"
/usr/include/linux/time.h:44: error: field `it_interval' has incomplete type
/usr/include/linux/time.h:45: error: field `it_value' has incomplete type
/usr/include/linux/time.h:49: error: field `it_interval' has incomplete type
/usr/include/linux/time.h:50: error: field `it_value' has incomplete type
jfi.c:7:25: linux/timer.h: No such file or directory
In file included from /usr/include/linux/interrupt.h:9,
                 from jfi.c:12:
/usr/include/asm/bitops.h:327:2: warning: #warning This include file is
not available on all architectures.
/usr/include/asm/bitops.h:328:2: warning: #warning Using kernel headers
in userspace: atomicity not guaranteed
In file included from jfi.c:12:
/usr/include/linux/interrupt.h:12:25: asm/hardirq.h: No such file or directory
/usr/include/linux/interrupt.h:13:25: asm/softirq.h: No such file or directory

jfi.c: In function `main':
jfi.c:19: error: `jiffies' undeclared (first use in this function)
jfi.c:19: error: (Each undeclared identifier is reported only once
jfi.c:19: error: for each function it appears in.)
./jfsh: line 8: jfi.x: command not found
---------------------------------------------------------------------

i kind of figured you guys would know what to do.  it's sort of a rarefied
group.  anyway, if you can help, i'd really appreciate it, because 
alessandro's makefile was somewhat cryptic.

  
you know, the operating systems class this semester at the university 
of maryland, college park, was taught based on that new, exciting os, win xp.
and he managed to turn a 2 day class, where a day has a lecture and a lab,
into a 4 day affair, monday lecture, tuesday lab, wednesday lecture, thursday
lab. i took data structures instead. i am not taking any win xp os
class. it's linux or nothing.  can you believe that, win xp?

one more thing, um, i'm paralyzed from the shoulders down, but i can type
with both hands using typing aids, and i also use a kensington "expert mouse"
trackball.  i would like to write a mouse manager where i could assign 
different actions for each button, something very similar to the kensington
interface that's available for, um, windows.  i found some xwindow functions
for button pressing events, but i don't know how to get into the mouse driver 
or button events in xwindows or gnome, etc.

if somebody has a direction to go for that, that would be a big help.

thanks, or tgfl(inux),
philip dahlquist
