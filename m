Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbUAKIhV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 03:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbUAKIhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 03:37:21 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:61836 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265801AbUAKIhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 03:37:18 -0500
Message-ID: <40010B36.4010306@colorfullife.com>
Date: Sun, 11 Jan 2004 09:37:10 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john moser <bluefoxicy@linux.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: krealloc()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Moser wrote:

>I'm not sure if I should just call mmap() inside the
>kernel (any security hazzards or whatnot I should be worried about there?), but
>it's going to be a pain to resize arrays.
>
mmap only works for user space memory, not for kernel memory.

>Most realloc() implimentations grow or shrink in place, if possible.  If they can't,
>or if that wasn't how they were coded, they allocate the new block, memcpy() over,
>then free the old block.
>
>  
>
The kmalloc implementation is object based, it cannot grow in place. The 
only approach is call ksize and check if it fits by chance, otherwise 
alloc new block and memcpy, then free.
Why do you need realloc? What do you want to do? Are you aware that 
kmalloc is limited to 128 kB, and that large kmallocs (I'd guess: > 16 
kB) can fail due to memory fragmentation after long uptimes?

--
    Manfred

