Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVCVVVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVCVVVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVCVVVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:21:12 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:43714 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261972AbVCVVUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:20:54 -0500
Message-ID: <42408D97.7000806@tmr.com>
Date: Tue, 22 Mar 2005 16:26:47 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: "J.A. Magallon" <jamagallon@able.es>, Dan Maas <dmaas@maasdigital.com>,
       linux-kernel@vger.kernel.org, tmv@comcast.net
Subject: Re: Distinguish real vs. virtual CPUs?
References: <88056F38E9E48644A0F562A38C64FB600448EE27@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB600448EE27@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
>  
> 
> 
>>This is 2xXeonHT, is, 4 cpus on 2 packages:
>>
>>cat /proc/cpuinfo:
>>
>>processor	: 0
>>...
>>physical id	: 0
>>siblings	: 2
>>core id		: 0
>>cpu cores	: 1
>>
>>processor	: 1
>>...
>>physical id	: 0
>>siblings	: 2
>>core id		: 0
>>cpu cores	: 1
>>
>>processor	: 2
>>...
>>physical id	: 3
>>siblings	: 2
>>core id		: 3
>>cpu cores	: 1
>>
>>processor	: 3
>>...
>>physical id	: 3
>>siblings	: 2
>>core id		: 3
>>cpu cores	: 1
>>
>>So something like:
>>
>>cat /proc/cpuinfo | grep 'core id' | uniq | wc -l
>>
>>would give you the number of packages or 'real cpus'. Then you have to
>>choose which ones are unrelated. Usually evens are siblings of 
>>odds, but
>>I won't trust on it...
>>
> 
> 
> Number of unique physical id will tell you the number of physical CPU
> packages in the system.

For some Intel processors... Tom Vier just posted his cpuinfo which 
shows all of his processors, which he notes are in separate sockets, are 
identified as physical zero. I didn't find any Intel systems which 
lacked unique physical ID, but clearly that's not true everywhere.

It's not clear if that's bizarre practice on AMD system boards or if 
it's mis-reported. Of course Tom may be running a NUMA setup, in which 
case I won't guess what's expected to be displayed. I've added him to 
the CC list, in hopes of comment.

> Number of unique core id will tell you the total number of CPU cores in
> the system.
> Number of processor will tell you the total number of logical CPUs on
> the system.
> 
> Then to find out the matching pairs, 
> - to pair up all HT siblings on a core: Processors that have same "core
> id" are HT siblings in a core.
> - to pair up all CPUs in a package: Processors that have same "physical
> id" are all the CPUs belonging to the same physical package.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
