Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVA1SnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVA1SnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVA1Sm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:42:28 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:25823 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S262701AbVA1Siw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:38:52 -0500
Message-ID: <41FA8A3F.CC19F9EE@gte.net>
Date: Fri, 28 Jan 2005 10:53:51 -0800
From: Bukie Mabayoje <bukiemab@gte.net>
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Gernoth <simigern@stud.uni-erlangen.de>
CC: linux-kernel@vger.kernel.org,
       Matthias Koerber <simakoer@stud.informatik.uni-erlangen.de>
Subject: Re: 2.4.29, e100 and a WOL packet causes keventd going mad
References: <20050128164811.GA8022@cip.informatik.uni-erlangen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [66.199.68.159] at Fri, 28 Jan 2005 12:38:47 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Michael Gernoth wrote:

> Hi,
>
> we have about 70 P4 uniprocessor machines (some with Hyperthreading
> capable CPUs) running linux 2.4.29, which are woken up on the weekdays
> by sending a WOL packet to them. The machines all have a E100 nic with
> WOL enabled in the bios. The E100 driver is compiled into the kernel
> and not loaded as a module.
>
> If the machine which should be woken up is already running (because
> someone switched it on by hand), the WOL packet causes keventd to go
> mad and "use" 100% CPU:
>
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>     2 root      15   0     0    0    0 R 99.9  0.0 140:50.94 keventd
>
> This can be reproduced on any of the 70 machines by simply sending a WOL
> packet to it, when it's already running... No entry is made in the
> kernel log.
>
> The dmesg of an affected machine can be found at:
> http://wwwcip.informatik.uni-erlangen.de/~simigern/cip-dmesg
> Our kernel-config is at:
> http://wwwcip.informatik.uni-erlangen.de/~simigern/cip-generic-config
> lspci -vvv is at:
> http://wwwcip.informatik.uni-erlangen.de/~simigern/cip-lspci
>
> We are using a kernel.org linux 2.4.29 kernel patched with the current
> autofs patch and ACL support.
>
> Regards,
>   Michael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Do you know the official NIC product name e.g Pro/100B. I need to identify the LAN Controller. There are differences between  557 (not sure if 557 can do WOL), 558 and 559 how they ASSERT the PME# signal. Even the same chip have differences between steppings.

I suspect that PME# is not being  DEASSERT after the Wake-up packet is received
