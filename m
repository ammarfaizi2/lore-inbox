Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbUJ1QSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUJ1QSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbUJ1QSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:18:20 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:3849 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261722AbUJ1QQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:16:03 -0400
Message-ID: <41811C3B.2020700@kolumbus.fi>
Date: Thu, 28 Oct 2004 19:20:11 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: NUMA node swapping V3
References: <Pine.LNX.4.58.0410280820500.25586@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0410280820500.25586@schroedinger.engr.sgi.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 28.10.2004 19:17:21,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 28.10.2004 19:18:06,
	Serialize complete at 28.10.2004 19:18:06
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	if (pg == orig) {
> 		z->pageset[cpu].numa_hit++;
>+		/*
>+		 * If zone allocation has left less than
>+		 * (sysctl_node_swap / 10) %  of the zone free invoke kswapd.
>+		 * (the page limit is obtained through (pages*limit)/1024 to
>+		 * make the calculation more efficient)
>+		 */
>+		if (z->free_pages < (z->present_pages * sysctl_node_swap) << 10)
>+			wakeup_kswapd(z);
> 	} else {
> 		p->numa_miss++;
> 		zonelist->zones[0]->pageset[cpu].numa_foreign++;
>Index: linux-2.6.9/kernel/sysctl.c
>===================================================================
>  
>

I think you mean >> 10 though.

--Mika


