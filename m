Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262950AbVCWXvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbVCWXvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVCWXte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:49:34 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:54932 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262950AbVCWXtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:49:06 -0500
Message-ID: <4242006E.4090408@us.ibm.com>
Date: Wed, 23 Mar 2005 15:49:02 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, aebr@win.tue.nl, cmm@us.ibm.com,
       andrea@suse.de, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: OOM problems on 2.6.12-rc1 with many fsx tests
References: <20050315204413.GF20253@csail.mit.edu>	<20050316003134.GY7699@opteron.random>	<20050316040435.39533675.akpm@osdl.org>	<20050316183701.GB21597@opteron.random>	<1111607584.5786.55.camel@localhost.localdomain>	<20050323144953.288a5baf.akpm@osdl.org>	<17250000.1111619602@flay>	<20050323152055.6fc8c198.akpm@osdl.org>	<20050323232656.GA5704@pclin040.win.tue.nl>	<25760000.1111620606@flay> <20050323154232.376f977f.akpm@osdl.org>
In-Reply-To: <20050323154232.376f977f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> 
>>>>Nothing beats poking around in a dead machine's guts with kgdb though.
>>>
>>>Everyone his taste.
>>>
>>>But I was surprised by
>>>
>>>
>>>>SwapTotal:     1052216 kB
>>>>SwapFree:      1045984 kB
>>>
>>>Strange that processes are killed while lots of swap is available.
>>
>>I don't think we're that smart about it. If we're really low on mem, it
>>seems we invoke the OOM killer whether processes are causing the problem
>>or not. 
>>
>>OTOH, if we can't free the kernel mem, we don't have much choice, but 
>>it's not really helping much ;-)
>>
> 
> 
> I'm suspecting here that we simply leaked a refcount on every darn
> pagecache page in the machine.  Note how mapped memory has shrunk down to
> less than a megabyte and everything which can be swapped out has been
> swapped out.

That makes sense. We have almost 485MB in active and inactive caches,
but we are not able reclai them :(

Active:         243580 kB
Inactive:       242248 kB

> 
> If so, then oom-killing everything in the world is pretty inevitable.
> 


