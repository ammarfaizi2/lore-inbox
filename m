Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbRAYRFa>; Thu, 25 Jan 2001 12:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRAYRFU>; Thu, 25 Jan 2001 12:05:20 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:13896 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S129311AbRAYRFD>;
	Thu, 25 Jan 2001 12:05:03 -0500
Message-ID: <3A705CAF.70909@valinux.com>
Date: Thu, 25 Jan 2001 10:04:47 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Timur Tabi <ttabi@interactivesi.com>
CC: Roman Zippel <roman@augan.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: ioremap_nocache problem?
In-Reply-To: <3A6D5D28.C132D416@sangate.com> <20010123165117Z131182-221+34@kanga.kvack.org> 
		<20010123165117Z131182-221+34@kanga.kvack.org> ; from ttabi@interactivesi.com on Tue, Jan 23, 2001 at 10:53:51AM -0600 <20010125155345Z131181-221+38@kanga.kvack.org> <20010125165001Z132264-460+11@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:

> ** Reply to message from Roman Zippel <roman@augan.com> on Thu, 25 Jan 2001
> 17:44:51 +0100
> 
> 
> 
>> set_bit(PG_reserved, &page->flags);
>> 	ioremap();
>> 	...
>> 	iounmap();
>> 	clear_bit(PG_reserved, &page->flags);
> 
> 
> The problem with this is that between the ioremap and iounmap, the page is
> reserved.  What happens if that page belongs to some disk buffer or user
> process, and some other process tries to free it.  Won't that cause a problem?

	The page can't belong to some other process/kernel component.  You own 
the page if you allocated it.  The kernel will only muck with memory you 
allocated if its GFP_HIGHMEM, or under certain circumstances if you map 
it into a user process (There are several rules here and I won't go into 
them, look at the DRM mmap setup for a start if your interested.)  This 
is the correct ordering of the calls (I was the one who added support to 
the kernel to ioremap real ram, trust me.)

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
