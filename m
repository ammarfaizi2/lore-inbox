Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312608AbSDKRVH>; Thu, 11 Apr 2002 13:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312612AbSDKRVG>; Thu, 11 Apr 2002 13:21:06 -0400
Received: from air-2.osdl.org ([65.201.151.6]:1032 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S312608AbSDKRVF>;
	Thu, 11 Apr 2002 13:21:05 -0400
Date: Thu, 11 Apr 2002 10:18:01 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch-2.5.8-pre] swapinfo accounting
In-Reply-To: <Pine.LNX.4.21.0204111543340.1231-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L2.0204111012120.28475-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002, Hugh Dickins wrote:

| On Wed, 10 Apr 2002, Andrew Morton wrote:
| > "Randy.Dunlap" wrote:
| > >
| > > It looks to me like mm/swapfile.c::si_swapinfo()
| > > shouldn't be adding nr_to_be_unused to total_swap_pages
| > > or nr_swap_pages for return in val->freeswap and
| > > val->totalswap.
|
| Good observation, thanks Randy, but wrong fix.

Thanks for the patch.  I confirm that it is giving me
numbers that look sane.

BTW, the patch was for discussion, so it worked.
"a la akpm"  :)

~Randy

| > whee, an si_swapinfo() maintainer.
|
| That might be me?  I rewrote that code for 2.4.10
| (when you called attention to si_swapinfo slowness).
|
...
|
| It is the right fix; but since that condition was misunderstood,
| and some other flag might be added in future, the safer patch
| would be this more explicit one (which I'll now send to Linus
| with a briefer description).
|
| But I hope nobody backports this to 2.4, where it would be
| wrong: 2.5.4 confusingly changed the nature of SWP_WRITEOK.
|
| Hugh
|
| --- 2.5.8-pre3/mm/swapfile.c	Mon Mar 11 12:30:56 2002
| +++ linux/mm/swapfile.c	Thu Apr 11 15:26:51 2002
| @@ -1095,7 +1095,8 @@
|  	swap_list_lock();
|  	for (i = 0; i < nr_swapfiles; i++) {
|  		unsigned int j;
| -		if (!(swap_info[i].flags & SWP_USED))
| +		if (!(swap_info[i].flags & SWP_USED) ||
| +		     (swap_info[i].flags & SWP_WRITEOK))
|  			continue;
|  		for (j = 0; j < swap_info[i].max; ++j) {
|  			switch (swap_info[i].swap_map[j]) {

