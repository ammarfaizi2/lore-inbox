Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265223AbUELUpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbUELUpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUELUpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:45:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61065 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263734AbUELUo4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:44:56 -0400
Message-ID: <40A28CB9.1040908@pobox.com>
Date: Wed, 12 May 2004 16:44:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mingo@elte.hu, davidel@xmailserver.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
References: <20040512020700.6f6aa61f.akpm@osdl.org>	<20040512181903.GG13421@kroah.com>	<40A26FFA.4030701@pobox.com>	<20040512193349.GA14936@elte.hu>	<Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>	<20040512200305.GA16078@elte.hu>	<20040512132050.6eae6905.akpm@osdl.org>	<40A28815.2020009@pobox.com> <20040512133520.44fbfd39.akpm@osdl.org>
In-Reply-To: <20040512133520.44fbfd39.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>>How about we do:
>>
>> > 
>> > #if HZ=1000
>> > #define	MSEC_TO_JIFFIES(msec) (msec)
>> > #define JIFFIES_TO_MESC(jiffies) (jiffies)
>> > #elif HZ=100
>> > #define	MSEC_TO_JIFFIES(msec) (msec * 10)
>> > #define JIFFIES_TO_MESC(jiffies) (jiffies / 10)
>> > #else
>> > #define	MSEC_TO_JIFFIES(msec) ((HZ * (msec) + 999) / 1000)
>> > #define	JIFFIES_TO_MSEC(jiffies) ...
>> > #endif
>> > 
>> > in some kernel-wide header then kill off all the private implementations?
>>
>>
>> include/linux/time.h.  One of the SCTP people already did this, but I 
>> suppose it's straightforward to reproduce.
> 
> 
> OK, I'll do it.


Thanks.  'grep -i msec.*jif' and 'grep -i jif.*msec' should catch most, 
there are occurences in both upper and lower case.

Note that a few oddball drivers include an addition to the kernel-wide 
'jiffies' variable, rather than just doing a calculation scaling against HZ.

	Jeff



