Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbRKPGtT>; Fri, 16 Nov 2001 01:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281215AbRKPGtI>; Fri, 16 Nov 2001 01:49:08 -0500
Received: from [195.211.46.202] ([195.211.46.202]:48930 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S281214AbRKPGsw>;
	Fri, 16 Nov 2001 01:48:52 -0500
X-Spam-Filter: check_local@serv02.lahn.de by digitalanswers.org
Date: Fri, 16 Nov 2001 07:44:11 +0100 (CET)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [OOPS] net/8139too
Message-ID: <Pine.LNX.4.33.0111160721120.6043-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML!

Since linux-2.4.15-pre[14]+kdb+freeswan I get an oops when stopping my
8139too network:

# ifdown eth0
eth0: unable to signal thread
# rmmod -a
<<< Unplug the network kable >>>
Inable to handle kernel paging request at virtual address c904b600
 printing eip:
c904b600
*pde = 0127d067
*pte = 00000000

Entering kdb (current=0xc792a000, pid 59) Oops: Oops
due to oops @ 0xc904b600
eax = 0xc904b600 ebx = 0xc217aaa0 ecx = 0xc9065000 edx = 0x00000020
esi = 0x04000001 edi = 0x00000009 esp = 0xc792beae eip = 0xc904b600
ebp = 0xc792bef6 xss = 0x00000018 xcs = 0x00000010 eflegs = 0x00010202
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc792be7a
kdb> bt
    EBP       EIP         Function(args)
0xc792bef6 0xc904b600 <unknown>+0xc904b600
                               kernel <unknown> 0x0 0x0 0x0

# ksymoops -A 0xc904b600
Adhoc c904b600 <[8139too]rtl8139_interrupt+0/dc>

Quoting from Documentation/networking/8139too.txt:
> Version 0.9.22 - November 8, 2001
> ...
> Version 0.9.21 - November 1, 2001
> ...
> * Fix problems with kernel thread exit.
an from drivers/net/8139too.c:
> Robert Kuebel - Save kernel thread from dying on any signal.

Hope that helps.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

