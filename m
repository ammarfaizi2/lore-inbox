Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWDNXAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWDNXAy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 19:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWDNXAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 19:00:54 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:38109 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751417AbWDNXAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 19:00:54 -0400
Message-ID: <444029A2.3060702@tlinx.org>
Date: Fri, 14 Apr 2006 16:00:50 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andreas Schnaiter <schnaiter@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16 -  SATA read performance drop ~50% on Intel 82801GB/GR/GH
References: <200604120136.28681.schnaiter@gmx.net>
In-Reply-To: <200604120136.28681.schnaiter@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schnaiter wrote:
> The two affected disks are connected to the Intel 82801GB/GR/GH (ICH7 Family)  
> Serial ATA Controller.
> Disks on the Silicon Image/Intel IDE Controllers are not affected.
>
> Linux 2.6.15.7
> ---
> # time dd if=/benchfile of=/dev/null bs=1M
> 8192+0 records in, 8192+0 records out
> 8589934592 bytes (8.6 GB) copied, 130.547 seconds, 65.8 MB/s
> real	2m10.670s user	0m0.023s sys	0m14.238s
>
> Linux 2.6.16.2
> ---
> # time dd if=/benchfile of=/dev/null bs=1M
> 8192+0 records in, 8192+0 records out
> 8589934592 bytes (8.6 GB) copied, 302.452 seconds, 28.4 MB/s
> real	5m3.100s user	0m0.021s sys	0m40.521s
---
    Slightly echoing Jeff G's question, but rephrasing for read,
could you try a read on the actual device?  I.e. without
destroying your partition, you could try a direct read
from the device:

     time dd if=/dev/sda of=/dev/null bs=1M count=8192.

BTW, how much memory do you have on the system?

    Not that I have know much about block-i/o, but it
might narrow things down.

    Have you tried the tests in single-user or run-level 1 to
help rule out other noise?

Linda



