Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268097AbTBRXcx>; Tue, 18 Feb 2003 18:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268095AbTBRXcw>; Tue, 18 Feb 2003 18:32:52 -0500
Received: from air-2.osdl.org ([65.172.181.6]:53398 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268098AbTBRXct>;
	Tue, 18 Feb 2003 18:32:49 -0500
Date: Tue, 18 Feb 2003 15:39:19 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Arador <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: buggy include path?
Message-Id: <20030218153919.16d41430.rddunlap@osdl.org>
In-Reply-To: <20030219002938.08b717c7.diegocg@teleline.es>
References: <20030219002938.08b717c7.diegocg@teleline.es>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003 00:29:38 +0100
Arador <diegocg@teleline.es> wrote:

| Including include/usb.h from a external module source (out of the kernel tree)
| causes this:
| In file included from /home/diego/kernel/unsta/include/linux/irq.h:19,
|                  from /home/diego/kernel/unsta/include/asm/hardirq.h:6,
|                  from /home/diego/kernel/unsta/include/linux/interrupt.h:9,
|                  from /home/diego/kernel/unsta/include/linux/usb.h:15, <- file included
|                  from w9968cf.h:38,
|                  from w9968cf.c:57:
| /home/diego/kernel/unsta/include/asm/irq.h:16:25: irq_vectors.h: No such file or directory
| 
| However in include/asm/irq.h you can see:
| 
| #include <linux/config.h>
| #include <linux/sched.h>
| /* include comes from machine specific directory */
| #include "irq_vectors.h"
| 
| so who is wrong here? This include cames out
| of the specific machine directory; but it doesnt
| seems a wrong include.
| 
| irq_vectors.h is at: include/asm-i386/mach-default/irq_vectors.h

Actually it's in several places:
./include/asm-um/irq_vectors.h
./include/asm-i386/mach-default/irq_vectors.h
./include/asm-i386/mach-visws/irq_vectors.h
./include/asm-i386/mach-voyager/irq_vectors.h

and where it's included from is decided in linux/arch/i386/Makefile:
for example:
mflags-y += -Iinclude/asm-i386/mach-default

so the include directory is relative (ISTM).
Can the -Idirname be made more complete, e.g. by using
$TOPDIR or $MODLIB ... me wonders.
Or would that just be duplicating the default behavior?
Anyone?

--
~Randy
