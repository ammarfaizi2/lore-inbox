Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWISXdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWISXdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 19:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWISXdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 19:33:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43485 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750750AbWISXds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 19:33:48 -0400
Date: Tue, 19 Sep 2006 16:33:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dalibor Straka <dast@panelnet.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Possible bug in ACPI
Message-Id: <20060919163330.b26a8ff3.akpm@osdl.org>
In-Reply-To: <20060919214724.GB2073@panelnet.cz>
References: <20060919214724.GB2073@panelnet.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cc added.

On Tue, 19 Sep 2006 23:47:24 +0200
Dalibor Straka <dast@panelnet.cz> wrote:

> Hello,
> 
> I am often running out of memory. It looks like an ACPI code is guilty:
> dast@lili:~$ grep -i acpi /proc/slabinfo 
> Acpi-Operand        3076   3127     64   59    1 : tunables  120   60 8 : slabdata     53     53      0
> Acpi-ParseExt         16     59     64   59    1 : tunables  120   60 8 : slabdata      1      1      0
> Acpi-Parse            76     92     40   92    1 : tunables  120   60 8 : slabdata      1      1      0
> Acpi-State        1644960 1644960     80   48    1 : tunables  120   60 8 : slabdata  34270  34270      0
> Acpi-Namespace      1177   1232     32  112    1 : tunables  120   60 8 : slabdata     11     11      0
> dast@lili:~$ free
> Mem:        899280     892472       6808          0      82212 77936
> -/+ buffers/cache:     732324     166956
> Swap:      2634620     243052    2404568
> dast@lili:~$ uname -a
> Linux lili 2.6.18-rc7 #1 SMP Sun Sep 17 15:01:00 CEST 2006 x86_64
> 
> 
> Actualy the Acpi-State's memory is increasing slowly in minutes:
> Acpi-State         16176  16176     80   48    1 : tunables  120   60 8 : slabdata    337    337      0
> Acpi-State         18816  18816     80   48    1 : tunables  120   60 8 : slabdata    392    392      0
> Acpi-State         19200  19200     80   48    1 : tunables  120   60 8 : slabdata    400    400      0
> Acpi-State         20160  20160     80   48    1 : tunables  120   60 8 : slabdata    420    420      0

Yes, that is a memory leak.

> I am not familiar with kernel sources, but i can do c pretty well.
> BTW: Bios says i have 1024MB, but kernel sees 899MB :-?. The system is
> pure HP nx6325. It happens with all the recent kernels .18-rc* .17.* and
> debian's distribution 2.6.17-1-amd64-k8-smp.
> 
> Please Cc: to me, I read lkml only when I have a good mood.

