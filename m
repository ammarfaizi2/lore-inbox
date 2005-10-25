Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbVJYBnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVJYBnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 21:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVJYBnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 21:43:09 -0400
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:7848 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751378AbVJYBnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 21:43:07 -0400
Message-ID: <435D8DA9.4030200@bigpond.net.au>
Date: Tue, 25 Oct 2005 11:43:05 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.14-rc5-mm1 build fails for non SMP systems
References: <435D8675.3080303@bigpond.net.au>
In-Reply-To: <435D8675.3080303@bigpond.net.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 25 Oct 2005 01:43:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Without CONFIG_DEBUG_SPINLOCK configured in I'm getting a large number 
> of "implicit declaration of function ‘__raw_read_unlock’" warnings and a 
> subsequent failure at the link stage.
> 
> A trivial change to include/linux/spinlock_up.h (i.e. moving the 
> definition of __raw_read_unlock() outside the ifdef) can get rid of this 
> warning but I'm not sure that it's the right thing to do as I suspect 
> this may be an indication of a less trivial problem elsewhere.

Further investigation reveals a number of similar warnings for 
__raw_write_unlock() and the following failure in the ipv4 code:

In file included from 
/home/peterw/wrk/PlugSched/MM-2.6.14/include/linux/mroute.h:130,
                  from 
/home/peterw/wrk/PlugSched/MM-2.6.14/net/ipv4/route.c:90:
/home/peterw/wrk/PlugSched/MM-2.6.14/include/net/sock.h: In function 
‘sk_dst_get’:
/home/peterw/wrk/PlugSched/MM-2.6.14/include/net/sock.h:972: warning: 
implicit declaration of function ‘__raw_read_unlock’
/home/peterw/wrk/PlugSched/MM-2.6.14/include/net/sock.h: In function 
‘sk_dst_set’:
/home/peterw/wrk/PlugSched/MM-2.6.14/include/net/sock.h:991: warning: 
implicit declaration of function ‘__raw_write_unlock’
/home/peterw/wrk/PlugSched/MM-2.6.14/net/ipv4/route.c: In function 
‘rt_check_expire’:
/home/peterw/wrk/PlugSched/MM-2.6.14/net/ipv4/route.c:663: warning: 
dereferencing ‘void *’ pointer
/home/peterw/wrk/PlugSched/MM-2.6.14/net/ipv4/route.c:663: error: 
request for member ‘raw_lock’ in something not a structure or union
make[3]: *** [net/ipv4/route.o] Error 1
make[2]: *** [net/ipv4] Error 2
make[1]: *** [net] Error 2
make: *** [_all] Error 2

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
