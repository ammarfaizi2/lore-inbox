Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262366AbSJVJio>; Tue, 22 Oct 2002 05:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbSJVJio>; Tue, 22 Oct 2002 05:38:44 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:49079 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262366AbSJVJin>; Tue, 22 Oct 2002 05:38:43 -0400
Subject: Re: NatSemi Geode improvement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hiroshi Miura <miura@da-cha.org>
Cc: davej@suse.de, hpa@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021022001248.3F70A117B00@triton2>
References: <20021017171217.4749211782A@triton2>
	<1035209178.27318.118.camel@irongate.swansea.linux.org.uk> 
	<20021022001248.3F70A117B00@triton2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 11:00:51 +0100
Message-Id: <1035280851.31917.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 01:12, Hiroshi Miura wrote:
> It means that mmio must map to over 1GB area or disable this feature.

You need to think about bus mastering devices as well. With re-ordering
enabled you may confuse bus master hardware by writing fields in the
wrong order (as the PCI device sees it).

This is not a big problem. On the winchip we avoid this by using locked
operations at the end of each of the PCI DMA mapping functions.  I think
all that is needed is to also define CONFIG_X86_OOSTORE for a Geode
target. The kernel will then generate

		lock; addl $0, 0(%%esp)

to force write ordering where it might be essential, and if OOSTORE is
defined we can safely turn on the speed up.






