Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbUCBJqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 04:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUCBJqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 04:46:18 -0500
Received: from tranchant.plus.com ([81.174.183.177]:11205 "EHLO
	tranchant.plus.com") by vger.kernel.org with ESMTP id S261578AbUCBJqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 04:46:17 -0500
Message-ID: <404457E5.10300@tranchant.plus.com>
Date: Tue, 02 Mar 2004 09:46:13 +0000
From: Mark Tranchant <mark@tranchant.plus.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Writing to PCI registers before probe?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an old Pentium 100 machine running 2.6.3, with onboard PIIXa 
controller. I'm trying to enable DMA, but the controller doesn't even 
recognize its own IDE interface. Here's the snipped output from lspci:

root@mauve:~# lspci
00:00.0 Host bridge: Intel Corp. 430FX - 82437FX TSC [Triton I] (rev 02)
00:07.0 ISA bridge: Intel Corp. 82371FB PIIX ISA [Triton I] (rev 02)
(other devices)

If I use setpci to write to an appropriate register, the device then 
recognizes its IDE interface if I tell lspci to do a direct access scan:

root@mauve:~# setpci -s 00:07.0 6a.w=0005
root@mauve:~# lspci -H 1
00:00.0 Host bridge: Intel Corp. 430FX - 82437FX TSC [Triton I] (rev 02)
00:07.0 ISA bridge: Intel Corp. 82371FB PIIX ISA [Triton I] (rev 02)
00:07.1 IDE interface: Intel Corp. 82371FB PIIX IDE [Triton I] (rev 02)
(other devices)

However, the bus has already been scanned, so a straight lspci gives the 
same results as before, and hdparm still can't turn on DMA. Compiling PIIX 
support as a module and insmoding after the setpci makes no difference.

I want to do the register write prior to the bus being scanned. I've seen 
solutions with older kernels, but the bus scan has been significantly 
re-written since then. Would anyone familiar with the 2.6 PCI subsystem 
kindly help me out here? This is a production server, so I don't want too 
much downtime experimenting.

Many thanks,

-- 
Mark.
mark@tranchant.plus.com
http://tranchant.plus.com/


