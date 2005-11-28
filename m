Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVK1XaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVK1XaG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 18:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVK1XaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 18:30:06 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:7443 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932284AbVK1XaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 18:30:05 -0500
Message-ID: <438B92FB.4060805@vmware.com>
Date: Mon, 28 Nov 2005 15:30:03 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org> <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org> <438B600C.1050604@tmr.com> <438B827A.2090609@wolfmountaingroup.com> <438B8BF8.4020604@vmware.com> <438B8DC6.8070006@zytor.com>
In-Reply-To: <438B8DC6.8070006@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Nov 2005 23:30:03.0061 (UTC) FILETIME=[A8385E50:01C5F473]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> Zachary Amsden wrote:
>
>>
>> You need a way to type the lock semantics by memory region, and a 
>> working hardware solution can not perform as well as a careful 
>> software solution.  As was pointed out earlier, you can't use memory 
>> type attributes to infer lock semantics, you must assume them in the 
>> decoder or implement complex deadlock detection and recovery in silicon.
>>
>
> Sure you can.  You just have to be prepared to take a microop 
> exception if you speculate incorrectly.


I spoke silicon too heavy handedly.  The complexity of the issue 
disappears if you take an exception, but rewinding state prior to the 
exception and reissuing is going to be less efficient than getting it 
right the first time, which is something software can always guarantee.  
You need to add more hardware for prediction to get it right all the 
time, and it is not clear the cost of that hardware is justified when 
software can always do the right thing.

Zach
