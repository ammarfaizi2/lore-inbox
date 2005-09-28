Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVI1TyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVI1TyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 15:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVI1TyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 15:54:03 -0400
Received: from spirit.analogic.com ([204.178.40.4]:18444 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750749AbVI1TyB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 15:54:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050928192934.56067.qmail@web34114.mail.mud.yahoo.com>
References: <20050928192934.56067.qmail@web34114.mail.mud.yahoo.com>
X-OriginalArrivalTime: 28 Sep 2005 19:53:58.0711 (UTC) FILETIME=[5DAACC70:01C5C466]
Content-class: urn:content-classes:message
Subject: Re: Slow loading big kernel module in 2.6 on PPC platform
Date: Wed, 28 Sep 2005 15:53:58 -0400
Message-ID: <Pine.LNX.4.61.0509281548570.18498@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Slow loading big kernel module in 2.6 on PPC platform
Thread-Index: AcXEZl2yvMcwMSeuRYauHf8kus1N0g==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Wilson Li" <yongshenglee@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Sep 2005, Wilson Li wrote:

> Hi,
>
> I am trying to port several third party kernel modules from kernel
> 2.4 to 2.6 on a ppc (MPC824x) platform. For small size of modules, it
> works perfectly in 2.6. But there's one huge kernel module which size
> is about 2.7M bytes (size reported by lsmod after insmod), and it
> takes about 90 seconds to load this module before init_module starts.
> I did not notice there's such obvious delay in 2.4 kernel.
>

I don't think it's a problem with the size. Here is the
`lspci` output after I hacked a Rtc module to use 16 megabytes
of data space. It took about 1/4 second to load (`time insmod Rtc.ko`).

Module                  Size  Used by
Rtc                 16783748  0
floppy                 58964  0
loop                   18440  0
parport_pc             28740  1
lp                     14472  0
parport                37320  2 parport_pc,lp

[SNIPPED...]


> Initially I suspected there might be a problem of the insmod of
> busybox I was using. I switched to module-init-tools-3.1 insmod. It
> didn't help. I also tried other things like disabling CONFIG_KALLSYMS
> and commenting out all the EXPORT_SYMBOLs in that module. Nothing
> works so far. I've not been able to find any relevant thread about
> slow loading of big kernel module on PPC platform.
>

The PPC might be a bit slower, but not as slow as you are
seeing. I suspect that you have something that is 'waiting'
for initialization.

> Is this related to the new way of loading kernel module in 2.6 or
> vmalloc since the kernel module also needs contiguous memory? I am
> running 2.6.8 kernel on a ppc platform (MPC824x) with 24M bytes
> memory visible to kernel. Two small kernel modules are loaded first
> through shell command right after system boots up. And there are
> about 10M bytes free memory left before loading this big chunk. The
> memory seems big enough to me and memory is not that fragmented since
> it just boots up.
>
> Any suggestions?
>
> Thanks a lot,
> Wilson Li

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
