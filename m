Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264846AbTGCQsA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTGCQsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:48:00 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:29408 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264846AbTGCQr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:47:59 -0400
Message-ID: <3F046197.40600@colorfullife.com>
Date: Thu, 03 Jul 2003 19:02:15 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: Again: Fix multithread coredump deadlock (patch Manfred Spraul)
References: <200307031238.10570.dev@sw.ru>
In-Reply-To: <200307031238.10570.dev@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

>Hi!
>
>There was a patch some time ago included in linux-2.4.17-pre6 which fixed mmap 
>semaphore deadlock in do_coredump (double down_read() on mmap_sem).
>This fix introduces down_write() on mmap_sem and uses get_user_pages() 
>function to avoid do_page_fault().
>The question is why down_write() is used in elf_core_dump() (instead of 
>down_read())?
>  
>
down_write is required to prevent expand_stack() from growing the stack 
- expand_stack is called by the page fault handler under 
down_read(&->mmap_sem) and changes vma->vm_start. A change of vm_start 
between writing the program headers and the actual segment dump would 
corrupt the coredump.

--
    Manfred

