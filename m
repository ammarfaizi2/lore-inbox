Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUE1GSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUE1GSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 02:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265822AbUE1GSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 02:18:11 -0400
Received: from welcomes-you.com ([81.169.152.204]:18654 "EHLO welcomes-you.com")
	by vger.kernel.org with ESMTP id S262339AbUE1GSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 02:18:05 -0400
Message-ID: <40B6D991.4020009@welcomes-you.com>
Date: Fri, 28 May 2004 08:17:53 +0200
From: Carsten Aulbert <carsten@welcomes-you.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040321)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI S3 fails to re-init NIC on Asus A7V
References: <40B6480D.60905@welcomes-you.com> <20040527201541.GA601@devserv.devel.redhat.com>
In-Reply-To: <20040527201541.GA601@devserv.devel.redhat.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-welcomes-you.com-MailScanner: Found to be clean
X-welcomes-you.com-MailScanner-SpamCheck: not spam,
	SpamAssassin (Wertung=3.271, benoetigt 5, RCVD_IN_DYNABLOCK 2.55,
	RCVD_IN_NJABL 0.10, RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
X-welcomes-you.com-MailScanner-SpamScore: sss
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Arjan van de Ven wrote:

> 
> please try this patch:

[...]

Thanks a lot for the patch, applied it to vanilla 2.6.6, but that did 
not help (at all :( ).

in both cases (with and without unloading the sis900 module before 
suspending) I get:

/var/log/syslog
[...]
May 28 07:54:03 daisy kernel: PM: Preparing system for suspend
May 28 07:54:03 daisy kernel: Stopping tasks: 
==========================================|
May 28 07:54:03 daisy kernel: PM: Entering state.
May 28 07:54:03 daisy kernel:  hwsleep-0304 [12] acpi_enter_sleep_state: 
Entering sleep state [S3]
May 28 07:54:03 daisy kernel: Back to C!
May 28 07:54:03 daisy kernel: spurious 8259A interrupt: IRQ7.
May 28 07:54:03 daisy kernel: PM: Finishing up.
May 28 07:54:03 daisy kernel: blk: queue d7de0c00, I/O limit 4095Mb 
(mask 0xffffffff)
May 28 07:54:03 daisy kernel: blk: queue d7de0400, I/O limit 4095Mb 
(mask 0xffffffff)
May 28 07:54:03 daisy sleepd[584]: 34 sec sleep; resetting timer
May 28 07:54:03 daisy kernel: Restarting tasks... done
May 28 07:54:04 daisy kernel: MCE: The hardware reports a non fatal, 
correctable incident occurred on CPU
0.
May 28 07:54:04 daisy kernel: Bank 1: ddd1ffdd22063591
May 28 07:54:04 daisy kernel: MCE: The hardware reports a non fatal, 
correctable incident occurred on CPU
0.
May 28 07:54:04 daisy kernel: Bank 2: a00060000002042e

[ modprobe sis900 debug=4 ]

May 28 07:54:26 daisy kernel: sis900.c: v1.08.07 11/02/2003
May 28 07:54:26 daisy kernel: eth0: SiS 900 Internal MII PHY transceiver 
found at address 1.
May 28 07:54:26 daisy kernel: eth0: Using transceiver found at address 1 
as default
May 28 07:54:28 daisy kernel: eth0: SiS 900 PCI Fast Ethernet at 0xa400, 
IRQ 11, 00:30:ab:01:7b:6e.
May 28 07:54:34 daisy kernel: eth0: Receive Filter Addrss[0]=3000
May 28 07:54:34 daisy kernel: eth0: Receive Filter Addrss[1]=1ab
May 28 07:54:34 daisy kernel: eth0: Receive Filter Addrss[2]=6e7b
May 28 07:54:34 daisy kernel: eth0: TX descriptor register loaded with: 
177d6000
May 28 07:54:34 daisy kernel: eth0: RX descriptor register loaded with: 
177d1000
May 28 07:54:36 daisy kernel: eth0: Media Link On 100mbps full-duplex
May 28 07:54:48 daisy kernel: eth0: Queued Tx packet at d73f0b96 size 42 
to slot 0.
May 28 07:54:54 daisy kernel: NETDEV WATCHDOG: eth0: transmit timed out
May 28 07:54:54 daisy kernel: eth0: exiting interrupt, interrupt status 
= 0x0x00000000.
May 28 07:54:54 daisy kernel: eth0: Transmit timeout, status 00000004 
00000241
May 28 07:54:54 daisy kernel: eth0: Queued Tx packet at d73f0996 size 42 
to slot 0.

[...]

That's all info I can currently squeeze out of the box (due to my 
limited knowledge I suppose), anyone with any idea, how to proceed?


Cheers

Carsten
