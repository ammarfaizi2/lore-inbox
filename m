Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUIPBqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUIPBqL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 21:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUIPBqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 21:46:11 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:64115 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261169AbUIPBqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 21:46:06 -0400
Message-ID: <4148F059.9060100@yahoo.com.au>
Date: Thu, 16 Sep 2004 11:46:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@drdos.com>
CC: jmerkey@galt.devicelogics.com, linux-kernel@vger.kernel.org,
       jmerkey@comcast.net
Subject: Re: 2.6.8.1 mempool subsystem sickness
References: <091420042058.15928.41475B8000002BA100003E382200763704970A059D0A0306@comcast.net> <4147555C.7010809@drdos.com> <414777EA.5080406@yahoo.com.au> <20040914223122.GA3325@galt.devicelogics.com> <41478419.3020606@yahoo.com.au> <41487B6D.1080202@drdos.com>
In-Reply-To: <41487B6D.1080202@drdos.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Nick Piggin wrote:

>> OK, this is against 2.6.9-rc2. Let me know how you go. Thanks
>>
>>  
>>
> 
> Nick,
> 
> The problem is corrected with this patch.  I am running with 3GB of 
> kernel memory
> and 1GB user space with the userspace splitting patch with very heavy 
> swapping
> and user space app activity and no failed allocations.  This patch 
> should be rolled
> into 2.6.9-rc2 since it fixes the problem.  With standard 3GB User/1GB 
> kernel
> address space, it also fixes the problems with X server running out of 
> memory
> and the apps crashing.
> 

Hi Jeff,
Thanks, that is very cool. The memory problems you're seeing aren't
actually a regression (it's always been like that), and I still haven't
got hold of some gigabit networking hardware to test it thoroughly, so
as such so it may be difficult to get this into 2.6.9. Hopefully soon
though.

I can provide you (or anyone) with up to date patches on request though,
so just let me know.

> Jeff
> 
> Here's the stats from the test of the patch against 2.6.8-rc2 with the 
> patch applied
> 
> 

Scanning stats look good at a quick glance. kswapd doesn't seem to be
going crazy.

However,
size-65536         32834  32834  65536    1   16

This slab entry is taking up about 2GB of unreclaimable memory (order-4,
no less). This must be a leak... does the number continue to rise as
your system runs?
