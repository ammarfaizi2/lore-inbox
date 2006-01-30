Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWA3VXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWA3VXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWA3VXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:23:32 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:6091 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965002AbWA3VXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:23:31 -0500
Subject: [patch 0/8] Create and Use common mempool allocators (Take 2)
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 30 Jan 2006 13:23:28 -0800
Message-Id: <1138656208.20704.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
In the course of working on some patches to implement subsystem-wide critical
pools through the existing mempool API, I created the following patches which
create 3 new common mempool allocators (mempool_alloc_pages, mempool_kmalloc &
mempool_kzalloc) and freers.  The following 6 patches add these new common
allocators and convert existing mempool users to use these common allocators,
where possible.  Optionally, the last 2 patches in this series add and use a
wrapper for the common case of creating a slab-based mempool.

After the application of these patches there are only 4 places where
'non-common' allocators are used (drivers/md/raid1.c & raid10.c, mm/highmem.c
and drivers/scsi/scsi_transport_iscsi.c), and all of these are non-trivial
allocators.  The sum of these patches is a reduction of 90 lines of kernel
code and the removal of many nearly identical mempool allocators.

New since Take 1:
* Added 4 mempool_create() wrappers to avoid both gratuitous casting
   and gratuitous cast warnings.
* Update to 2.6.16-rc1-mm4

Thanks!

-Matt

