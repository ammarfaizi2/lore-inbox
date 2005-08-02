Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVHBAEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVHBAEg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 20:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVHBAEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 20:04:36 -0400
Received: from [62.206.217.67] ([62.206.217.67]:61626 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261374AbVHBAD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 20:03:58 -0400
Message-ID: <42EEB86F.1090808@trash.net>
Date: Tue, 02 Aug 2005 02:03:59 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: Josip Loncaric <josip@lanl.gov>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] net/sunrpc: fix time conversion error
References: <42EE9014.7080205@lanl.gov> <20050801225643.GA4285@us.ibm.com>
In-Reply-To: <20050801225643.GA4285@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan wrote:
> On 01.08.2005 [15:11:48 -0600], Josip Loncaric wrote:
> 
>>Line 589 of linux-2.6.11.10/net/sunrpc/svcsock.c is obviously wrong:
>>
>>                skb->stamp.tv_usec = xtime.tv_nsec * 1000;
>>
>>To convert nsec to usec, one should divide instead of multiplying:
>>
>>                skb->stamp.tv_usec = xtime.tv_nsec / 1000;
>>
>>The same bug could be present in the latest kernels, although I haven't 
>>checked.  This bug makes svc_udp_recvfrom() timestamps incorrect.
> 
> 
> Agreed, the conversion is wrong. I think the code is buggy period, as it
> accesses xtime without grabbing the xtime_lock first. Following patch
> should fix both issues.
> 
> Description: This function incorrectly multiplies a nanosecond value by
> 1000, instead of dividing by 1000, to obtain a corresponding microsecond
> value. Fix the math. Also, the function incorrectly accesses xtime
> without using the xtime_lock. Fixed as well. Patch is compile-tested.

Depending on in which release you want this patch included, you might
want to redo it against Dave's net-2.6.14 tree. It includes a patch that
changes skb->stamp to an offset against a base timestamp.

Regards
Patrick

PS: I'll submit the patch to break compilation for unconverted users
ASAP.
