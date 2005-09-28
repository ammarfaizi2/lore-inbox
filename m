Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVI1JuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVI1JuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVI1JuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:50:12 -0400
Received: from pcsmail.patni.com ([203.124.139.197]:40334 "EHLO
	pcsmail.patni.com") by vger.kernel.org with ESMTP id S1750854AbVI1JuL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:50:11 -0400
Message-ID: <002f01c5c412$194561c0$5e91a8c0@patni.com>
Reply-To: "lk" <linux_kernel@patni.com>
From: "lk" <linux_kernel@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: alloc_page_buffers() - kernel panic?
Date: Wed, 28 Sep 2005 15:20:45 +0530
Organization: Patni
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at the fs(buffer.c) code, An observation:

alloc_page_buffers() is called from the function create_empty_buffers() . If
the memory allocation for the buffer head (through kmem_cache_alloc) fails
the allocation is retried till successful for async I/O. However for
synchronous I/O no such handling is done and create_buffer will return
NULL which is not checked in the calling function. The pointer returned by
NULL
is used without checking for the NULL condition. This would result in a
kernel panic when alloc_page_buffers() is not able to allocate buffer heads
from the cache for sync I/O.


Is anyone aware of the thought process behind this difference in
implementation for sync and async I/O.

regards
lk


