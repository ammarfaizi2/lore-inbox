Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTKPXmh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 18:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbTKPXmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 18:42:37 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:51619 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263205AbTKPXmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 18:42:36 -0500
From: Andrew Miklas <public@mikl.as>
Reply-To: public@mikl.as
To: linux-kernel@vger.kernel.org
Subject: Userspace DMA
Date: Sun, 16 Nov 2003 18:42:00 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311161842.00253.public@mikl.as>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Is there an accepted way of doing userspace DMA with Linux?

I've gone over a large number of posts, and all seem to recommend something 
different, and each method seems to involve certain drawbacks.

What I'd like to do is allow a process to be able to do operations like 
pci_alloc_consistent and pci_free_consistent.  I'm trying to do this to allow 
a driver running under the Bochs emulator to interact with its (non-emulated) 
hardware using DMA.  

I was originally going to do a pci_alloc_consistent and then mmap the space 
into the emulator's process.  The process would then get the physical address 
of the memory through an ioctl, or I would leave the physical address at the 
start of the allocated buffer for the process to later retrieve.

However, it appears that remap_page_range won't work with addresses obtained 
from pci_alloc_consistent.  I've also read that using the nopage callback can 
cause issues if the range I need to allocate is greater than one page.

Most of the approaches I've found seem to require that the hardware be capable 
of scatter-gather DMA (video4linux and bttv, for ex.).  I've also seen one 
solution that had the driver do a pci_alloc_consistent on a certain ioctl, 
and then return the physical address of the buffer.  The process would then 
mmap /dev/mem to access the buffer.  However, someone warned that this method 
could have coherency issues.

Is there some other method that I should be looking at to accomplish this?



Thanks,


Andrew
