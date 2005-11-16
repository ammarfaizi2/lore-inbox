Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbVKPQCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbVKPQCs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbVKPQCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:02:48 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:58832 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030379AbVKPQCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:02:47 -0500
Message-ID: <437B5801.4010204@jp.fujitsu.com>
Date: Thu, 17 Nov 2005 01:02:09 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] Re: 2.6.14-mm2
References: <20051110203544.027e992c.akpm@osdl.org>	 <437B2C82.6020803@jp.fujitsu.com> <1132147036.7915.19.camel@localhost>
In-Reply-To: <1132147036.7915.19.camel@localhost>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

> 
> Can you explain in a little bit more detail why this matters, and
> exactly how it fixes your problem.  I'm not sure it's correct.
> 
Ah, okay.

It's just because free_area[] is not initaialized at all if this is not called.
It is list.next and list.prev has bad value.
Then, the first free_page(page) will cause panic.

> Also, if you're doing hot-adds of _new_ zones at runtime, you need to do
> something fancy with the zonelist locking that I never got around to
> because nobody needs it yet.  See something along these lines:
> 
When node 0's higmem size is 0 at boot time, I have to add new page into empty zone.
This happens because my machine has only 700M mem.
I use mem=500M and hot add extra 200M memory for testing.

"Nobody needs " is sane in real world. But it's useful to my tiny test enveironment.

Could you spin out initializing free_area[] from
init_currently_empty_zone(zone, zone_start_pfn, size);
Then I'll be happy.

-- Kame
> http://www.sr71.net/patches/2.6.14/2.6.14-rc2-git8-mhp1/broken-out/E2-for-debugging-handle-add-to-empty-zone.patch
> 
> -- Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


