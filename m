Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268972AbRHCMTR>; Fri, 3 Aug 2001 08:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268996AbRHCMTG>; Fri, 3 Aug 2001 08:19:06 -0400
Received: from [212.113.174.249] ([212.113.174.249]:26147 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S268972AbRHCMTA> convert rfc822-to-8bit;
	Fri, 3 Aug 2001 08:19:00 -0400
From: =?iso-8859-1?Q?Andr=E9_Cruz?= <afafc@rnl.ist.utl.pt>
To: <linux-kernel@vger.kernel.org>
Subject: BUG can fill process table
Date: Fri, 3 Aug 2001 13:18:37 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAArqXyEnDnsk6P8VUX1zHRj8KAAAAQAAAAKlzCr9qk3UyKnk0nEVtzhwEAAAAA@rnl.ist.utl.pt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2526.0000
X-OriginalArrivalTime: 03 Aug 2001 12:15:14.0576 (UTC) FILETIME=[F35A5900:01C11C15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a process (say dhcpcd) changes the IFF_UP flag to TRUE on an
interface (say eth0) to bring it up, a new process is created named
after the interface (eth0 in this case) and it's PPID is dhcpcd. 

If dhcpcd later changes the IFF_UP flag to FALSE to bring the interface
down, the eth0 process dies but stays as a zombie. The problem is that
dhcpcd never receives a sigchld (suposedly eth0 is it's child) and even
if it executes a wait() no process is reaped and wait() returns -1. 

The worse part of this is that when dhcpcd wants to bring up the
interface again a NEW eth0 process is created and so this starts to fill
up the process table. 

I see two solutions for this: either the interface process start with a
PPID of 1 (I noticed that init has no problems dealing with them when
they die) or dhcpcd should receive a sigchld and be able to reap them. 

Btw why are these process even created? 2.2 didn't do it I think.

I don't know where the problem lies so if someone could tell me who to
contact about this that would be great. Or maybe if this is already
known?

Thanks


----------
André Cruz

