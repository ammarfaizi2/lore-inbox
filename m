Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSLPEkI>; Sun, 15 Dec 2002 23:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbSLPEkI>; Sun, 15 Dec 2002 23:40:08 -0500
Received: from rj.SGI.COM ([192.82.208.96]:40622 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S265077AbSLPEkH>;
	Sun, 15 Dec 2002 23:40:07 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: caf@guarana.org
Cc: Kevin Easton <kevin@sylandro.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 st + aic7xxx (Adaptec 19160B) + VIA KT333 repeatable freeze 
In-reply-to: Your message of "Mon, 16 Dec 2002 14:52:26 +1100."
             <20021216035226.GA30613@guarana.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Dec 2002 15:47:32 +1100
Message-ID: <8477.1040014052@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002 14:52:26 +1100, 
caf@guarana.org wrote:
>Running with nmi_watchdog=2 has made the problem a bit harder to
>reproduce[1], but when it does hang it doesn't produce a trace (I left it
>for several minutes just in case..).  Checking /proc/interrupts after 
>boot shows around 16 NMIs, which I presume means that it's being used? -
>although it didn't seem to be going up at anything like once every 5
>seconds.

nmi_watchdog=2 should pop once per second, nmi_watchdog=1 pops HZ
(usually 100) times per second.  Anything less than once a second is
not working.  One possibility is CONFIG_X86_UP_APIC, it should be y for
UP to use nmi_watchdog.

>Is it possible that I'm not seeing the trace because I'm using a VGA
>virtual console rather than a real serial console?

Depends on your boot parameters for console and the levels of console
printk.  Console output to X is unlikely to work, output to VGA
(including virtual consoles) should work.  Except that some
distributions change printk levels and even redirect output to a
different virtual console.

cat /proc/cmdline should have no console setting or 'console=tty0'.
Change boot options and reboot if necessary.

cat /proc/sys/kernel/printk should report 6 4 1 7, if not then
echo "6 4 1 7" > /proc/sys/kernel/printk

