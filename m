Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUCIHMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 02:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbUCIHMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 02:12:08 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:39087 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261516AbUCIHLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 02:11:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: OOPS when copying data from local to an external drive (ieee1394)
Date: Tue, 9 Mar 2004 02:11:33 -0500
User-Agent: KMail/1.6
Cc: Ben Collins <bcollins@debian.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <200403070139.30268.dtor_core@ameritech.net> <Pine.LNX.4.58.0403070229490.29087@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0403070229490.29087@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403090211.33930.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 March 2004 01:50 am, Zwane Mwaikambo wrote:
> On Sun, 7 Mar 2004, Dmitry Torokhov wrote:
> 
> > I started getting oopses when cpying data from local IDE to an external
> > Firewire drive. Not always, but quite often. The kernel is a bk pull a
> > day before 2.6.4-rc2 was released, I do not see any ieee1394 updates
> > since.
> >
> > Unfortunately the oops was not saves in the logs, so here is what I managed
> > to write down:
> 
> > Oops: 00002 [#1]
> > PREEMPT
> > CPU: 0
> > EIP: 0060 [<c0243d087>] Tainted: P
> > EFLAGS: 00010047
> > EIP is at hpsb_packet_sent+0x86/0x90
> > eax: 00100100 ebx: dfd74000 ecx: dd6edfb0 edx: 00200200
> 
> A spot of linked list corruption.
> 
> > esi: 00000001 edi: dd6cdf60 ebp: c03e3ee0 esp: c03c3edc
> > ds: 007b es: 007b ss: 0068
> > Process swapper (pid: 0; threadinfo=c03c2000, task=c034a800)
> > ....
> > Call trace:
> > [<co25306e>] dma_trm_tasklet+0xae/0x1b0
> 
> Does this patch help any?
> 

Unfortunately I am still getting oopses with exactly the same call trace.
On top of that I am now seeing the following in the logs:

Mar  9 01:41:21 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:21 core kernel: Write (10) 00 11 27 de 17 00 00 f8 00
Mar  9 01:41:21 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:21 core kernel: Write (10) 00 11 27 df 0f 00 00 f8 00
Mar  9 01:41:21 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:21 core kernel: Write (10) 00 11 27 e0 07 00 00 f8 00
Mar  9 01:41:21 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:21 core kernel: Write (10) 00 11 27 e0 ff 00 00 f8 00
Mar  9 01:41:21 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:21 core kernel: Write (10) 00 11 27 e1 f7 00 00 f8 00
Mar  9 01:41:21 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:21 core kernel: Write (10) 00 11 27 e3 e7 00 00 f8 00
Mar  9 01:41:21 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:22 core kernel: Write (10) 00 11 27 e4 df 00 00 f8 00
Mar  9 01:41:23 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:23 core kernel: Write (10) 00 11 27 e5 d7 00 00 f8 00
Mar  9 01:41:26 core kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Mar  9 01:41:28 core last message repeated 8 times
Mar  9 01:41:56 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:56 core kernel: Write (10) 00 11 2a f8 ff 00 00 f8 00
Mar  9 01:41:56 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:56 core kernel: Write (10) 00 11 2a f9 f7 00 00 f8 00
Mar  9 01:41:56 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:56 core kernel: Write (10) 00 11 2a fa ef 00 00 f8 00
Mar  9 01:41:56 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:56 core kernel: Write (10) 00 11 2a fb e7 00 00 f8 00
Mar  9 01:41:56 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:56 core kernel: Write (10) 00 11 2a fc df 00 00 f8 00
Mar  9 01:41:56 core kernel: ieee1394: sbp2: aborting sbp2 command
Mar  9 01:41:56 core kernel: Write (10) 00 11 2a fe cf 00 00 f8 00

I did not have these messages before. The kernel was pulled today
from bkbits plus your patch (and some of my patches but they only
affect input drivers).

-- 
Dmitry
