Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129531AbRCHUBS>; Thu, 8 Mar 2001 15:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129567AbRCHUBA>; Thu, 8 Mar 2001 15:01:00 -0500
Received: from colorfullife.com ([216.156.138.34]:20237 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129531AbRCHUAq>;
	Thu, 8 Mar 2001 15:00:46 -0500
Message-ID: <3AA7E4E8.5EACF817@colorfullife.com>
Date: Thu, 08 Mar 2001 21:00:40 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: flush_page_to_ram() question in kernel/ptrace.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From linux/kernel/ptrace.c, access_one_page():

>        flush_cache_page(vma, addr);
> 
>         if (write) {
>                 maddr = kmap(page);
>                 memcpy(maddr + (addr & ~PAGE_MASK), buf, len);
>                 flush_page_to_ram(page);
>                 flush_icache_page(vma, page);
>                 kunmap(page);
>         } else {
>                 maddr = kmap(page);
>                 memcpy(buf, maddr + (addr & ~PAGE_MASK), len);
>                 flush_page_to_ram(page);
                  ^^^^^^^^^^^^^^^^^^^^^^
>                 kunmap(page);
>         }

Is this flush required?

The memcpy read from the mapping, it didn't write.

--
	Manfred
