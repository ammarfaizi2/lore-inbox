Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUBYXj3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUBYXjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:39:24 -0500
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:60455 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S261669AbUBYXhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:37:18 -0500
Message-ID: <403D31A8.4080204@raytheon.com>
Date: Wed, 25 Feb 2004 15:37:12 -0800
From: Ross Tyler <retyler@raytheon.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how does one disable processor cache on memory allocated with get_free_pages?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am writing a kernel module that is allocating memory using get_free_pages.
It is important that access to/from these pages not use the processor 
(Pentium 4) cache.
How can I do this?

I have looked at drivers/char/mem.c which uses a pgprot_noncached 
function to modify the vm_page_prot attribute of a vma during a mmap call.
If I understand this correctly, this would make sure that all access to 
the pages that are done through the mapping will not be cached.

This will not work for me, however, because I need to access this memory 
from the device driver independent of any user code that might mmap it.
I thought of the device driver open'ing and mmap'ing itself but it 
doesn't have a special file in the file system (I am not using DEVFS) 
and this seems kludgy.

I am hoping that there is a way to simply modify the page table entries 
for the allocated pages.
Is there?
If so, what is the mechanism for modifying the entries and synchronizing 
the configuration with the processor cache?

Please CC any response directly to me (retyler@raytheon.com).

Thanks!

