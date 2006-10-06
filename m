Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWJFNSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWJFNSo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 09:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWJFNSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 09:18:44 -0400
Received: from mail.rtlogic.com ([165.236.216.78]:23589 "EHLO rtlogic.com")
	by vger.kernel.org with ESMTP id S932297AbWJFNSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 09:18:44 -0400
From: "Russell Johnson" <rjohnson@rtlogic.com>
To: <linux-kernel@vger.kernel.org>
Subject: bigphysarea mmap and direct_io
Date: Fri, 6 Oct 2006 07:18:39 -0600
Message-ID: <003101c6e949$f018cf40$f500030a@rtlogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AcbpSe7nkK402dbRQbS0UJ2u+/Exmw==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My driver is allocating memory via bigphysarea and my application mmap's the
area for performance reasons.  With linux kernels 2.6.14 and prior on i386
platforms, I have been able to issue disk reads using direct_io to fill this
bigphysarea memory and prevent multiple copies of the data.  The file system
code for direct I/O disk reads checks for VM_IO and will not allow direct io
in that case.  So to do this I had my driver clear the VM_IO flag after
calling remap_pfn_range.

With kernel 2.6.16 and newer, remap_pfn_range sets a new flag VM_PFNMAP
which direct_io also checks.  If my driver clears VM_PFNMAP then the kernel
will oops upon an munmap call because it will attempt to free the pages.

I'm looking for the proper way to do what I want which is to allow the
application to mmap and do direct io disk access to the bigphysarea memory.
I've unsuccessfully tried writing a nopage handler and I still get an oops
upon munmap.  Can someone point me in the right direction?

Please cc me as I'm not on this list.  Thanks!

rjohnson@rtlogic.com

Russell Johnson
RT Logic! 


