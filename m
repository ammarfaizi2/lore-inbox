Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280749AbRKTGkD>; Tue, 20 Nov 2001 01:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280934AbRKTGjw>; Tue, 20 Nov 2001 01:39:52 -0500
Received: from 24-25-196-177.san.rr.com ([24.25.196.177]:13330 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S280749AbRKTGjh>;
	Tue, 20 Nov 2001 01:39:37 -0500
Date: Mon, 19 Nov 2001 22:39:34 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Curt McCutchin <sitruc@mailandnews.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another wonderful OOPS! (why not tainted?)
Message-ID: <20011119223934.A20507@ecam.san.rr.com>
In-Reply-To: <20011119224528.3fae4411.sitruc@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20011119224528.3fae4411.sitruc@mailandnews.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 10:45:28PM -0600, Curt McCutchin wrote:
> -------------
> -debian woody
> -kernel 2.4.13 with robert love's preemptable-kernel patch (no visible difference of X snappiness)
> -reiserfs
> -ALSA 0.9.0beta8a sound driver
> -NVidia 1.0-1541 driver

Don't expect anyone to decode the OOPs but one thing that may cause problems is the
preempt patch and the stock NVidia driver. I think spinlocks get noop'ed in a standard
kernel build but the SMP builds and the preempt builds have non-trivial spinlocks. 
You might have a chance to run the SMP NVidia driver with the preempt patch. or you
may have to wait until the NVidia people build against a kernel with the preempt patch.

The nvnews site has a forum for the NVidia driver and you might try this report there.

http://www.nvnews.net/cgi-bin/ultimatebb.cgi?action=intro

The other question would be why did the oops not list the kernel as tainted?

> Nov 19 21:10:42 snotball kernel: EIP:    0010:[<c0148e84>]    Not tainted
> Nov 19 21:10:42 snotball kernel: EFLAGS: 00013a13
> Nov 19 21:10:42 snotball kernel: eax: d3b76713   ebx: d3b76780   ecx: d3e08d08   edx: d3b76780
> Nov 19 21:10:42 snotball kernel: esi: c023d5a0   edi: c1606240   ebp: d3c02940   esp: d58f7eec
> Nov 19 21:10:42 snotball kernel: ds: 0018   es: 0018   ss: 0018
> Nov 19 21:10:42 snotball kernel: Process XFree86 (pid: 220, stackpage=d58f7000)
> Nov 19 21:10:42 snotball kernel: Stack: d3b76780 d3c02940 d3b76780 c01461ad d3b76780 d3b88340 d3b76780 c01351a6 
> Nov 19 21:10:42 snotball kernel:        d3c02940 d421b0c0 d421b0c0 47813000 d421b3c0 c0125906 d421b0c0 47813000 
> Nov 19 21:10:42 snotball kernel:        00060000 00000000 c0125cb1 c176ae00 d421b0c0 47813000 00060000 d421b3c0 
> Nov 19 21:10:42 snotball kernel: Call Trace: [<c01461ad>] [<c01351a6>] [<c0125906>] [<c0125cb1>] [<c01916da>] 
> Nov 19 21:10:42 snotball kernel:    [<c010c4f6>] [<c0106e5b>] 
> Nov 19 21:10:42 snotball kernel: Code: 08 89 4a 04 89 11 89 43 08 89 43 0c 80 8b 08 01 00 00 10 ff 

