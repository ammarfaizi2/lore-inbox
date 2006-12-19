Return-Path: <linux-kernel-owner+w=401wt.eu-S1752437AbWLSEnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbWLSEnE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 23:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbWLSEnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 23:43:03 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:28034 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752437AbWLSEnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 23:43:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CRAMMD2u78zARGPFwq1ZTojKJUzHhcArrFiLatwjdP4/KKYQqtkIH3Sc1CSMhYQ3BFIzNcf++PfJ2qWawRK0POR0KGcfxAPSeiGS8qiom0TsNuhb/o1iKWgFSDY2LvWDbR/I7M4adBXLgySRlRIcfv4U4HaTDll5rSTECxvEYk4=  ;
X-YMail-OSG: 2MpsOi0VM1m7xmNTGclSJSqloc6ivJ3jOL5AtzGL_x4_vZrKlbx89Q.sgoGIZ0PtS7ViF4.7cA7Esydunll.gqDMaTVp41iXDJaQFKhkTeBdc0cheE8UrNmAQbhgeeK2M5VCoRq3Q6FBL38-
Message-ID: <458760B0.7090803@yahoo.com.au>
Date: Tue, 19 Dec 2006 14:46:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aubrey <aubreylee@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Fix area->nr_free-- went (-1) issue in buddy system
References: <6d6a94c50612181901m1bfd9d1bsc2d9496ab24eb3f8@mail.gmail.com>
In-Reply-To: <6d6a94c50612181901m1bfd9d1bsc2d9496ab24eb3f8@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey wrote:
> Hi all,
> 
> When I setup two zones (NORMAL and DMA) in my system, I got the
> following wired result from /proc/buddyinfo.
> ----------------------------------------------------------------------------------------- 
> 
> root:~> cat /proc/buddyinfo
> Node 0, zone      DMA      2      1      2      1      1      0      0
>     1      1      2      2      0      0      0
> Node 0, zone   Normal      1      1      1      1      1      1      0
>     0 4294967295      0 4294967295      2      0      0
> ----------------------------------------------------------------------------------------- 
> 
> 
> As you see, two area->nr_free went -1.
> 
> After dig into the code, I found the problem is in the fun
> __free_one_page() when the kernel boot up call free_all_bootmem(). If
> two zones setup, it's possible NORMAL zone merged a block whose order
> =8 at the first time(this time zone[NORMA]->free_area[8].nr_free = 0)
> and found its buddy in the DMA zone. So the two blocks will be merged
> and area->nr_free went to -1.

This should not happen because the pages are checked to ensure they are
from the same zone before merging.

What kind of system do you have? What is the dmesg and the .config? It
could be that the zones are not properly aligned and CONFIG_HOLES_IN_ZONE
is not set.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
