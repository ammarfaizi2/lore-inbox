Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290839AbSBSJRi>; Tue, 19 Feb 2002 04:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290843AbSBSJR2>; Tue, 19 Feb 2002 04:17:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35340 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290839AbSBSJRS>; Tue, 19 Feb 2002 04:17:18 -0500
Subject: Re: readl/writel and memory barriers
To: dmaas@dcine.com (Dan Maas)
Date: Tue, 19 Feb 2002 09:31:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        bcollins@debian.org (Ben Collins)
In-Reply-To: <092401c1b8e7$1d190660$1a01a8c0@allyourbase> from "Dan Maas" at Feb 18, 2002 08:45:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16d6cW-0008OH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In a quick survey of architectures that need explicit memory barriers to
> enforce ordering of PCI accesses, it seems that alpha and PPC include memory
> barriers inside readl() and writel(), whereas MIPS, sparc64, ia64, and s390

Alpha and PPC include them, x86 its handled by the hardware. __raw_read/write*
are bit more exciting.

> do not include them. (I'm not intimately familiar with these architectures
> so forgive me if I got some wrong...). What is the official story here?

To quote from the Documentation dir..

      <para>
        The read and write functions are defined to be ordered. That is the
        compiler is not permitted to reorder the I/O sequence. When the
        ordering can be compiler optimised, you can use <function>
        __readb</function> and friends to indicate the relaxed ordering. Use
        this with care. The <function>rmb</function> provides a read memory
        barrier. The <function>wmb</function> provides a write memory barrier.
      </para>

      <para>
        While the basic functions are defined to be synchronous with respect
        to each other and ordered with respect to each other the busses the
        devices sit on may themselves have asynchronocity. In paticular many
        authors are burned by the fact that PCI bus writes are posted
        asynchronously. A driver author must issue a read from the same
        device to ensure that writes have occurred in the specific cases the
        author cares. This kind of property cannot be hidden from driver
        writers in the API.
      </para>

