Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUJRXCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUJRXCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 19:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267739AbUJRW6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:58:07 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:20392 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267679AbUJRW53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:57:29 -0400
Message-ID: <41744A50.3030700@nortelnetworks.com>
Date: Mon, 18 Oct 2004 16:57:20 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: question on memory map cleanup stuff
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a small feature that maps a page of kernel memory to userspace via a 
syscall, then uses that page for various things.

Currently, I'm marking the page reserved, then exporting it via 
remap_page_range().  This means that I need to clean up my mapping whenever the 
memory map is destroyed (process death, exec(), daemonize, etc.).

It appears that I should be able to put my cleanup code in exit_mmap().  Since 
the cleanup code calls do_munmap() on the address, I would want to call it 
before taking mm->page_table_lock, correct?

Also, normally I would hold mm->mmap_sem before calling do_munmap().  Would I 
still need this if I'm calling it from exit_mmap()?  Presumably nobody else can 
get at it anymore...

Thanks,

Chris
