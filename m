Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287276AbSALS2L>; Sat, 12 Jan 2002 13:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287279AbSALS2C>; Sat, 12 Jan 2002 13:28:02 -0500
Received: from a178d15hel.dial.kolumbus.fi ([212.54.8.178]:64265 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S287276AbSALS1t>; Sat, 12 Jan 2002 13:27:49 -0500
Message-ID: <3C407FBF.4C55F963@kolumbus.fi>
Date: Sat, 12 Jan 2002 20:26:07 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com>,
			<20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <3C3FC3B2.352EDF36@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Priority inheritance seems undesirable for Linux - these applications are
> already in the minority.   A realtime application on Linux should simply
> avoid complex system calls which can lead to blockage on a SCHED_OTHER
> thread.

I think it's very common to have SCHED_FIFO thread communicating with
various other processes through pipe/fifo/socket or some other IPC
mechanism.

It would be great to have priority inheritance where process receiving data
through fifo from SCHED_FIFO process would have raised priority for transfer
time. (see QNX priority inheriting message queues) Too bad we don't have
message queues so we could have send/receive/reply time priority
inheritance.

So we could have

Process 1 at SCHED_FIFO sending data to two processes.
Process 2 at SCHED_FIFO receiving data from process 1.
Process 3 at SCHED_OTHER receiving data from process 1.
Process 4 at SCHED_OTHER sending data to process 5.
Process 5 at SCHED_OTHER receiving data from process 4.

And (2) would get the data first from (1) and then (3). And if (1) starts
sending data to (2) system would immediately start running (1/2) and even
pre-empt the ongoing system call of (3). Also (1/3) would take over/pre-empt
(4/5) because (3) inherits priority from sending process (1).

If this is currently _not_ done I think it's very strange.

But I think I have misunderstood the whole point of original message... :)


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

