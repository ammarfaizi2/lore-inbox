Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130164AbRA3MtQ>; Tue, 30 Jan 2001 07:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130191AbRA3MtG>; Tue, 30 Jan 2001 07:49:06 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:14089 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130164AbRA3MtA>;
	Tue, 30 Jan 2001 07:49:00 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Neale Banks <neale@lowendale.com.au>
cc: Stephen Rothwell <sfr@linuxcare.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18: apm initialised before dmi_scan? 
In-Reply-To: Your message of "Tue, 30 Jan 2001 22:47:02 +1100."
             <Pine.LNX.4.05.10101302229400.12161-100000@marina.lowendale.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Jan 2001 23:48:51 +1100
Message-ID: <1211.980858931@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001 22:47:02 +1100 (EST), 
Neale Banks <neale@lowendale.com.au> wrote:
>Looking more closely at a 2.2.18 bootup tonight I see that apm stuff
>appears in dmesg before dmi_scan does (I added "#define DUMP_DMI" in
>dmi_scan.c).
>
>If this implies that apm is initialised *before* the dmi_scan then there
>is potentially a problem with buggy BIOSen that oops instead of reporting
>power status

This should fix the link order, at the (small) expense of compiling
dmi_scan for exported symbols, even though it does not really export
symbols.  Against 2.2.18.

Index: 18.1/arch/i386/kernel/Makefile
--- 18.1/arch/i386/kernel/Makefile Thu, 23 Nov 2000 11:48:07 +1100 kaos (linux-2.2/E/b/40_Makefile 1.1.4.4 644)
+++ 18.2(w)/arch/i386/kernel/Makefile Tue, 30 Jan 2001 23:47:17 +1100 kaos (linux-2.2/E/b/40_Makefile 1.1.4.4 644)
@@ -15,8 +15,8 @@ all: kernel.o head.o init_task.o
 O_TARGET := kernel.o
 O_OBJS   := process.o signal.o entry.o traps.o irq.o vm86.o \
             ptrace.o ioport.o ldt.o setup.o time.o sys_i386.o \
-	    bluesmoke.o dmi_scan.o
-OX_OBJS  := i386_ksyms.o
+	    bluesmoke.o
+OX_OBJS  := i386_ksyms.o dmi_scan.o
 MX_OBJS  :=
 
 ifdef CONFIG_PCI

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
