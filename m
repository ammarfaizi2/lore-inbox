Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422709AbWA1ATa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbWA1ATa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbWA1ATa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:19:30 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:19906 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422709AbWA1ATa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:19:30 -0500
Subject: [patch 0/6] Create and Use common mempool allocators
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 27 Jan 2006 16:19:25 -0800
Message-Id: <1138407565.26088.0.camel@localhost.localdomain>
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
where possible.

After the application of these patches there are only 4 places where
'non-common' allocators are used (drivers/md/raid1.c & raid10.c, mm/highmem.c
and drivers/scsi/scsi_transport_iscsi.c), and all of these are non-trivial
allocators.  The sum of these patches is a reduction of 60 lines of kernel
code and the removal of many nearly identical mempool allocators.

These patches are against 2.6.16-rc1-mm3.

Thanks!

-Matt

