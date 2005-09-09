Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVIIJaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVIIJaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbVIIJaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:30:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45027 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030199AbVIIJaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:30:06 -0400
Date: Fri, 9 Sep 2005 02:29:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: michal.k.k.piotrowski@gmail.com
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: 2.6.13-mm2 high memory support borken?
Message-Id: <20050909022932.07a0fa12.akpm@osdl.org>
In-Reply-To: <6bffcb0e05090808113d66061f@mail.gmail.com>
References: <20050908053042.6e05882f.akpm@osdl.org>
	<6bffcb0e05090808113d66061f@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> On 08/09/05, Andrew Morton <akpm@osdl.org> wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> 
>  michal@ng02:~$ cat /proc/meminfo
>  MemTotal:       893824 kB
>  [---cut---]
>  VmallocChunk:   110380 kB
> 
>  something is wrong, I have got 1 gb ram on my box.

Me too.  It's some bug in memory-hotplug-i386-addition-functions.patch.


btw, Dave, if you see something like this:

--- devel/arch/i386/mm/discontig.c
+++ devel-akpm/arch/i386/mm/discontig.c
@@ -98,7 +98,7 @@ unsigned long node_memmap_size_bytes(int
 
 extern unsigned long find_max_low_pfn(void);
 extern void find_max_pfn(void);
-extern void one_highpage_init(struct page *, int, int);
+extern void add_one_highpage_init(struct page *, int, int);

Please take the opportunity to dtrt and move the thing into a header file
rather than letting such dreck continue to live, thanks.

And please don't send bugs either.
