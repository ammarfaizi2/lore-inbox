Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263063AbTCWNyZ>; Sun, 23 Mar 2003 08:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263064AbTCWNyZ>; Sun, 23 Mar 2003 08:54:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6818
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263063AbTCWNyW>; Sun, 23 Mar 2003 08:54:22 -0500
Subject: Re: smp overhead, and rwlocks considered harmful
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Vergoz <mvergoz@sysdoor.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030323133332.4693024e.mvergoz@sysdoor.com>
References: <20030322175816.225a1f23.akpm@digeo.com>
	 <20030323133332.4693024e.mvergoz@sysdoor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048432671.10727.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 15:17:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 12:33, Michael Vergoz wrote:
> Hi Andrew,
> 
> I would like to noticed to you that the SMP capacity can't be used on one process under Linux.
> 
> when you run 'time dd if=/dev/zero of=foo bs=1 count=1M', the capacity of 1 processor will
> use since your command sets is executed in ONE process.

Your dd is benchmarking the lock operations in the C library I suspect.
The kernel will happily use both processors and a given syscall can
evne start on one cpu and complete on another, or have the IRQ tasks
executed on its behalf on another CPU.

There are *good* reasons btw for avoiding splitting stuff too far, the
cost of copying data between processor caches is very high.

