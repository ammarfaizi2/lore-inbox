Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbUJYUAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbUJYUAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUJYTzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:55:16 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:6385 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261279AbUJYTud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:50:33 -0400
Message-ID: <417D5903.6090106@acm.org>
Date: Mon, 25 Oct 2004 14:50:27 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all
 kernels
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel> <p73u0sik2fa.fsf@verdi.suse.de>
In-Reply-To: <p73u0sik2fa.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to the comments in 2.4, this code causes the NMI to be 
re-asserted if another NMI occurred while the NMI handler was running.  
I have no idea how twiddling with these CMOS registers causes this to 
happen, but that is supposed to be the intent.  I don't think it has 
anything to do with delays.

I would like to know what this code really does before removing it.

-Corey

Andi Kleen wrote:

>Corey Minyard <minyard@acm.org> writes:
>
>  
>
>>I had a customer on x86 notice that sometimes offset 0xf in the CMOS
>>RAM was getting set to invalid values.  Their BIOS used this for
>>information about how to boot, and this caused the BIOS to lock up.
>>
>>They traced it down to the following code in arch/kernel/traps.c (now
>>in include/asm-i386/mach-default/mach_traps.c):
>>
>>    outb(0x8f, 0x70);
>>    inb(0x71);              /* dummy */
>>    outb(0x0f, 0x70);
>>    inb(0x71);              /* dummy */
>>    
>>
>
>Just use a different dummy register, like 0x80 which is normally used
>for delaying IO (I think that is what the dummy access does) 
>
>But I'm pretty sure this NMI handling is incorrect anyways, its
>use of bits doesn't match what the datasheets say of modern x86
>chipsets say. Perhaps it would be best to just get rid of 
>that legacy register twiddling completely.
>
>I will also remove it from x86-64.
>
>-Andi
>  
>

