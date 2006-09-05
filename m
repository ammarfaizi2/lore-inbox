Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbWIEQQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbWIEQQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWIEQQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:16:42 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:62173 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S965103AbWIEQQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:16:40 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: 2.6.18-rc5-mm1
Date: Tue, 5 Sep 2006 10:16:39 -0600
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <20060901015818.42767813.akpm@osdl.org> <44F86282.9010809@gmail.com>
In-Reply-To: <44F86282.9010809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609051016.40468.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 September 2006 10:40, Maciej Rutecki wrote:
> ACPI error (similar like in 2.6.18-rc4-mm3):
> 
> [   23.790140] ACPI Error (utglobal-0125): Unknown exception code:
> 0xFFFFFFEA [20060707]
> [   23.790318]  [<c0221ba9>] acpi_format_exception+0x9f/0xa9
> [   23.790445]  [<c021edf9>] acpi_ut_status_exit+0x2e/0x56
> [   23.790554]  [<c021b3ac>] acpi_walk_resources+0x103/0x10d
> [   23.790661]  [<c022901c>] acpi_reserve_io_ranges+0x0/0xfc
> [   23.790774]  [<c022900f>] acpi_motherboard_add+0x1f/0x2c
> [   23.790880]  [<c0228154>] acpi_bus_driver_init+0x2c/0x78
> [   23.790987]  [<c02285b0>] acpi_bus_register_driver+0x60/0xb1
> [   23.791094]  [<c038a8da>] acpi_motherboard_init+0xa/0xf5
> [   23.791205]  [<c01002b0>] init+0x70/0x280
> [   23.791309]  [<c0102db2>] ret_from_fork+0x6/0x14
> [   23.791420]  [<c0100240>] init+0x0/0x280
> [   23.791520]  [<c0100240>] init+0x0/0x280
> [   23.791621]  [<c0103997>] kernel_thread_helper+0x7/0x10

This ACPI "unknown exception code" problem is the same one reported here:
  http://www.mail-archive.com/linux-acpi%40vger.kernel.org/msg02873.html

Basically, we just need to revert this:
  http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/hot-add-mem-x86_64-acpi-motherboard-fix.patch

The above patch happened to fix a hot-add memory problem, but it was
the wrong fix, and we're working out a better one.
