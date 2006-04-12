Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWDLIV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWDLIV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 04:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWDLIV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 04:21:58 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:11581 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932103AbWDLIV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 04:21:57 -0400
Message-ID: <443CBA48.7020301@sw.ru>
Date: Wed, 12 Apr 2006 12:28:56 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: Herbert Poetzl <herbert@13thfloor.at>, devel@openvz.org,
       Kir Kolyshkin <kir@sacred.ru>, linux-kernel@vger.kernel.org
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>	 <1143228339.19152.91.camel@localhost.localdomain>	 <4428BB5C.3060803@tmr.com> <4428DB76.9040102@openvz.org>	 <1143583179.6325.10.camel@localhost.localdomain>	 <4429B789.4030209@sacred.ru>	 <1143588501.6325.75.camel@localhost.localdomain>	 <442A4FAA.4010505@openvz.org> <20060329134524.GA14522@MAIL.13thfloor.at>	 <442A9E1E.4030707@sw.ru> <1143668273.9969.19.camel@localhost.localdomain>
In-Reply-To: <1143668273.9969.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

> Ok, I'll call those three VPSes fast, faster and fastest.
> 
> "fast"    : fill rate 1, interval 3
> "faster"  : fill rate 2, interval 3
> "fastest" : fill rate 3, interval 3
> 
> That all adds up to a fill rate of 6 with an interval of 3, but that is
> right because with two processors you have 2 tokens to allocate per
> jiffie.  Also set the bucket size to something of the order of HZ.
> 
> You can watch the processes within each vserver's priority jump up and
> down with `vtop' during testing.  Also you should be able to watch the
> vserver's bucket fill and empty in /proc/virtual/XXX/sched (IIRC)
> 
> I mentioned this earlier, but for the sake of the archives I'll repeat -
> if you are running with any of the buckets on empty, the scheduler is
> imbalanced and therefore not going to provide the exact distribution you
> asked for.
> 
> However with a single busy loop in each vserver I'd expect the above to
> yield roughly 100% for fastest, 66% for faster and 33% for fast, within
> 5 seconds or so of starting those processes (assuming you set a bucket
> size of HZ).

Sam, what we observe is the situation, when Linux cpu scheduler spreads 
2 tasks on 1st CPU and 1 task on the 2nd CPU. Std linux scheduler 
doesn't do any rebalancing after that, so no plays with tokens make the 
spread to be 3:2:1, since the lowest priority process gets a full 2nd 
CPU (100% instead of 33% of CPU).

Where is my mistake? Can you provide a configuration where we could test 
or the instuctions on how to avoid this?

Thanks,
Kirill

