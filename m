Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVIMKM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVIMKM0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 06:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVIMKM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 06:12:26 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:58026 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1750714AbVIMKMZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 06:12:25 -0400
Date: Tue, 13 Sep 2005 12:12:22 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, davem@redhat.com, sparclinux@vger.kernel.org,
       aurora-sparc-devel@lists.auroralinux.org
Subject: Re: [2.6.13-rc6-git13/sparc64]: Slab corruption (possible stack or
 buffer-cache corruption)
In-Reply-To: <20050912.161326.131841878.davem@davemloft.net>
Message-ID: <Pine.BSO.4.62.0509131148020.5000@rudy.mif.pg.gda.pl>
References: <Pine.BSO.4.62.0509121604360.5000@rudy.mif.pg.gda.pl>
 <20050912.161326.131841878.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1758999652-1126606342=:5000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1758999652-1126606342=:5000
Content-Type: TEXT/PLAIN; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 12 Sep 2005, David S. Miller wrote:

> From: Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>
> Date: Mon, 12 Sep 2005 16:37:04 +0200 (CEST)
>
>> On first it looks like stack or buffer-cache corruption.
>>
>>   Slab corruption: (Not tainted) start=fffff8005d9be708, len=808
>>   Redzone: 0x5a2cf071/0x5a2cf071.
>>   Last user: [destroy_inode+100/144](destroy_inode+0x64/0x90)
>>   Call Trace:
>>    [00000000004759f4] free_block+0x160/0x1b4
>>    [0000000000475bb8] cache_flusharray+0x98/0x128
>>    [0000000000475704] kmem_cache_free+0x68/0x94
>>    [00000000004a56c4] destroy_inode+0x64/0x90
>
> One way for destroy_inode() to be called twice on the same
> inode would be if atomic_dec_and_test() was buggy in some way.
> I think it might be on sparc64.
>
> Therefore, would you mind giving this patch a test?

I will. Thanks.

Dave I have next thing.
In kernel 2.6.13-rc6-git13 I observe relative very intensive emmiting some 
kernel messages. From yesterday logs:

# grep "^Sep 12" /var/log/messages | grep kernel: | uniq | cut -d " " -f 6- | sort | uniq -c | sort -n | tail -n 2
     509 svc: bad direction 268435456, dropping request
     653 eth0: Happy Meal out of receive descriptors, packet dropped.

As you see one of this two messagess occures avarange one time per ~two 
minutes.
Second looks like some error in sunhme.c. eth0 it is:

0001:00:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Meal (rev 01)

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1758999652-1126606342=:5000--
