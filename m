Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUBEJl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 04:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUBEJl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 04:41:27 -0500
Received: from motgate8.mot.com ([129.188.136.8]:49316 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S264537AbUBEJl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 04:41:26 -0500
Message-ID: <DD38D67B9196D31189EC00508B625637023FF1CF@zro01exm01.corp.mot.com>
From: Chivu Florin-FLCHIVU1 <Florin.Chivu@motorola.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel buffer not cached in the kernel space
Date: Thu, 5 Feb 2004 11:41:21 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.2)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anybody know how can I allocate a physically contiguous memory buffer
that is not cached in the 2.4.20 kernel address space ? I tried so far to
allocate the buffer with kmalloc (or __get_free_pages() ) and then to use
ioremap_nocache() over alocated pages but it doesn't work for PPC for
example ( a HIGHMEM physical address is required by ioremap_nocache() ).

Also, as in the David M. 's cachetlb.txt document, the flush_dcache_page()
should ensure that the kernel writes to a page that is mapped into a user
virtual address space will be visible right away in user space ( the kenel
buffer is mmaped in user space as _not cached_ ). For PPC it looks like the
cache flush is somehow postponed and kernel writes are not visible to the
user. For ARM it works properly.

-- Florin

