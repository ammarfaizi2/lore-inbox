Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUANSLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUANSLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:11:47 -0500
Received: from relaycz.systinet.com ([62.168.12.68]:33983 "HELO
	relaycz.systinet.com") by vger.kernel.org with SMTP id S262052AbUANSLp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:11:45 -0500
Subject: [2.6,2.4] HPT366 (on Abit BP6) + Seagate 7000.7 + DMA = kernel
	halted
From: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1074103900.22670.27.camel@narsil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 14 Jan 2004 19:11:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have problem with HPT366 and Seagate and trying to switch on DMA.

My configuration
 - my hardware: Abit BP6 with HPT366 IDE controller, Seagate Barracuda
7000.7 HDD (80 GB)
 - kernels tried: 2.4.22, 2.4.23, 2.6.0-test9, 2.6.0, 2.6.1-rc3

My problem is that HPT366 linux driver doesn't like DMA. When I try to
set DMA by hdparm, after several seconds the HDD led gets on and remains
on for another amount of seconds, then I got

hde: dma_timer_expiry (.. = 0x21)

and after a while

hde: DMA timeout error

then kernel is halted and I need to reset my PC.

This error is clearly reproducible (with or without SMP, various kernel
versions, overclocking or not, ACPI on and off) but I don't get any oops
(probably because of disk problem).

DMA can't be set during kernel boot, HPT366 driver refuses to set DMA
on. It must be done using hdparm.

After some investigations I realized that the problem could be in the
combination of HPT366 and Seagate disk. In the source code of
HighPoint's driver
(http://www.highpoint-tech.com/hpt3xx-opensource-v131.tgz - link is in
kernel's drivers/ide/pci/hpt366.c) I can see some procedure used to fix
some seagate disk initialization problem which is not present (after a
quick look) in hpt366.c in kernel. I think that's the problem because I
haven't found any reported problem and I think that BP6 is still widely
used.

Windows are working well and I haven't time to try HighPoint's own
driver.

I can provide you with my exact configuration and logs later, I'm not
near affected computer now.

Does anyone else has the same problem?
Any other ideas?

Regards,

Jan "Pogo" Mynarik

-- 
Jan Mynarik <mynarikj@phoenix.inf.upol.cz>

