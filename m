Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTLCXkC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTLCXkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:40:02 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:42762 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S262747AbTLCXhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:37:12 -0500
Message-ID: <3FCE7569.5080305@techsource.com>
Date: Wed, 03 Dec 2003 18:44:41 -0500
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Fix locking in input
References: <3FC13382.3060701@colorfullife.com> <20031123223443.A560@flint.arm.linux.org.uk> <3FC13AA0.9030204@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Manfred Spraul wrote:
> Russell King wrote:
> 
>> On Sun, Nov 23, 2003 at 11:24:02PM +0100, Manfred Spraul wrote:
>>  
>>
>>> I think one platform (early ARM?) cannot access bytes directly, and 
>>> implement the access with read 16-bit, change 8-bit, write back 16 
>>> bit.   
>>
>>
>> Nope.
>>
> It seems it's Alpha:
> 
> On Thu, 28 Dec 2000, Linus wrote:
> 
>> FreeBSD doesn't try to be portable any more, but Linux does, and there 
>> are
>> architectures where 8- and 16-bit accesses aren't *atomic* but have to be
>> done with read-modify-write cycles.
>>
>> And even for fields like "age", where we don't care whether the age 
>> itself
>> is 100% accurate, we _do_ care that the fields close-by don't get strange
>> effects from updating "age". We used to have exactly this problem on 
>> alpha
>> back in the 2.1.x timeframe.
>>


This is MOSTLY true, but not entirely.  As I recall, Alpha has two 
addressing modes: Sparse and Dense.

The mode you're referring to is dense addressing where 32-bit and 64-bit 
accesses are atomic, but 16 and 8 bit accesses require RMW.

Sparse mode allows for atomic 8 and 16 bit accesses, but the access size 
is specified in the address using a rather bizarre binary encoding that 
doesn't look much like a regular address value.  You would probably not 
want to use this unless you absolutely HAD to use some I/O device that 
required atomic byte or word accesses.

I'm sure someone else will (or already has) pipe(d) in with a more 
accurate explanation.  :)


