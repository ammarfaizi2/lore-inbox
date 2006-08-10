Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWHJPGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWHJPGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161322AbWHJPGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:06:18 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:59847 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161040AbWHJPGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:06:17 -0400
Date: Fri, 11 Aug 2006 00:05:32 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: apw@shadowen.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Re : sparsemem usage
Message-Id: <20060811000532.b9fe3b72.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060810144601.97257.qmail@web25812.mail.ukl.yahoo.com>
References: <20060810144601.97257.qmail@web25812.mail.ukl.yahoo.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 14:46:01 +0000 (GMT)
moreau francis <francis_moreau2000@yahoo.fr> wrote:
> 
> Why not implementing page_exist() by simply using mem_map[] ? When
> allocating mem_map[], we can just fill it with a special value. And
> then when registering memory area, we clear this special value with
> the "reserved" value. Hence for flatmem model, we can have:
> 
> #define page_exist(pfn)        (mem_map[pfn] != SPECIAL_VALUE)
>  
putting a special value to a page struct at mem_map + pfn ?

> and it should work for sparsemem too and other models that will use
> mem_map[].
> 
> Another point, is page_exist() going to replace page_valid() ?
what is page_valid() here ? pfn_valid() (in current kernel) ?

> I mean page_exist() is going to be something more accurate than
> page_valid(). All tests on page_valid() _only_ will be fine to test
> page_exist(). But all tests such:
> 
>     if (page_valid(x) && page_is_ram(x))
> 
> can be replaced by
> 
>     if (page_exist(x))
> 
> So, again, why not simply improving page_valid() definition rather
> than introduce a new service ?
> 
I welcome to do that if implementation is sane.
pfn_valid() --- check there is a page struct
page_exist() --- check there is a physical memory.

but discussing without patch is not very good. please post your patch.
Then we can discuss more concrete things.

-Kame

