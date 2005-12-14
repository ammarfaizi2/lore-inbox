Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVLNQhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVLNQhV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVLNQhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:37:21 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:30148 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964843AbVLNQhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:37:20 -0500
Message-ID: <43A04A38.6020403@us.ibm.com>
Date: Wed, 14 Dec 2005 08:37:12 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org, Sridhar Samudrala <sri@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/6] Critical Page Pool
References: <439FCECA.3060909@us.ibm.com>	 <20051214100841.GA18381@elf.ucw.cz>  <20051214120152.GB5270@opteron.random> <1134565436.25663.24.camel@localhost.localdomain>
In-Reply-To: <1134565436.25663.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2005-12-14 at 13:01 +0100, Andrea Arcangeli wrote:
> 
>>On Wed, Dec 14, 2005 at 11:08:41AM +0100, Pavel Machek wrote:
>>
>>>because reserved memory pool would have to be "sum of all network
>>>interface bandwidths * ammount of time expected to survive without
>>>network" which is way too much.
>>
>>Yes, a global pool isn't really useful. A per-subsystem pool would be
>>more reasonable...
> 
> 
> 
> The whole extra critical level seems dubious in itself. In 2.0/2.2 days
> there were a set of patches that just dropped incoming memory on sockets
> when the memory was tight unless they were marked as critical (ie NFS
> swap). It worked rather well. The rest of the changes beyond that seem
> excessive.

Actually, Sridhar's code (mentioned earlier in this thread) *does* drop
incoming packets that are not 'critical', but unfortunately you need to
completely copy the packet into kernel memory before you can do any
processing on it to determine whether or not it's 'critical', and thus
accept or reject it.  If network traffic is coming in at a good clip and
the system is already under memory pressure, it's going to be difficult to
receive all these packets, which was the inspiration for this patchset.

Thanks!

-Matt
