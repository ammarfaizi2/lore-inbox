Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbREVCYE>; Mon, 21 May 2001 22:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262235AbREVCXy>; Mon, 21 May 2001 22:23:54 -0400
Received: from marks-43.caltech.edu ([131.215.92.43]:36273 "EHLO
	velius.chaos2.org") by vger.kernel.org with ESMTP
	id <S262215AbREVCXr>; Mon, 21 May 2001 22:23:47 -0400
Date: Mon, 21 May 2001 19:23:36 -0700 (PDT)
From: Jacob Luna Lundberg <jacob@velius.chaos2.org>
To: Andrew Morton <andrewm@uow.edu.au>
cc: <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 del_timer_sync oops in schedule_timeout
In-Reply-To: <3B087525.3C498E9A@uow.edu.au>
Message-ID: <Pine.LNX.4.32.0105211912490.4055-100000@velius.chaos2.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 May 2001, Andrew Morton wrote:
> It could be timer-list corruption.  Someone released some memory
> which had a live timer in it.  The memory got recycled and then
> the timer list traversal fell over it.

Well I do have another oops now (artsd this time).  Once again it's in
del_timer_sync in 2.4.4, same computer after a reboot, same kernel.  It is
a UP system (SMP kernel) btw.

Could it be that the aic7xxx driver is improperly destroying a timer?  I
am having some problems with a scanner attached to the SCSI card in
question that usually result in the driver setting the scanner inactive
until I reset the scanner and rmmod/insmod the driver again.

Unable to handle kernel paging request at virtual address 2d5ca71f
 printing eip:
c011bf13
*pde  = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[del_timer_sync+47/132]
EFLAGS: 00013006
eax: a2e17a6a   ebx: 00003246   ecx: c4047f28   edx: 2d5ca71b
esi: 00000000   edi: 00000010   ebp: c4045f3c   esp: c4045f0c
ds: 0018   es: 0018   ss: 0018
Process artsd (pid: 2873, stackpage=c4045000)
Stack: c4047f28 0061afd0 c0112b54 c4047f28 c4045f28 00000000 c78143e0 00000000
       00000000 0061afd0 c4044000 c0112a80 c4045f70 c0140b7c 00000001 00000004
       c305c9d8 00000000 00000304 c4044000 00000014 00000005 00000000 00000000
Call Trace: [schedule_timeout+120/144] [process_timeout+0/92]
[do_select+456/512] [sys_select+816/1136] [system_call+55/64]

Code: 89 42 04 89 10 b8 01 00 00 00 01 c6 a1 68 20 30 c0 c7 41 04

-Jacob

-- 

At a global level, the most developed countries "stabilize" the wars
among the outcasts depending on how important each conflict is to the
global economy.

 - ``The Hacker Ethic'' by Pekka Himanen

