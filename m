Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261848AbSI3AAE>; Sun, 29 Sep 2002 20:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbSI2X7b>; Sun, 29 Sep 2002 19:59:31 -0400
Received: from packet.digeo.com ([12.110.80.53]:55211 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261848AbSI2X6R>;
	Sun, 29 Sep 2002 19:58:17 -0400
Message-ID: <3D9794D5.9551485E@digeo.com>
Date: Sun, 29 Sep 2002 17:03:33 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: cwhmlist@bellsouth.net
CC: linux-kernel@vger.kernel.org
Subject: Re: How to capture bootstrap oops?
References: <20020929235607.FLPK26495.imf20bis.bellsouth.net@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2002 00:03:35.0546 (UTC) FILETIME=[D23A35A0:01C26814]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cwhmlist@bellsouth.net wrote:
> 
> I need some help, I'm new to this.  I have compliled a 2.5.39 kernel for
> my quad pentium pro system and it is oopsing on bootup.  Unfortunently,
> it looks like a good portion of the oops scrolls off of the screen.  Since
> I don't have the ability to hook up a serial terminal, how do I capture
> this oops so I can report it?

This might suffice?

--- linux-2.5.39/arch/i386/kernel/traps.c	Fri Sep 27 15:09:03 2002
+++ 25/arch/i386/kernel/traps.c	Sun Sep 29 17:02:38 2002
@@ -292,6 +292,8 @@ void die(const char * str, struct pt_reg
 	handle_BUG(regs);
 	printk("%s: %04lx\n", str, err & 0xffff);
 	show_registers(regs);
+	for ( ; ; )
+		;
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
