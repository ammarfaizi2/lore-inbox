Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWB1AZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWB1AZM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWB1AZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:25:11 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:2411 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751803AbWB1AZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:25:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=6w7xcDBAN5mjaNupQ9nsPwLB1vMoEFGuXCRzrC74lv6JZqc4obMj7wiIxN29+wuCp8NzYkU134T/Gc938xFVyMOHg8lOTxa5IfmLkb2kea7d3yHjgKeQ/9vsRAY49WM1t+PWsAaUK3YQ39W98z1OtK+6PPCoNt5e4DNNjRX+0u0=  ;
Message-ID: <44039860.8090708@yahoo.com.au>
Date: Tue, 28 Feb 2006 11:25:04 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: nagar@watson.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 2/7] Add sysctl for schedstats
References: <1141026996.5785.38.camel@elinux04.optonline.net>	 <1141027367.5785.42.camel@elinux04.optonline.net>	 <1141027923.5785.50.camel@elinux04.optonline.net>	 <4402C3BB.7010705@yahoo.com.au> <1141067382.4770.699.camel@linuxchandra>
In-Reply-To: <1141067382.4770.699.camel@linuxchandra>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:

>On Mon, 2006-02-27 at 20:17 +1100, Nick Piggin wrote:
>
>>> #ifdef CONFIG_SCHEDSTATS
>>>+
>>>+int schedstats_sysctl = 0;		/* schedstats turned off by default */
>>>
>>Should be read mostly.
>>
>>
>>>+static DEFINE_PER_CPU(int, schedstats) = 0;
>>>+
>>>
>>When the above is in the read mostly section, you won't need this at all.
>>
>>You don't intend to switch the sysctl with great frequency, do you?
>>
>
>No, it is not expected to switch often.
>
>We originally coded it as __read_mostly, but thought the variable
>bouncing between CPUs would be costly. Is it cheaper with
>__read_mostly ? or it doesn't matter ?
>
>

Well it will only "bounce" when the cacheline it is in is written to by
a different CPU. Considering this happens with your per-cpu implementation
_anyway_, they don't buy you anything much.

Putting it in __read_mostly means that you won't happen to share a cacheline
with a variable that is being written to frequently.

Nick

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
