Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161423AbWHJQue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161423AbWHJQue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161454AbWHJQue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:50:34 -0400
Received: from mx.pathscale.com ([64.160.42.68]:28637 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161423AbWHJQud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:50:33 -0400
Message-ID: <52827.71.131.40.63.1155228632.squirrel@rocky.pathscale.com>
Date: Thu, 10 Aug 2006 09:50:32 -0700 (PDT)
Subject: How to revoke mmap mappings
From: ralphc@pathscale.com
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking for suggestions on how a device driver which implements
mmap() similar to the "scullv" example driver can revoke the
mapping.  I would like the driver to be able to invalidate
all of the pages faulted in through struct vm_operations_struct.nopage
so that the vmalloc() memory can be freed.  If the user process
tries to touch the mmap region afterwards, it will get a SIGBUS
or SIGSEGV.

I looked in mm/memory.c but unmap_mapping_range() and
vmtruncate() require file mappings so I don't think I
can use these.

