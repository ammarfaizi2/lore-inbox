Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbWIEQTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbWIEQTB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWIEQTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:19:00 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:23443 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S965186AbWIEQS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:18:59 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.18-rc5-mm1 ACPI] Unknown exception code: 0xFFFFFFEA
Date: Tue, 5 Sep 2006 10:18:42 -0600
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
References: <20060901015818.42767813.akpm@osdl.org> <1157274585.6304.6.camel@Homer.simpson.net>
In-Reply-To: <1157274585.6304.6.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609051018.43141.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 September 2006 03:09, Mike Galbraith wrote:
> My single P4/HT box tossed the below on boot.
> 
> ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
>  [<c1004089>] dump_trace+0x1d7/0x206
>  [<c10040d2>] show_trace_log_lvl+0x1a/0x30
>  [<c100484c>] show_trace+0x12/0x14
>  [<c100496d>] dump_stack+0x19/0x1b
>  [<c1229702>] acpi_format_exception+0xa2/0xaf
>  [<c1226824>] acpi_ut_status_exit+0x2b/0x58
>  [<c1222cbc>] acpi_walk_resources+0xfd/0x109
>  [<c12393ca>] acpi_motherboard_add+0x22/0x32
>  [<c123848e>] acpi_bus_driver_init+0x2a/0x7a
>  [<c123892c>] acpi_bus_register_driver+0x8b/0xfb
>  [<c15ebd20>] acpi_motherboard_init+0xd/0xf9
>  [<c10003b1>] init+0x108/0x300
>  [<c1003c93>] kernel_thread_helper+0x7/0x14

This ACPI "unknown exception code" problem is the same one reported here:
  http://www.mail-archive.com/linux-acpi%40vger.kernel.org/msg02873.html

Basically, we just need to revert this:
  http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/hot-add-mem-x86_64-acpi-motherboard-fix.patch

The above patch happened to fix a hot-add memory problem, but it was
the wrong fix, and we're working out a better one.
