Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbUDMS2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 14:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUDMS2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 14:28:46 -0400
Received: from GD-AIS-15.vaal02.veridian.com ([137.100.126.15]:35040 "EHLO
	lovok.psrw.com") by vger.kernel.org with ESMTP id S263582AbUDMS2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 14:28:32 -0400
Message-ID: <407C2FF7.4010500@gd-ais.com>
Date: Tue, 13 Apr 2004 14:22:47 -0400
From: Chris Lalancette <chris.lalancette@gd-ais.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031031
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pmarques@grupopie.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory image save/restore
References: <407C18D0.9010302@gd-ais.com> <407C1D4F.4060706@grupopie.com>
In-Reply-To: <407C1D4F.4060706@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo,
    Thanks for responding.  You are right in that the state of memory 
isn't the state of the entire machine; however, for instance, the 
swsusp2 project can save the contents of memory out to disk, go to 
sleep, and then resume to it later.  Basically, what I am trying to do 
is something like swsusp2, with less restrictions; I know I have another 
region the size of physical memory to work with, I know I am executing 
from an interrupt handler, and at the end I don't want to go to sleep, 
just continue on.  Then I might want to use that memory image later.

Thanks,
Chris Lalancette

pmarques@grupopie.com wrote:

> Chris Lalancette wrote:
>
>> Hello all,
>>
>>    I have been trying to implement some sort of save/restore kernel 
>> memory image for the linux kernel (x86 only right now), without much 
>> success.  Let me explain the situation:
>>
>> I have a hardware device that I can generate interrupts with.  I also 
>> have a machine with 512M of memory, and I am passing the kernel the 
>> command line mem=256M.  My idea is to generate an interrupt with the 
>> hardware device, and then inside of the interrupt handler make a copy 
>> of the entire contents of RAM into the unused upper 256M of memory; 
>> later on, with another interrupt, I would like to restore that 
>> previously saved memory image.  This way we can go "back in time", 
>> similar to what software suspend is doing, but without as many 
>> constraints (i.e. we have a hardware interrupt to work with, we 
>> reserved the same amount of physical memory to use, etc.).  Before I 
>> went much further, I figured I would ask if anyone on the list has 
>> tried this, and if there are any reasons why this is not possible.
>
>
> You're assuming that the state of the memory is the *state* of the 
> entire system.
>
> This fails because there is a lot of state information in hardware 
> registers, external peripheral devices, etc., etc.
>


