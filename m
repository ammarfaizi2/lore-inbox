Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268488AbUHQWjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268488AbUHQWjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268489AbUHQWjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:39:37 -0400
Received: from pop.gmx.net ([213.165.64.20]:20690 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268488AbUHQWjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:39:33 -0400
X-Authenticated: #5874409
Message-ID: <41228946.5040207@gmx.net>
Date: Wed, 18 Aug 2004 00:40:06 +0200
From: Jens Maurer <Jens.Maurer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: arjanv@redhat.com
Subject: Re: [PATCH] Use x86 SSE instructions for clear_page, copy_page
References: <4121A211.8080902@gmx.net> <1092727670.2792.4.camel@laptop.fenrus.com>
In-Reply-To: <1092727670.2792.4.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arjan van de Ven wrote:
> On Tue, 2004-08-17 at 08:13, Jens Maurer wrote:
> 
>>The attached patch (against kernel 2.6.8.1) enables using SSE
>>instructions for copy_page and clear_page.

> we used to have code like this in 2.4 but it got removed: the non
> temperal store code is faster in a microbenchmark but has the
> fundamental problem that it evics the data from the cpu cache; the
> actual USE of the data thus is a LOT more expensive, result is that the
> overall system performance goes down ;(

Hm... With the current clear_page, we are filling 4KB of my
Pentium-III's 16 KB L1 d-cache (i.e. 25%) with zeroes.  I'm not
sure that we will use all of this data right away.

I would like to point out that the current arch/i386/lib/mmx.c
uses MMX movntq instructions #ifdef CONFIG_MK7 .
Apparently, bypassing the cache was considered a good idea
in that case.

What is a set of useful benchmarks to find out which approach
is better?  We should have some real-world programs that show
significant oprofile hits in clear_page or copy_page.
It might very well be that the results on Pentium-III and
Pentium-4 are different, for example that SSE is only useful
for a Pentium-III, and only for clear_page.

Jens Maurer

