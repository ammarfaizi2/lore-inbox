Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312155AbSCTKMV>; Wed, 20 Mar 2002 05:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312157AbSCTKML>; Wed, 20 Mar 2002 05:12:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44551 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312155AbSCTKL4>; Wed, 20 Mar 2002 05:11:56 -0500
Subject: Re: using kmalloc
To: dmaas@dcine.com (Dan Maas)
Date: Wed, 20 Mar 2002 10:27:09 +0000 (GMT)
Cc: cvaka_kernel@yahoo.com (chiranjeevi vaka), linux-kernel@vger.kernel.org
In-Reply-To: <010101c1cfd3$8a87cfd0$1a02a8c0@allyourbase> from "Dan Maas" at Mar 20, 2002 12:53:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ndJF-0001oQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To allocate more memory, use vmalloc(), which allocates and maps physically
> disjoint pages into a virtually-contiguous region. Be careful when doing DMA
> to a vmalloc() area, since it is not physically contiguous and exists only
> in the kernel's virtual memory map... Also I believe vmalloc()ed memory is
> only accessible from (the context of) the process in which it was allocated
> (?).

vmalloc memory is accessible everywhere. You can't allocate it during 
interrupts or tasklets, and you will get deadlocks if you allocate it in the
write out path of a file system/disk driver.

Alan
