Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268411AbUHKXw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268411AbUHKXw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268313AbUHKXpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:45:33 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:18406 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268335AbUHKXa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:30:29 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200408112329.i7BNTP6F163641@fsgi900.americas.sgi.com>
Subject: Re: Altix I/O code reorganization - 7 of 21
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Date: Wed, 11 Aug 2004 18:29:25 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 003-pci-support:
>    The PCI DMA implementation is still ubercomplicated.  See the PCI DMA code
>    I sent you long ago.
>    Of the code in pci_extensions.c only two are actually used in the kernel
>    (snia_pcibr_rrb_alloc and snia_pcidev_endian_set), please remove the unused
>    other ones.
> 

Yes, the PCI DMA mapping code is very robust and tries to export 
the many hardware features that are available on our system.  However, not 
all of these features are "reachable" via the standard Linux PCI mapping 
interfaces.  We have removed all unreacheable features.  However, we can 
still support future requirements with these new interfaces when needed.

Yes, we did look at your patch dated: December 4th 2003.  It was very good, but 
did not go far enough.  We felt that we can trim more of the code.  The current 
result, we believe is much cleaner and easier to support.  The dma path now is 
much leaner.

We have removed unused calls in pci_extensions.c.  We have also removed the
call snia_pcidev_endian_set.  IOC4 endianess is already correctly set by
Prom during configuration and initialization.



For the new code see:
ftp://oss.sgi.com/projects/sn2/sn2-update/003-pci-support

