Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbSJHPaN>; Tue, 8 Oct 2002 11:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261298AbSJHPaN>; Tue, 8 Oct 2002 11:30:13 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:9114 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S261296AbSJHPaJ>; Tue, 8 Oct 2002 11:30:09 -0400
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Ofer Raz'" <oraz@checkpoint.com>, <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.9/2.4.18 max kernel allocation size
Date: Tue, 8 Oct 2002 10:35:35 -0500
Message-ID: <008b01c26ee0$5ee52380$9d893841@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <027801c26ede$0f37deb0$8b705a3e@checkpoint.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I might be thinking of something totally different than what you're
talking about, but here it goes:

Change line 18 of mmzone.h from:
	#define MAX_ORDER 10
	to
	#define MAX_ORDER 24

This allows larger contiguous chunks of memory to be allocated, up to
32GB.

I'd be very appreciative if you could send me back whatever statistics
you get as a result of this change.  (To be honest, I'm not a good
kernel hacker, and I wanted to gather statistics on this for some time
but don't know how.)

Thanks in advance.

Joseph Wagner

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Ofer Raz
Sent: Tuesday, October 08, 2002 10:19 AM
To: linux-kernel@vger.kernel.org
Subject: FW: 2.4.9/2.4.18 max kernel allocation size



-----Original Message-----
From: Ofer Raz [mailto:oraz@checkpoint.com]
Sent: Tuesday, October 08, 2002 2:19 PM
To: 'linux-kernel-owner@vger.kernel.org'
Subject: 2.4.9/2.4.18 max kernel allocation size


I'm trying to obtain the largest kernel allocation possible using
vmalloc.

I have tested both Linux 2.4.9-7 and 2.4.18-10 max kernel allocation
using
vmalloc on Intel platform with different physical memory configurations.
>From my experience, playing with the Virtual/Physical memory split
issues
different results (which makes sense)

Following are the results on 2.4.9-7 when the 4GB highmem config option
is
set:

Config Option	Physical Memory	Max Allocation
CONFIG_1GB		512MB			400
			1024MB		900
			1536MB		1400
			2048MB		981

CONFIG_2GB		512MB			400
			1024MB		900
			1536MB		461
			2048MB		VFS Panic on boot

CONFIG_3GB		512MB			400
			1024MB		85
			1536MB		VFS Panic on boot
			2048MB		VFS Panic on boot

Please note that CONFIG_3GB is the default and results 85MB max
allocation
for 1GB machine.

For my surprise, I have discovered that the
CONFIG_1GB/CONFIG_2GB/CONFIG_3GB
configuration options were removed from 2.4.18-10, it seems that the
kernel
is set for the CONFIG_3GB option (by looking at the PAGE_OFFSET mask
(0xc0000000)).

Any idea how can I make the kernel allocation on 2.4.18-10 larger than
85MB
on 1GB machine?

Cheers,
	Ofer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

