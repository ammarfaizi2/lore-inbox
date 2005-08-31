Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVHaWgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVHaWgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVHaWgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:36:36 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:62477 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964962AbVHaWgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:36:36 -0400
Message-ID: <431630EE.2050809@vmware.com>
Date: Wed, 31 Aug 2005 15:36:30 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, s0348365@sms.ed.ac.uk,
       kernel@kolivas.org, tytso@mit.edu, cfriesen@nortel.com,
       rlrevell@joe-job.com, trenn@suse.de, george@mvista.com,
       johnstul@us.ibm.com, akpm@osdl.org, Tim Mann <mann@vmware.com>
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick calculation
 in timer_pm.c
References: <20050831165843.GA4974@in.ibm.com> <20050831171211.GB4974@in.ibm.com>
In-Reply-To: <20050831171211.GB4974@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2005 22:36:37.0218 (UTC) FILETIME=[729FCC20:01C5AE7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:

>On Wed, Aug 31, 2005 at 10:28:43PM +0530, Srivatsa Vaddagiri wrote:
>  
>
>>Following patches related to dynamic tick are posted in separate mails,
>>for convenience of review. The first patch probably applies w/o dynamic
>>tick consideration also.
>>
>>Patch 1/3  -> Fixup lost tick calculation in timer_pm.c
>>    
>>
>
>Currently, lost tick calculation in timer_pm.c is based on number
>of microseconds that has elapsed since the last tick. Calculating
>the number of microseconds is approximated by cyc2us, which
>basically does :
>
>	microsec = (cycles * 286) / 1024
>
>Consider 10 ticks lost. This amounts to 14319*10 = 143190 cycles 
>(14319 = PMTMR_EXPECTED_RATE/(CALIBRATE_LATCH/LATCH)).
>This amount to 39992 microseconds as per the above equation 
>or 39992 / 4000 = 9 lost ticks, which is incorrect.
>
>I feel lost ticks can be based on cycles difference directly
>rather than being based on microseconds that has elapsed.
>
>Following patch is in that direction. 
>
>With this patch, time had kept up really well on one particular
>machine (Intel 4way Pentium 3 box) overnight, while
>on another newer machine (Intel 4way Xeon with HT) it didnt do so
>well (time sped up after 3 or 4 hours). Hence I consider this
>particular patch will need more review/work.
>
>  
>

Does this patch help address the issues pointed out here?

http://bugzilla.kernel.org/show_bug.cgi?id=5127
