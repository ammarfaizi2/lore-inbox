Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270570AbUJUFCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270570AbUJUFCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270604AbUJUE6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 00:58:31 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:16817 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270570AbUJUEyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 00:54:01 -0400
Message-ID: <417740E5.9010903@yahoo.com.au>
Date: Thu, 21 Oct 2004 14:53:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: andrea@novell.com, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
References: <20041021011714.GQ24619@dualathlon.random>	<417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org>
In-Reply-To: <20041020213622.77afdd4a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>> #if defined(CONFIG_SMP)
>>
>> >  struct zone_padding {
>> > -	int x;
>> >  } ____cacheline_maxaligned_in_smp;
>> >  #define ZONE_PADDING(name)	struct zone_padding name;
>> >  #else
>>
>> Perhaps to keep old compilers working? Not sure.
> 
> 
> gcc-2.95 is OK with it.
> 
> Stock 2.6.9:
> 
> 	sizeof(struct zone) = 1920
> 
> With Andrea's patch:
> 
> 	sizeof(struct zone) = 1536
> 
> With ZONE_PADDING removed:
> 
> 	sizeof(struct zone) = 1408
> 	
> 

Wow. You'd probably still want pad1 because that seperates the
allocator and the scanner. It looks like temp/prev_priority
should be _above_ pad2, and possibly free_area should be above
pad1.

Don't know about all the stuff below pad3.
