Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVHRC64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVHRC64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 22:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVHRC64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 22:58:56 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:35249 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932113AbVHRC6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 22:58:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=K9HThu9y9K7fbFwbZs/6aW5DzbmASMhodcdql+ePDcvDtgfvbgs8/frwXz74AvX3TQxcQ4uKZ5oiAfs7Ll4JcHfYxB/lxGdh4+bk20aITBKHQ8ia/kkK0DD/7GnkiTM1x8GmC1Kg5hdRtwJGZAmbunjrgJo+s7n4g5jmHw2bmkE=  ;
Message-ID: <4303F967.6000404@yahoo.com.au>
Date: Thu, 18 Aug 2005 12:58:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Joseph Fannin <jfannin@gmail.com>
CC: Bernardo Innocenti <bernie@develer.com>,
       lkml <linux-kernel@vger.kernel.org>, OpenLDAP-devel@OpenLDAP.org,
       Giovanni Bajo <rasky@develer.com>, Simone Zinanni <simone@develer.com>
Subject: Re: sched_yield() makes OpenLDAP slow
References: <4303DB48.8010902@develer.com> <20050818010703.GA13127@nineveh.rivenstone.net>
In-Reply-To: <20050818010703.GA13127@nineveh.rivenstone.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Fannin wrote:

>On Thu, Aug 18, 2005 at 02:50:16AM +0200, Bernardo Innocenti wrote:
>
>
>>The relative timestamp reveals that slapd is spending 50ms
>>after yielding.  Meanwhile, GCC is probably being scheduled
>>for a whole quantum.
>>
>>Reading the man-page of sched_yield() it seems this isn't
>>the correct behavior:
>>
>>   Note: If the current process is the only process in the
>>   highest priority list at that time, this process will
>>   continue to run after a call to sched_yield.
>>
>
>   The behavior of sched_yield changed for 2.6.  I suppose the man
>page didn't get updated.
>
>

We class the SCHED_OTHER policy as having a single priority, which
I believe is allowed (and even makes good sense, because dynamic
and even nice priorities aren't really well defined).

That also makes our sched_yield() behaviour correct.

AFAIKS, sched_yield should only really be used by realtime
applications that know exactly what they're doing.


Send instant messages to your online friends http://au.messenger.yahoo.com 
