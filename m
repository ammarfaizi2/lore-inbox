Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVCSDZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVCSDZh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 22:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVCSDZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 22:25:37 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:40199 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S261603AbVCSDZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 22:25:29 -0500
Message-ID: <423B86C6.7030107@lougher.demon.co.uk>
Date: Sat, 19 Mar 2005 01:56:22 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Kmap_atomic vs Kmap
References: <4235BAC0.6020001@lougher.demon.co.uk> <20050314165117.1c5068b7.akpm@osdl.org>
In-Reply-To: <20050314165117.1c5068b7.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote in relation to my initial SquashFS patch:
> Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
> 
>>+skip_read:
>>+	memset(pageaddr + bytes, 0, PAGE_CACHE_SIZE - bytes);
>>+	kunmap(page);
>>+	flush_dcache_page(page);
>>+	SetPageUptodate(page);
>>+	unlock_page(page);
>>+
>>+	return 0;
>>+}

> See if you can use kmap_atomic() here - kmap() is slow, theoretically
> deadlocky and is deprecated.
> 

 From some browsing of the kernel source and a useful article on lwn.net 
I think I can replace all the readpage_xxx (symlink, readpage & 
readpage4k) kmap/kunmaps with kmap_atomic(page, KM_USER0)/kunmap(kaddr, 
KM_USER0)...

The lwn.net article mentions that k[un]map_atomic is the new alternative 
to kmap (as Andrew Morton mentioned).

I've noticed in asm-ppc/highmem.h the following comment

/*
  * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
  * gives a more generic (and caching) interface. But kmap_atomic can
  * be used in IRQ contexts, so in some (very limited) cases we need
  * it.
  */

Given what Andrew and the lwn.net article says, this comment is rather 
confusing.  Is it wrong?

Regards

Phillip Lougher
