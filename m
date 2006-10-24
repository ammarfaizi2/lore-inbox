Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWJXMD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWJXMD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWJXMD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:03:26 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:56624 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1030391AbWJXMD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:03:26 -0400
Message-ID: <453E0108.3080502@qumranet.com>
Date: Tue, 24 Oct 2006 14:03:20 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/13] KVM: virtualization infrastructure
References: <453CC390.9080508@qumranet.com> <200610232135.02684.arnd@arndb.de> <453D2604.5010208@qumranet.com> <200610232235.29287.arnd@arndb.de>
In-Reply-To: <200610232235.29287.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2006 12:03:25.0324 (UTC) FILETIME=[68C614C0:01C6F764]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Monday 23 October 2006 22:28, Avi Kivity wrote:
>
>   
>>>> +struct segment_descriptor {
>>>> +    u16 limit_low;
>>>> +    u16 base_low;
>>>> +    u8  base_mid;
>>>> +    u8  type : 4;
>>>> +    u8  system : 1;
>>>> +    u8  dpl : 2;
>>>> +    u8  present : 1;
>>>> +    u8  limit_high : 4;
>>>> +    u8  avl : 1;
>>>> +    u8  long_mode : 1;
>>>> +    u8  default_op : 1;
>>>> +    u8  granularity : 1;
>>>> +    u8  base_high;
>>>> +} __attribute__((packed));
>>>>    
>>>>         
>>> Bitfields are generally frowned upon. It's better to define
>>> constants for each of these and use a u64.
>>>       
>> Any specific reasons?  I find the code much more readable (and
>> lowercase) with bitfields.
>>     
>
> The strongest reason against bitfields is that they are not
> endian-clean. This doesn't apply on a architecture-specific
> patch such as KVM, but it just feels wrong to read code
> with bit fields in the kernel.
>
>   

This structure is suspiciously similar to struct desc_struct in 
asm-x86_64/desc.h.

However, I can't use it because asm-i386/desc.h does not have a similar 
definition.


Andi, will you accept a patch to move it to asm-i386/desc_defs.h so it 
can be used in both archs?

-- 
error compiling committee.c: too many arguments to function

