Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423340AbWJaQBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423340AbWJaQBH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423522AbWJaQBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:01:07 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:15792 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1423340AbWJaQBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:01:05 -0500
Message-ID: <4547733B.9040801@gmail.com>
Date: Tue, 31 Oct 2006 17:00:59 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Guillermo Marcus <marcus@ti.uni-mannheim.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: mmaping a kernel buffer to user space
References: <4547150F.8070408@ti.uni-mannheim.de>
In-Reply-To: <4547150F.8070408@ti.uni-mannheim.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillermo Marcus wrote:
> Hi all,
> 
> I recently run with the following situation while developing a PCI
> driver. The driver allocates memory for a PCI device using
> pci_alloc_consistent as this memory is going to be used to perform DMA
> transfers. To pass the data from/to the user application, I mmap the
> buffer into userspace. However, if I try to use remap_pfn_range
> (>=2.6.10) or the older remap_page_range(<=2.6.9) for mmaping, it ends
> up creating a new buffer, because they do not support RAM mapping, then
> pagefaulting to the VMA and by default allocating new pages. Therefore,
> I had to implement the nopage method and mmap one page at a time as they
> fault.
> 
> However, to my point of view, this is unnecessary. The memory is already
> allocated, the memory is locked because it is consistent, and it may be
> a (very small) performance and stability issue to do them one-by-one.
> Why can't I simply mmap it all at once? am I missing some function? More
> important, why can't remap_{pfn/page}_range handle it?

Piece of code please. pci_alloc_consistent calls __get_free_pages, and there
should be no problem with mmaping this area.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
