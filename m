Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVIVH55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVIVH55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbVIVH55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:57:57 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:44160 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S1030230AbVIVH5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:57:55 -0400
Message-ID: <433264AF.5060800@mysql.com>
Date: Thu, 22 Sep 2005 10:00:47 +0200
From: Jonas Oreland <jonas@mysql.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ray Bryant <raybry@mpdtxmail.amd.com>
CC: Andi Kleen <ak@suse.de>, Daniel Jacobowitz <dan@debian.org>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] x86-64: Fix bad assumption that dualcore
 cpus have synced TSCs
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <200509211015.09356.raybry@mpdtxmail.amd.com> <20050921150404.GD12810@verdi.suse.de> <200509211046.25555.raybry@mpdtxmail.amd.com>
In-Reply-To: <200509211046.25555.raybry@mpdtxmail.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant wrote:
> On Wednesday 21 September 2005 10:04, Andi Kleen wrote:
> 
> 
>>We handle this, but single socket dual core was special cased because
>>I was told previously it should be ok.
>>
>>-Andi
> 
> 
> AFAIK there is a processor state bit that enables/disables this behavior.
> Apparently some BIOS's are setting this one way for desktop systems and the 
> other way for servers.   If it is thought to be important I can track that 
> down and see if it can be externally documented.  (It may actually be in the 
> bios and kernel developer guide...)
> 

Hi,

This would be very good (for us single socket dual core users)
I tried a very small benchmark:

clock_gettime(CLOCK_REALTIME): elapsed 7336657 -> 733.665700ns/call
clock_gettime(CLOCK_PROCESS_CPUTIME_ID): elapsed 763247 -> 76.324700ns/call

It's a factor 10 faster if the TSC were to be in sync.

/Jonas
